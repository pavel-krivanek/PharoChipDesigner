"
I store information about the silicon chip area of given dimension (width, height). 

I have an Array2D of cells (array). 

I have two layers - substrate and metal. The layers are ""strategies"" that define the behavior of cells.

Regions are groups of connected cells (in a specific layer) of a given state.


"
Class {
	#name : #ChDArea,
	#superclass : #Model,
	#instVars : [
		'width',
		'height',
		'array',
		'substrateLayer',
		'metalLayer',
		'regions',
		'simulation',
		'descriptions',
		'selection',
		'dirty'
	],
	#category : #ChipDesigner
}

{ #category : #geometry }
ChDArea class >> decodeFrom: aString [

	^ (self extent: 1@1) decodeFrom: aString.
]

{ #category : #geometry }
ChDArea class >> extent: aPoint [

	^ self new initializeForExtent: aPoint; yourself
]

{ #category : #geometry }
ChDArea class >> oneByOne [

	^ self extent: 1@1
]

{ #category : #geometry }
ChDArea class >> orGate [

^ (ChDArea decodeFrom: '000040000520041621492014120181040050B00B0000262029040050B00B640850B00B000026204320121620830000620021')
	withTestingVCC
]

{ #category : #geometry }
ChDArea class >> withDefaultExtent [

	^ self extent: 20@20
]

{ #category : #initialization }
ChDArea >> addInputAt: aPoint [

	| cell region |
	cell := self atX: aPoint x y: aPoint y.
	cell metalConnections: 0.
	region := ChDGeneratorRegion new.
	region layer: metalLayer.
	regions add: region.
	cell metalRegion: region.
	region cells add: cell.


]

{ #category : #'tests support' }
ChDArea >> addMetalAt: x y: y addConnections: connectionsInteger [

	| aCell |
	
	aCell := self atX: x y: y.
	self metalLayer setFor: aCell mode: #metal.
	self metalLayer connectionsFor: aCell add: connectionsInteger.
	self markDirty.
	^ aCell

]

{ #category : #'tests support' }
ChDArea >> addNAt: x y: y addConnections: connectionsInteger [

	| aCell |
	
	aCell := self atX: x y: y.
	self substrateLayer setFor: aCell mode: #n.
	self substrateLayer connectionsFor: aCell add: connectionsInteger.
	^ aCell

]

{ #category : #'tests support' }
ChDArea >> addPAt: x y: y addConnections: connectionsInteger [

	| aCell |
	
	aCell := self atX: x y: y.
	self substrateLayer setFor: aCell mode: #n.
	self substrateLayer connectionsFor: aCell add: connectionsInteger.
	^ aCell

]

{ #category : #'cell access' }
ChDArea >> allSubstrateCells [

	^ array privateContents select: [ :each | each hasSubstrate or: [ each hasJunction ] ]
]

{ #category : #'tests support' }
ChDArea >> announceDirtyCells: dirtyCells [ 

	self announcer announce: (ChDDirtyCellsAnnouncement cells: dirtyCells)
]

{ #category : #'cell access' }
ChDArea >> atX: x y: y [

	x < 1 ifTrue: [ ^ ChDStubCell new ].
	y < 1 ifTrue: [ ^ ChDStubCell new ].
	x > self width ifTrue: [ ^ ChDStubCell new ].
	y > self height ifTrue: [ ^ ChDStubCell new ].

	^ array at: y at: x
]

{ #category : #testing }
ChDArea >> canSwitchTo: aClass [ 
	
	| result |
 
	dirty ifFalse: [ ^ true ].
	
	result := self confirm: 'Leave the level withou saving?'.
		
	result = true ifTrue: [ ^ true ].
	
	^ false

	
]

{ #category : #'cell access' }
ChDArea >> cells [ 

	^ array
]

{ #category : #'cell access' }
ChDArea >> cellsIn: aRectangle [

	| result |
	
	result := OrderedCollection new.
	aRectangle topLeft y to: aRectangle bottomRight y do: [ :y |
		aRectangle topLeft x to: aRectangle bottomRight x do: [ :x |
			result add: (self atX: x y: y) ] ].
		
	^ result
]

{ #category : #initialization }
ChDArea >> createSimulation [

	simulation := ChDSimulation new.
	simulation area: self.
]

{ #category : #'cell access' }
ChDArea >> cropRectangle: aRectangle [

	^ Rectangle origin: ((1 max: aRectangle topLeft x) @ (1 max: aRectangle topLeft y)) corner: ((self width min: aRectangle bottomRight x) @ (self height min: aRectangle bottomRight y))	
]

{ #category : #initialization }
ChDArea >> decodeFrom: aString [

	| stream w h s int arrayIndex |
	
	regions := IdentitySet new.
	
	stream := aString readStream.
	
	w := ('16r', (stream next: 5)) asNumber.
	h := ('16r', (stream next: 5)) asNumber.
	
	self initializeForExtent: w@h.
	
	arrayIndex := 1.
	
	[ stream atEnd ] whileFalse: [ 
		s := stream next: 5.
		int := ('16r', s) asNumber.
		(int bitAnd: 1) = 0 
			ifTrue: [ 
				arrayIndex := arrayIndex + ((int bitShiftMagnitude: -1) - 1) ]
			ifFalse: [ 
				(array privateContents at: arrayIndex) decodeFrom: s ].
				arrayIndex := arrayIndex + 1 ].
			
	self recreateMetalRegions.
	self recreateSubstrateRegions.

]

{ #category : #initialization }
ChDArea >> decodeFrom: aString at: aPoint [

	| stream w h s int arrayIndex skippingCellsCount |
	
	regions := IdentitySet new.
	
	stream := aString readStream.
	
	w := ('16r', (stream next: 5)) asNumber.
	h := ('16r', (stream next: 5)) asNumber.
	
"	self initializeForExtent: w@h.
"	
	arrayIndex := 1.
	skippingCellsCount := 0.
	
	aPoint y to: aPoint y+h-1 do: [ :y |
		aPoint x to: aPoint  x+w-1 do: [ :x |
			| cell |
			skippingCellsCount > 0
				ifTrue: [ skippingCellsCount := skippingCellsCount - 1 ]
				ifFalse: [ 		
				cell := self atX: x y: y.
				s := stream next: 5.
				int := ('16r', s) asNumber.
				(int bitAnd: 1) = 0 
					ifTrue: [ 
						skippingCellsCount := (int bitShiftMagnitude: -1)-1 ]
					ifFalse: [ 
						cell decodeFrom: s ].
						arrayIndex := arrayIndex + 1 ] ] ].
				
	self recreateMetalRegions.
	self recreateSubstrateRegions.

]

{ #category : #initialization }
ChDArea >> decodedFromZipString: aString [

	^ self decodeFrom: (ByteString fromByteArray: (aString base64Decoded)) unzipped
]

{ #category : #initialization }
ChDArea >> decodedFromZipString: aString at: aPoint [

	^ self decodeFrom: (ByteString fromByteArray: (aString base64Decoded)) unzipped at: aPoint
]

{ #category : #'cell access' }
ChDArea >> deleteRectangle: aRectangle [

	| cellsToDelete crooppedRectangle |
	
	crooppedRectangle := self cropRectangle: aRectangle.
	
	cellsToDelete := self cellsIn: crooppedRectangle.
	
	cellsToDelete do: [ :aCell |
		self metalLayer fullClear: aCell.
		self updateCell: aCell mode: #metal.
		self substrateLayer fullClear: aCell.
		self updateCell: aCell mode: #n ]
]

{ #category : #'cell access' }
ChDArea >> deleteSelection [

	self deleteRectangle: self selection
]

{ #category : #initialization }
ChDArea >> descriptions [

	^ descriptions
]

{ #category : #'cell access' }
ChDArea >> deselect [ 
	
	selection := nil.
]

{ #category : #'cell access' }
ChDArea >> disconnect: aRectangle [

	"fix the cells so they do not have any connection outside of the defined area. Used for areas created as a copy of a region of another area."
	
	| aCell |
	
	aRectangle left to: aRectangle right do: [ :x |
		aCell := self atX: x y: aRectangle top.
		aCell disconnect: 2r0001.
		aCell := self atX: x y: aRectangle bottom.
		aCell disconnect: 2r0100. ].

	aRectangle top to: aRectangle bottom do: [ :y |
		aCell := self atX: aRectangle left y: y.
		aCell disconnect: 2r1000.
		aCell := self atX: aRectangle right y: y.
		aCell disconnect: 2r0010. ].	
]

{ #category : #'cell access' }
ChDArea >> disconnectBorder: aRectangle [
	
	| aCell croppedRectangle |
	
	croppedRectangle := self cropRectangle: aRectangle.
	
	croppedRectangle left to: croppedRectangle right do: [ :x |
		aCell := self atX: x y: croppedRectangle top-1.
		aCell disconnect: 2r0100.
		aCell := self atX: x y: croppedRectangle top.
		aCell disconnect: 2r0001.
		aCell := self atX: x y: croppedRectangle bottom+1.
		aCell disconnect: 2r0001.
		aCell := self atX: x y: croppedRectangle bottom.
		aCell disconnect: 2r0100. ].

	croppedRectangle top to: croppedRectangle bottom do: [ :y |
		aCell := self atX: croppedRectangle left-1 y: y.
		aCell disconnect: 2r0010.
		aCell := self atX: croppedRectangle left y: y.
		aCell disconnect: 2r1000.
		aCell := self atX: croppedRectangle right+1 y: y.
		aCell disconnect: 2r1000.
		aCell := self atX: croppedRectangle right y: y.
		aCell disconnect: 2r0010. ].	
]

{ #category : #'cell access' }
ChDArea >> downX: x y: y [

	^ self atX: x y: y+1
]

{ #category : #initialization }
ChDArea >> encoded [ 

	^ self encodedRectangle: (Rectangle origin: 1@1 corner: self width@self height).
]

{ #category : #initialization }
ChDArea >> encodedRectangle: aRectangle [
	| emptyCells |
	emptyCells := 0.

	^ String
		streamContents: [ :s | 
			s nextPutAll: (aRectangle width + 1 printPaddedWith: $0 to: 5 base: 16).
			s nextPutAll: (aRectangle height + 1 printPaddedWith: $0 to: 5 base: 16).
			aRectangle top to: aRectangle bottom do: [ :y | 
				aRectangle left to: aRectangle right do: [ :x | 
					| cell |
					cell := self atX: x y: y.
					(cell isEmpty not or: [ emptyCells = 127 ])
						ifTrue: [ emptyCells > 0
								ifTrue: [ s nextPutAll: ((emptyCells bitShift: 1) printPaddedWith: $0 to: 5 base: 16).
									emptyCells := 0 ].
							(cell isEmpty and: [ emptyCells = 0 ])
								ifFalse: [ s nextPutAll: cell encoded ]
								ifTrue: [ emptyCells := emptyCells + 1 ] ]
						ifFalse: [ emptyCells := emptyCells + 1 ] ] ].
			emptyCells > 0 ifTrue: [ s nextPutAll: ((emptyCells bitShift: 1) printPaddedWith: $0 to: 5 base: 16) ] ]
]

{ #category : #'cell access' }
ChDArea >> extent [ 

	^ self width @ self height
]

{ #category : #'cell access' }
ChDArea >> gtInspectorMorphIn: aComposite [
	<gtInspectorPresentationOrder: 0>
	aComposite morph 
		title: 'Morph';
		display: [ChDAreaMorph for: self.]

]

{ #category : #accessing }
ChDArea >> height [
	^ height
]

{ #category : #accessing }
ChDArea >> height: anObject [
	height := anObject
]

{ #category : #initialization }
ChDArea >> initializeForExtent: aPoint [

	width := aPoint x.
	height := aPoint y.
	
	array := Array2D rows: self height columns: self width.
	1 to: self height do: [ :y | 
		1 to: self width do: [ :x | 
			array at: y at: x put: (ChDCell new x:x; y:y; yourself)] ].
	
	1 to: self height do: [ :y | 
		1 to: self width do: [ :x | 
			| aCell |
			aCell := self atX: x y: y.
			aCell topology up: (self atX: x y: y-1). 
			aCell topology right: (self atX: x+1 y: y). 
			aCell topology down: (self atX: x y: y+1). 
			aCell topology left: (self atX: x-1 y: y). 

			aCell topology leftUp: (self atX: x-1 y: y-1). 
			aCell topology rightUp: (self atX: x+1 y: y-1). 
			aCell topology leftDown: (self atX: x-1 y: y+1). 
			aCell topology rightDown: (self atX: x+1 y: y+1). 
			] ].
		
	substrateLayer := ChDSubstrateLayer new area: self.
	metalLayer := ChDMetalLayer new area: self.
	
	regions := IdentitySet new.
	
	self createSimulation.
		
	descriptions := OrderedCollection new.
	
	dirty := false.
	
	
	
]

{ #category : #'cell access' }
ChDArea >> inspectionMorph [
	<inspectorPresentationOrder: 90 title: 'Morph'>

	^ SpMorphPresenter new
		morph: (ChDAreaMorph for: self);
		yourself.
]

{ #category : #'cell access' }
ChDArea >> leftX: x y: y [

	^ self atX: x-1 y: y
]

{ #category : #'tests support' }
ChDArea >> markClean [

	dirty := false
]

{ #category : #'tests support' }
ChDArea >> markDirty [

	dirty := true
]

{ #category : #'cell access' }
ChDArea >> mergeMetalRegions: inputRegionsToMerge [
	| regionsToMerge finalRegion |
	regionsToMerge := inputRegionsToMerge reject: #isSpecial.
	regionsToMerge ifEmpty: [ ^ nil ].
	regionsToMerge size = 1 ifTrue: [ ^ regionsToMerge anyOne ].

	finalRegion := regionsToMerge anyOne.

	regionsToMerge
		do: [ :each | 
			each == finalRegion
				ifFalse: [ each cells
						do: [ :aCell | 
							aCell metalRegion: finalRegion.
							finalRegion cells add: aCell ].
					(regions includes: each) ifTrue: [ regions remove: each ] ] ].

	^ finalRegion
]

{ #category : #'cell access' }
ChDArea >> mergeSubstrateRegions: regionsToMerge [
	| finalRegion |
	regionsToMerge ifEmpty: [ ^ nil ].
	regionsToMerge size = 1 ifTrue: [ ^ regionsToMerge anyOne ].

	finalRegion := regionsToMerge anyOne.

	regionsToMerge
		do: [ :each | 
			each == finalRegion
				ifFalse: [ each cells
						do: [ :aCell | 
							aCell substrateRegion: finalRegion.
							finalRegion cells add: aCell ].
					(regions includes: each) ifTrue: [ regions remove: each ] ] ].

	^ finalRegion
]

{ #category : #'cell access' }
ChDArea >> metalCells [

	^ array privateContents select: [ :each | each hasMetal ]
]

{ #category : #accessing }
ChDArea >> metalLayer [
	^ metalLayer
]

{ #category : #'cell access' }
ChDArea >> neighborMetalRegionsOf: aCell [
	| result neighborCell |
	result := IdentitySet new.

	neighborCell := self atX: aCell x - 1 y: aCell y.
	(neighborCell metalRegion isNotNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r1000) > 0 ]) ifTrue: [ result add: neighborCell metalRegion ].

	neighborCell := self atX: aCell x + 1 y: aCell y.
	(neighborCell metalRegion isNotNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r0010) > 0 ]) ifTrue: [ result add: neighborCell metalRegion ].

	neighborCell := self atX: aCell x y: aCell y - 1.
	(neighborCell metalRegion isNotNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r0001) > 0 ]) ifTrue: [ result add: neighborCell metalRegion ].

	neighborCell := self atX: aCell x y: aCell y + 1.
	(neighborCell metalRegion isNotNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r0100) > 0 ]) ifTrue: [ result add: neighborCell metalRegion ].

	^ result
]

{ #category : #'cell access' }
ChDArea >> neighborSubstrateRegionsOf: aCell [
	| result neighborCell |
	result := IdentitySet new.

	aCell hasJunction ifTrue: [ ^ result ].

	neighborCell := self atX: aCell x - 1 y: aCell y.
	neighborCell hasJunction
		ifFalse: [ (neighborCell substrateRegion isNotNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r1000) > 0 ])
				ifTrue: [ result add: neighborCell substrateRegion ] ].

	neighborCell := self atX: aCell x + 1 y: aCell y.
	neighborCell hasJunction
		ifFalse: [ (neighborCell substrateRegion isNotNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r0010) > 0 ])
				ifTrue: [ result add: neighborCell substrateRegion ] ].

	neighborCell := self atX: aCell x y: aCell y - 1.
	neighborCell hasJunction
		ifFalse: [ (neighborCell substrateRegion isNotNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r0001) > 0 ])
				ifTrue: [ result add: neighborCell substrateRegion ] ].

	neighborCell := self atX: aCell x y: aCell y + 1.
	neighborCell hasJunction
		ifFalse: [ (neighborCell substrateRegion isNotNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r0100) > 0 ])
				ifTrue: [ result add: neighborCell substrateRegion ] ].

	^ result
]

{ #category : #'cell access' }
ChDArea >> newCompactRegion [

	| newRegion |
	
	newRegion := ChDCompactRegion new.
	newRegion layer: substrateLayer.
	regions add: newRegion.
	^ newRegion
]

{ #category : #'cell access' }
ChDArea >> newJunctionRegion [

	| newRegion |
	
	newRegion := ChDJunctionRegion new.
	newRegion layer: substrateLayer.
	regions add: newRegion.
	^ newRegion
]

{ #category : #'cell access' }
ChDArea >> newMetalRegion [

	| newRegion |
	newRegion := ChDRegion new.
	newRegion layer: metalLayer.
	regions add: newRegion.
	^ newRegion
]

{ #category : #'cell access' }
ChDArea >> newSubstrateRegion [

	| newRegion |
	
	newRegion := ChDRegion new.
	newRegion layer: substrateLayer.
	regions add: newRegion.
	^ newRegion
]

{ #category : #'cell access' }
ChDArea >> recreateMetalRegions [

	| metalCells newRegion | 
	
	metalCells := self metalCells.
	metalCells do: [ :each |
		newRegion := self newMetalRegion.
		each metalRegion: newRegion.
		newRegion cells add: each ].
	
	metalCells do: [ :each |
		| neighbourRegions |
		neighbourRegions := self neighborMetalRegionsOf: each.
		each metalRegion: (self mergeMetalRegions: (neighbourRegions copyWith: each metalRegion) asIdentitySet).
		each updateMetalCorners.
		 ] 	
]

{ #category : #'cell access' }
ChDArea >> recreateSubstrateRegions [

	| substrateCells newRegion | 
	
	substrateCells := self allSubstrateCells.
	substrateCells do: [ :each |
		newRegion := each hasJunction 
			ifTrue: [ self newJunctionRegion ]
			ifFalse: [ self newSubstrateRegion ].
		each substrateRegion: newRegion.
		newRegion cells add: each ].
	
	substrateCells := self allSubstrateCells.
	substrateCells do: [ :each |
		each hasJunction 
			ifTrue: [ each substrateRegion updateCompactRegions ] ].
	
	substrateCells do: [ :each |
		| neighbourRegions |
		neighbourRegions := self neighborSubstrateRegionsOf: each.
		each substrateRegion: (self mergeSubstrateRegions: (neighbourRegions copyWith: each substrateRegion) asIdentitySet).
		each updateSubstrateCorners. ] 	
]

{ #category : #initialization }
ChDArea >> regions [

	^ regions
]

{ #category : #'cell access' }
ChDArea >> rightX: x y: y [

	^ self atX: x+1 y: y
]

{ #category : #'cell access' }
ChDArea >> selectedCells [

	^ self cellsIn: self selection
]

{ #category : #accessing }
ChDArea >> selection [
	^ selection
]

{ #category : #accessing }
ChDArea >> selection: anObject [
	^ selection := anObject
]

{ #category : #'cell access' }
ChDArea >> setSelection: aPoint [
	
	selection := Rectangle origin: aPoint corner: aPoint.

]

{ #category : #'cell access' }
ChDArea >> show [ 

	| m |
	m := ChDAreaMorph for: self.
	m openInWindow.
]

{ #category : #accessing }
ChDArea >> simulation [

	^ simulation
]

{ #category : #accessing }
ChDArea >> substrateLayer [
	^ substrateLayer
]

{ #category : #'cell access' }
ChDArea >> topX: x y: y [

	^ self atX: x y: y-1
]

{ #category : #'cell access' }
ChDArea >> upX: x y: y [

	^ self atX: x y: y-1
]

{ #category : #'cell access' }
ChDArea >> updateCell: aCell mode: aMode [
	((aMode = #metal and: [ aCell hasMetal not ]) and: [ aCell metalRegion isNotNil ])
		ifTrue: [ | newRegions |
			aCell metalRegion cells remove: aCell.
			newRegions := aCell metalRegion splitted.
			regions remove: aCell metalRegion.
			aCell metalRegion: nil.
			regions addAll: newRegions.
			^ self ].

	(((aMode = #n or: [ aMode = #p ]) and: [ aCell hasSubstrate not ]) and: [ aCell substrateRegion isNotNil ])
		ifTrue: [ | newRegions |
			aCell substrateRegion cells remove: aCell.
			newRegions := aCell substrateRegion splitted.
			regions remove: aCell substrateRegion.
			aCell substrateRegion: nil.
			regions addAll: newRegions.
			^ self ].

	aMode = #metal
		ifTrue: [ aCell metalConnections
				ifNotNil: [ | neighborRegions |
					aCell metalRegion isSpecial
						ifFalse: [ neighborRegions := self neighborMetalRegionsOf: aCell.
							aCell metalRegion: (self mergeMetalRegions: (neighborRegions copyWith: aCell metalRegion) asIdentitySet) ] ] ]
		ifFalse: [ aCell substrateType
				ifNotNil: [ | neighborRegions |
					neighborRegions := self neighborSubstrateRegionsOf: aCell.
					aCell substrateRegion: (self mergeSubstrateRegions: (neighborRegions copyWith: aCell substrateRegion) asIdentitySet) ] ]
]

{ #category : #'cell access' }
ChDArea >> updateSelection: aPoint [

	| newSelection |
	
	selection ifNil: [ 
		selection := Rectangle origin: aPoint corner: aPoint.
		^ true ].
	
	newSelection := Rectangle origin: selection origin corner: aPoint.
	
	selection = newSelection ifTrue: [ ^false ].
	
	selection := newSelection.
	^ true
]

{ #category : #accessing }
ChDArea >> width [
	^ width
]

{ #category : #accessing }
ChDArea >> width: anObject [
	width := anObject
]

{ #category : #initialization }
ChDArea >> withTestingVCC [

	simulation testingVCC: true.
]

{ #category : #initialization }
ChDArea >> zipString [ 

	^ self encoded zipped asByteArray base64Encoded
]
