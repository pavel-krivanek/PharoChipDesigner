Class {
	#name : #ChDArea,
	#superclass : #Object,
	#instVars : [
		'width',
		'height',
		'array',
		'substrateLayer',
		'metalLayer',
		'regions',
		'simulation',
		'descriptions'
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

{ #category : #'cell access' }
ChDArea >> atX: x y: y [

	x < 1 ifTrue: [ ^ ChDCell new ].
	y < 1 ifTrue: [ ^ ChDCell new ].
	x > self width ifTrue: [ ^ ChDCell new ].
	y > self height ifTrue: [ ^ ChDCell new ].

	^ array at: y at: x
]

{ #category : #initialization }
ChDArea >> createSimulation [

	simulation := ChDSimulation new.
	simulation area: self.
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
ChDArea >> decodedFromZipString: aString [

	^ self decodeFrom: (ByteString fromByteArray: (aString base64Decoded)) unzipped
]

{ #category : #initialization }
ChDArea >> descriptions [

	^ descriptions
]

{ #category : #'cell access' }
ChDArea >> downX: x y: y [

	^ self atX: x y: y+1
]

{ #category : #initialization }
ChDArea >> encoded [ 

	| emptyCells |
	
	emptyCells := 0.

	^ String streamContents: [ :s |
		s nextPutAll: (self width printPaddedWith: $0 to: 5 base: 16).
		s nextPutAll: (self height printPaddedWith: $0 to: 5 base: 16).
		array asArray do: [ :cell |
			(cell isEmpty not or: [ emptyCells = 127 ])
				ifTrue: [ 
					emptyCells > 0 ifTrue: [ 
						s nextPutAll: ((emptyCells bitShift: 1) printPaddedWith: $0 to: 5 base: 16).
						emptyCells := 0. ].
					(cell isEmpty and: [emptyCells = 0]) 
						ifFalse: [s nextPutAll: cell encoded ]
						ifTrue: [ emptyCells := emptyCells + 1 ]]
				ifFalse: [ emptyCells := emptyCells + 1 ].
			 ].
		emptyCells > 0 ifTrue: [ 
			s nextPutAll: ((emptyCells bitShift: 1) printPaddedWith: $0 to: 5 base: 16) ] ]
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
ChDArea >> initialConfiguration [

"	| cell region |
	cell := self atX: 1 y: 1.
	cell metalConnections: 0.
	region := ChDGeneratorRegion new.
	region layer: metalLayer.
	regions add: region.
	cell metalRegion: region.
"

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
			aCell up: (self atX: x y: y-1). 
			aCell right: (self atX: x+1 y: y). 
			aCell down: (self atX: x y: y+1). 
			aCell left: (self atX: x-1 y: y). 

			aCell leftUp: (self atX: x-1 y: y-1). 
			aCell rightUp: (self atX: x+1 y: y-1). 
			aCell leftDown: (self atX: x-1 y: y+1). 
			aCell rightDown: (self atX: x+1 y: y+1). 
			] ].
		
	substrateLayer := ChDSubstrateLayer new area: self.
	metalLayer := ChDMetalLayer new area: self.
	
	regions := IdentitySet new.
	
	simulation := ChDSimulation new.
	simulation area: self.
	
	self initialConfiguration.
	
	descriptions := OrderedCollection new.
	
	
	
]

{ #category : #'cell access' }
ChDArea >> leftX: x y: y [

	^ self atX: x-1 y: y
]

{ #category : #'cell access' }
ChDArea >> mergeMetalRegions: inputRegionsToMerge [

	| regionsToMerge finalRegion | 
	
	regionsToMerge := inputRegionsToMerge reject: #isSpecial.
	regionsToMerge isEmpty ifTrue: [ ^ nil ].
	regionsToMerge size = 1 ifTrue: [ ^ regionsToMerge anyOne ].

	finalRegion := regionsToMerge anyOne.
	
	regionsToMerge do: [ :each |
		each == finalRegion ifFalse: [ 
			each cells do: [ :aCell | 
				aCell metalRegion: finalRegion.
				finalRegion cells add: aCell ].
			(regions includes: each) ifTrue: [regions remove: each] ]].
	
	^ finalRegion
]

{ #category : #'cell access' }
ChDArea >> mergeSubstrateRegions: regionsToMerge [

	| finalRegion | 
	
	regionsToMerge isEmpty ifTrue: [ ^ nil ].
	regionsToMerge size = 1 ifTrue: [ ^ regionsToMerge anyOne ].

	finalRegion := regionsToMerge anyOne.
	
	regionsToMerge do: [ :each |
		each == finalRegion ifFalse: [ 
			each cells do: [ :aCell | 
				aCell substrateRegion: finalRegion.
				finalRegion cells add: aCell ].
			(regions includes: each) ifTrue: [regions remove: each] ]].
	
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
	
	neighborCell := self atX: aCell x-1 y: aCell y.
	(neighborCell metalRegion notNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r1000) > 0]) 
		ifTrue: [ result add: neighborCell metalRegion ].

	neighborCell := self atX: aCell x+1 y: aCell y.
	(neighborCell metalRegion notNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r0010) > 0]) 
		ifTrue: [ result add: neighborCell metalRegion ].	
			
	neighborCell := self atX: aCell x y: aCell y-1.
	(neighborCell metalRegion notNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r0001) > 0]) 
		ifTrue: [ result add: neighborCell metalRegion ].
		
	neighborCell := self atX: aCell x y: aCell y+1.	
	(neighborCell metalRegion notNil and: [ ((aCell metalConnections ifNil: [ 0 ]) bitAnd: 2r0100) > 0]) 
		ifTrue: [ result add: neighborCell metalRegion ].

	^ result.
	
]

{ #category : #'cell access' }
ChDArea >> neighborSubstrateRegionsOf: aCell [

	| result neighborCell |
	
	result := IdentitySet new.
	
	aCell hasJunction ifTrue: [ ^ result ].
	
	neighborCell := self atX: aCell x-1 y: aCell y.
	neighborCell hasJunction ifFalse: [ 
	(neighborCell substrateRegion notNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r1000) > 0]) 
		ifTrue: [ result add: neighborCell substrateRegion ]].

	neighborCell := self atX: aCell x+1 y: aCell y.
	neighborCell hasJunction ifFalse: [ 
	(neighborCell substrateRegion notNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r0010) > 0]) 
		ifTrue: [ result add: neighborCell substrateRegion ]].	
			
	neighborCell := self atX: aCell x y: aCell y-1.
	neighborCell hasJunction ifFalse: [ 
	(neighborCell substrateRegion notNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r0001) > 0]) 
		ifTrue: [ result add: neighborCell substrateRegion ]].
		
	neighborCell := self atX: aCell x y: aCell y+1.	
	neighborCell hasJunction ifFalse: [ 
	(neighborCell substrateRegion notNil and: [ ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: 2r0100) > 0]) 
		ifTrue: [ result add: neighborCell substrateRegion ]].

	^ result.
	
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
 

	((aMode = #metal and: [ aCell hasMetal not ]) and: [ aCell metalRegion notNil ]) ifTrue: [ 
				| newRegions |
				aCell metalRegion cells remove: aCell.
				newRegions := aCell metalRegion splitted.
				regions remove: aCell metalRegion.
				aCell metalRegion: nil.
				regions addAll: newRegions.
				^ self.				 
		 ].
	
	(((aMode = #n or: [ aMode = #p ]) and: [ aCell hasSubstrate not ]) and: [aCell substrateRegion notNil]) ifTrue: [ 
				| newRegions |
				aCell substrateRegion cells remove: aCell.
				newRegions := aCell substrateRegion splitted.
				regions remove: aCell substrateRegion.
				aCell substrateRegion: nil.
				regions addAll: newRegions.
				^ self.				 
		 ].

	aMode = #metal ifTrue: [ 
		aCell metalConnections ifNotNil: [
			| neighborRegions | 
			aCell metalRegion isSpecial ifFalse: [ 
				neighborRegions := self neighborMetalRegionsOf: aCell.
				aCell metalRegion: (self mergeMetalRegions: (neighborRegions copyWith: aCell metalRegion) asIdentitySet) ]. ]
	] ifFalse: [ 
		aCell substrateType ifNotNil: [
			| neighborRegions | 
			neighborRegions := self neighborSubstrateRegionsOf: aCell.
			aCell substrateRegion: (self mergeSubstrateRegions: (neighborRegions copyWith: aCell substrateRegion) asIdentitySet). ]	
	
	 ]
	
		

	
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
