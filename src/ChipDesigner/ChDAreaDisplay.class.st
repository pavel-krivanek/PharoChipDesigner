"
I manage the Morphic form that displays a chip area and related rendering operations.

I update only the changed cells, I use 'dirtyMap' for this task.

I have an option to suppress some cells (make them look darker). I is used in inspectors to show cells that belong to a specific region.
"
Class {
	#name : #ChDAreaDisplay,
	#superclass : #Object,
	#instVars : [
		'form',
		'canvas',
		'area',
		'dirtyMap',
		'graphics',
		'suppressedCells',
		'zoom'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDAreaDisplay >> area [
	^ area
]

{ #category : #accessing }
ChDAreaDisplay >> area: anObject [
	area := anObject.
	
	self initializeDirtyMap.
	self initializeForm.
	self subscribe
]

{ #category : #accessing }
ChDAreaDisplay >> cellExtent [

	^ self cellSize @ self cellSize
]

{ #category : #accessing }
ChDAreaDisplay >> cellSize [ 

	^ 13
]

{ #category : #accessing }
ChDAreaDisplay >> cleanCells [

	dirtyMap associationsDo: [ :association |
		association value: false ]
]

{ #category : #accessing }
ChDAreaDisplay >> dirtyCells: cellsCollection [

	cellsCollection do: [ :aCell | 
		dirtyMap at: aCell put: true ]
]

{ #category : #accessing }
ChDAreaDisplay >> drawCell: cell suppressed: drawSuppressed [

	| x y |
	x := cell x.
	y := cell y.

			canvas drawImage: graphics bgForm at: ((self cellSize*(x-1))@(self cellSize*(y-1))).

			self drawJunctionX: x y: y sourceForm: graphics sourceForm on: canvas origin: 0@0 block: [:aCell | aCell junctionType notNil] layer: area substrateLayer.
		
			self drawCellX: x y: y type: #n sourceForm: graphics nForms on: canvas origin: 0@0  block: [:aCell | (aCell substrateType = #n) and: [aCell junctionType isNil]] layer: area substrateLayer cellForms: graphics cellForms.
			self drawCellX: x y: y type: #p sourceForm: graphics pForms on: canvas origin: 0@0  block: [:aCell | (aCell substrateType = #p) and: [aCell junctionType isNil]] layer: area substrateLayer cellForms: graphics cellForms.
			self drawCellX: x y: y type: #metal sourceForm: graphics metalForms on: canvas origin: 0@0  block: [:aCell | aCell metalConnections notNil] layer: area metalLayer cellForms: graphics cellForms.
			cell via ifTrue: [ 
				canvas translucentImage: graphics viaForm at: ((self cellSize*(x-1))@(self cellSize*(y-1))) ].

			drawSuppressed ifTrue: [ 
				(suppressedCells includes: (x@y)) ifTrue: [ 
					canvas translucentImage: graphics suppressForm at: ((self cellSize*(x-1))@(self cellSize*(y-1)))					
					 ]
				 ]	

	

]

{ #category : #accessing }
ChDAreaDisplay >> drawCellX: x y: y type: type sourceForm: aFormArray on: aCanvas origin: origin block: aBlock layer: aLayer cellForms: cellForms [

	| cell cellForm |
		
	cell := self area atX: x y: y.
	(aBlock value: cell) ifTrue: [
		| index corners |
		(aLayer isSetFor: cell) ifTrue: [
			index := aLayer connectionsFor: cell. 
			corners := aLayer cornersFor: cell. 
			cellForm := graphics cellForm: index corners: corners from: aFormArray.
			self drawImage: cellForm atX: x y: y origin: origin on: aCanvas.
						
			(cell isHi) 
				ifTrue: [ 
					cellForm := graphics cellForm: 10 from: {cellForms}.
					self drawImage: cellForm atX: x y: y origin: origin on: aCanvas. ] ] ]
]

{ #category : #accessing }
ChDAreaDisplay >> drawDescriptions: dirtyDescriptions [

	| font | 

	dirtyDescriptions do: [ :association |
		| p label width height |
		p := ((self cellSize*(association value x-1))@(self cellSize*(association value y-1))).
		label := association key.
		width := graphics font widthOfString: label.
		height := graphics font height.
		p := p + (self cellSize/2 @ (self cellSize/2)) - (width / 2 @ (height / 2)).
		
		canvas drawString: label at: p ceiling font: graphics font color: Color black.
		 ].
		

]

{ #category : #accessing }
ChDAreaDisplay >> drawDirtyCells [

	| drawSuppressed dirtyDescriptions  |

	drawSuppressed := suppressedCells notEmpty.
	drawSuppressed ifTrue: [ suppressedCells do: [ :e | dirtyMap at: (self area atX: e x y: e y) put: true ] ].
	
	dirtyDescriptions := area descriptions select: [ :anAssociation | 
		| cellMiddle cellLeft cellRight | 
		cellMiddle := self area atX: anAssociation value x y: anAssociation value y.
		cellLeft := cellMiddle topology left.
		cellRight := cellMiddle topology right.
		({ cellLeft. cellMiddle. cellRight } anySatisfy: [ :each | dirtyMap at: each ifAbsent: [false]])
			ifTrue: [ 
				{ cellLeft. cellMiddle. cellRight } do: [ :each | dirtyMap at: each put: true ]. true ]
			ifFalse: [ 
				false ] ].

	dirtyMap associationsDo: [ :association |
		association value ifTrue: [ 
			self drawCell: association key suppressed: drawSuppressed ] ].
	
	self drawDescriptions: dirtyDescriptions.
	
		

]

{ #category : #accessing }
ChDAreaDisplay >> drawImage: aForm atX: x y: y origin: origin on: aCanvas [

	aCanvas translucentImage: aForm at: origin + (((self cellSize*(x-1)))@(self cellSize*(y-1)))
	
]

{ #category : #accessing }
ChDAreaDisplay >> drawJunctionX: x y: y sourceForm: aForm on: aCanvas origin: origin block: aBlock layer: aLayer [

	| cell cellForm |
		
	cell := self area atX: x y: y.
	(aBlock value: cell) ifTrue: [
		| index |
		
		cell junctionType = #npn ifTrue: [ 
			(cell junctionConnections = 2r0001) ifTrue: [ 	index := 2 ]. 
			(cell junctionConnections = 2r0010) ifTrue: [ 	index := 7 ]. 
			(cell junctionConnections = 2r0100) ifTrue: [ 	index := 6 ].
			(cell junctionConnections = 2r1000) ifTrue: [ 	index := 3 ].
			"junction connections from both sides"
			(cell junctionConnections = 2r0101) ifTrue: [ 	index := 2 ].
			(cell junctionConnections = 2r1010) ifTrue: [ index := 3 ] ].
			
		cell junctionType = #pnp ifTrue: [ 
			(cell junctionConnections = 2r0001) ifTrue: [ 	index := 4 ]. 
			(cell junctionConnections = 2r0010) ifTrue: [ 	index := 9 ]. 
			(cell junctionConnections = 2r0100) ifTrue: [ 	index := 8 ].
			(cell junctionConnections = 2r1000) ifTrue: [ index := 5 ].
			"junction connections from both sides"
			(cell junctionConnections = 2r0101) ifTrue: [ 	index := 4 ].
			(cell junctionConnections = 2r1010) ifTrue: [ index := 5 ] ].
			
		cellForm := graphics cellForm: index from: {aForm}.
		self drawImage: cellForm atX: x y: y origin: origin on: aCanvas.

		(cell substrateRegion open) 
				ifTrue: [ 
					cellForm := graphics cellForm: 10 from: {aForm}.
					self drawImage: cellForm atX: x y: y origin: origin on: aCanvas. ]

]
		
]

{ #category : #accessing }
ChDAreaDisplay >> drawOn: aCanvas at: origin [

	self drawDirtyCells.
	
	zoom = 1 
		ifTrue: [ aCanvas drawImage: form at: origin ]
		ifFalse: [ aCanvas drawImage: (form scaledToSize: form extent * zoom) at: origin. ].
	
	
	self cleanCells.
]

{ #category : #accessing }
ChDAreaDisplay >> form [
	^ form
]

{ #category : #accessing }
ChDAreaDisplay >> form: anObject [
	form := anObject
]

{ #category : #accessing }
ChDAreaDisplay >> fullRepaint [

	| drawSuppressed  |
		
	drawSuppressed := suppressedCells notEmpty.

	1 to: area width do: [ :x |
		1 to: area height do: [ :y | 
			| cell | 
			cell := area atX: x y:y.
			self drawCell: cell suppressed: drawSuppressed ]].
	
	self drawDescriptions: area descriptions.
		

]

{ #category : #accessing }
ChDAreaDisplay >> graphics [ 
	^ graphics
]

{ #category : #accessing }
ChDAreaDisplay >> graphics: anObject [
	graphics := anObject
]

{ #category : #accessing }
ChDAreaDisplay >> initialize [ 
	
	super initialize.
	
	suppressedCells := OrderedCollection new.
	
	zoom := 1

]

{ #category : #accessing }
ChDAreaDisplay >> initializeDirtyMap [

	dirtyMap := IdentityDictionary new.
	area cells do: [ :aCell | aCell -> true ].
]

{ #category : #accessing }
ChDAreaDisplay >> initializeForm [

	| extent |
	
	extent := self cellSize*area width@(self cellSize*area height).

	form := Form extent: extent depth: 32.
	canvas := FormCanvas on: form.
	self fullRepaint.

]

{ #category : #accessing }
ChDAreaDisplay >> resetExtent [

	self initializeForm
]

{ #category : #accessing }
ChDAreaDisplay >> subscribe [ 

	area announcer when: ChDDirtyCellsAnnouncement do: [ :announcement |
		self dirtyCells: announcement cells ]
]

{ #category : #accessing }
ChDAreaDisplay >> suppressedCells [
	^ suppressedCells
]

{ #category : #accessing }
ChDAreaDisplay >> suppressedCells: anObject [
	suppressedCells := anObject
]

{ #category : #accessing }
ChDAreaDisplay >> zoom [
	^ zoom
]

{ #category : #accessing }
ChDAreaDisplay >> zoom: aFactor [

	| aNumber |
	
	aNumber := (aFactor > 0.90 and: [ aFactor < 1.1 ]) ifTrue: [ 1 ] ifFalse: [ aFactor ].
	zoom := aNumber
]
