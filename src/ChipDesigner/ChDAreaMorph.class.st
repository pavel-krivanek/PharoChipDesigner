Class {
	#name : #ChDAreaMorph,
	#superclass : #Morph,
	#instVars : [
		'controller',
		'sourceForm',
		'area',
		'inputMode',
		'metalForms',
		'mouseDown',
		'lastCell',
		'deleteMode',
		'suppressedCells',
		'stepping',
		'nForms',
		'pForms'
	],
	#category : #ChipDesigner
}

{ #category : #'instance creation' }
ChDAreaMorph class >> for: anArea [

	^ self basicNew initialize initializeFor: anArea; yourself.
]

{ #category : #'instance creation' }
ChDAreaMorph class >> new [ 

	| area |
	
	area := ChDArea withDefaultExtent.	
	^ self basicNew initialize initializeFor: area; yourself.
]

{ #category : #initialization }
ChDAreaMorph >> area [ 

	^ controller area
]

{ #category : #initialization }
ChDAreaMorph >> cellExtent [

	^ self cellSize @ self cellSize
]

{ #category : #initialization }
ChDAreaMorph >> cellForm: index corners: cornersIndex from: aFormArray [
	
	| aFrom |

	aFrom := (aFormArray at: cornersIndex+1) copy: (((index*self cellSize)@0) extent: self cellSize@self cellSize).
"
	cornersIndex > 0  ifTrue: [
	(FormCanvas on: aFrom) drawString: cornersIndex asString at: 0@0 ].
"	
	^ aFrom
]

{ #category : #initialization }
ChDAreaMorph >> cellForm: index from: aFormArray [

	^ self cellForm: index corners: 0 from: aFormArray
]

{ #category : #initialization }
ChDAreaMorph >> cellSize [ 

	^ 13
]

{ #category : #initialization }
ChDAreaMorph >> colorize: aForm with: aColor [

	0 to: aForm width do: [ :x |
		0 to: aForm height do: [ :y |
			| c |
			c := aForm colorAt: x@y.
			(c red > 0.9) ifTrue: [ 
				aForm colorAt: x@y put: aColor ]
			]].
	
]

{ #category : #accessing }
ChDAreaMorph >> controller [
	^ controller
]

{ #category : #accessing }
ChDAreaMorph >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
ChDAreaMorph >> drawCellX: x y: y type: type sourceForm: aFormArray on: aCanvas origin: origin block: aBlock layer: aLayer [

	| cell cellForm |
		
	cell := self area atX: x y: y.
	(aBlock value: cell) ifTrue: [
		| index corners |
		(aLayer isSetFor: cell) ifTrue: [
			index := aLayer connectionsFor: cell. 
			corners := aLayer cornersFor: cell. 
			cellForm := self cellForm: index corners: corners from: aFormArray.
			self drawImage: cellForm atX: x y: y origin: origin on: aCanvas.
						
			(cell isHi) 
				ifTrue: [ 
					cellForm := self cellForm: 58 from: aFormArray.
					self drawImage: cellForm atX: x y: y origin: origin on: aCanvas. ] ] ]
]

{ #category : #initialization }
ChDAreaMorph >> drawCornersFor: forms [

	| cornerForms |
	
	cornerForms := (60 to: 63) collect: [ :index | self cellForm: index from: {sourceForm}.].
		
	forms withIndexDo: [ :aForm :index |
		| mask | 
		mask := index - 1.
		(mask bitAnd: 2r0001) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r1001) = 2r1001) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 1) ] ] ].

		(mask bitAnd: 2r0010) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r0011) = 2r0011) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 2) ] ] ].

		(mask bitAnd: 2r0100) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r01100) = 2r1100) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 3) ] ] ].

		(mask bitAnd: 2r1000) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r0110) = 2r0110) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 4) ] ] ].
	 ].

]

{ #category : #initialization }
ChDAreaMorph >> drawImage: aForm atX: x y: y origin: origin on: aCanvas [

	aCanvas translucentImage: aForm at: origin + (((self cellSize*(x-1)))@(self cellSize*(y-1)))
	
]

{ #category : #initialization }
ChDAreaMorph >> drawJunctionX: x y: y sourceForm: aForm on: aCanvas origin: origin block: aBlock layer: aLayer [

	| cell cellForm |
		
	cell := self area atX: x y: y.
	(aBlock value: cell) ifTrue: [
		| index |
		
		cell junctionType = #npn ifTrue: [ 
			(cell junctionConnections = 2r0001) ifTrue: [ 	index := 50 ]. 
			(cell junctionConnections = 2r0010) ifTrue: [ 	index := 55 ]. 
			(cell junctionConnections = 2r0100) ifTrue: [ 	index := 54 ].
			(cell junctionConnections = 2r1000) ifTrue: [ 	index := 51 ] ].
			
		cell junctionType = #pnp ifTrue: [ 
			(cell junctionConnections = 2r0001) ifTrue: [ 	index := 52 ]. 
			(cell junctionConnections = 2r0010) ifTrue: [ 	index := 57 ]. 
			(cell junctionConnections = 2r0100) ifTrue: [ 	index := 56 ].
			(cell junctionConnections = 2r1000) ifTrue: [ index := 53 ] ].
			
		cellForm := self cellForm: index from: {aForm}.
		self drawImage: cellForm atX: x y: y origin: origin on: aCanvas.

		(cell substrateRegion open) 
				ifTrue: [ 
					cellForm := self cellForm: 58 from: {aForm}.
					self drawImage: cellForm atX: x y: y origin: origin on: aCanvas. ]

]
		
]

{ #category : #initialization }
ChDAreaMorph >> drawOn: aCanvas [

	| bgForm viaForm origin drawSuppressed  suppressForm |
		
	origin := self innerBounds origin.
	
	bgForm := self cellForm: 48 from: {sourceForm}.
	viaForm := self cellForm: 49 from: {sourceForm}.
	suppressForm := self cellForm: 59 from: {sourceForm}.
	
	drawSuppressed := suppressedCells notEmpty.

	1 to: area width do: [ :x |
		1 to: area height do: [ :y | 
			| cell | 
			cell := area atX: x y:y.

			aCanvas drawImage: bgForm at: origin + ((13*(x-1))@(13*(y-1))).

			self drawJunctionX: x y: y sourceForm: sourceForm on: aCanvas origin: origin block: [:aCell | aCell junctionType notNil] layer: area substrateLayer.
		
			self drawCellX: x y: y type: #n sourceForm: nForms on: aCanvas origin: origin block: [:aCell | (aCell substrateType = #n) and: [aCell junctionType isNil]] layer: area substrateLayer.
			self drawCellX: x y: y type: #p sourceForm: pForms on: aCanvas origin: origin block: [:aCell | (aCell substrateType = #p) and: [aCell junctionType isNil]] layer: area substrateLayer.
			self drawCellX: x y: y type: #metal sourceForm: metalForms on: aCanvas origin: origin block: [:aCell | aCell metalConnections notNil] layer: area metalLayer.
			cell via ifTrue: [ 
				aCanvas translucentImage: viaForm at: origin + ((13*(x-1))@(13*(y-1))) ].

			drawSuppressed ifTrue: [ 
				(suppressedCells includes: (x@y)) ifTrue: [ 
					aCanvas translucentImage: suppressForm at: origin + ((13*(x-1))@(13*(y-1)))					
					 ]
				 ]	
			 ]].
	
	area descriptions do: [ :association |
		| p |
		p := ((13*(association value x-1))@(13*(association value y-1))).
		aCanvas drawString: association key at: origin + p + (-5 @ 0).
		 ]
	

]

{ #category : #initialization }
ChDAreaMorph >> eventPointOf: anEvent [

	^ ((anEvent cursorPoint - self position) // self cellSize) + (1@1).

]

{ #category : #initialization }
ChDAreaMorph >> handlesKeyboard: evt [
	"Yes, we do it here."
	
	^true
]

{ #category : #initialization }
ChDAreaMorph >> handlesMouseDown: anEvent [

	^ true
]

{ #category : #initialization }
ChDAreaMorph >> handlesMouseMove: evt [
	^ true
]

{ #category : #initialization }
ChDAreaMorph >> initializeFor: anArea [

	| cornerForms |

	area := anArea.

	controller := ChDAreaController new.
	controller area: area.
	controller view: self.
	
	sourceForm := PNGReadWriter formFromFileNamed: './pharo-local/iceberg/pavel-krivanek/PharoChipDesigner/graphics/box.png'.
	metalForms := (1 to: 16) collect: [ :index | sourceForm deepCopy].
	nForms := (1 to: 16) collect: [ :index | sourceForm deepCopy].
	pForms := (1 to: 16) collect: [ :index | sourceForm deepCopy].
	
	cornerForms := (60 to: 63) collect: [ :index | self cellForm: index from: {sourceForm}.].
	
	self drawCornersFor: metalForms.
	self drawCornersFor: nForms.
	self drawCornersFor: pForms.

	metalForms do: [ :metalForm |
		self colorize: metalForm with: ((Color fromHexString: 'E8E8E8') alpha: 0.6) ].		
		
	nForms do: [ :nForm |
		self colorize: nForm with: ((Color fromHexString: 'B60000') alpha: 1) ].
	pForms do: [ :pForm |
		self colorize: pForm with: ((Color fromHexString: 'FFFF00') alpha: 1) ].
	
	self extent: 13*area width@(13*area height).
	
	suppressedCells := OrderedCollection new.
	stepping := false.
	self stopStepping.
	
]

{ #category : #initialization }
ChDAreaMorph >> keyDown: anEvent [

	anEvent keyValue = 16 ifTrue: [
		self controller inputMode: #shift.
		self controller announceModeChange].
	^ super keyDown: anEvent
]

{ #category : #initialization }
ChDAreaMorph >> keyStroke: event [ 
	"Process keys navigation and space to toggle."
	
	event keyCharacter = $x
		ifTrue: [ controller swapDeleteMode ].
		
	event keyCharacter = $v
		ifTrue: [controller swapViaMode].
		
	event keyCharacter = $s
		ifTrue: [area simulation step. self changed].
		
	event keyCharacter = $r
		ifTrue: [self run]
]

{ #category : #initialization }
ChDAreaMorph >> keyUp: anEvent [

	anEvent keyValue = 16 ifTrue: [
		self controller inputMode: #metal.
		self controller announceModeChange].
	^ super keyDown: anEvent
]

{ #category : #initialization }
ChDAreaMorph >> keyboardFocusChange: aBoolean [
	"The message is sent to a morph when its keyboard focus changes.
	Update for focus feedback."
	
	super keyboardFocusChange: aBoolean.
	self focusChanged
]

{ #category : #initialization }
ChDAreaMorph >> keyboardFocusOnMouseDown [
	^ self class keyboardFocusOnMouseDown
]

{ #category : #initialization }
ChDAreaMorph >> mouseDown: anEvent [

	self takeKeyboardFocus.
	controller onMouseDownAt: (self eventPointOf: anEvent) event: anEvent.

]

{ #category : #initialization }
ChDAreaMorph >> mouseMove: anEvent [

	controller onMouseMoveAt: (self eventPointOf: anEvent) event: anEvent
]

{ #category : #initialization }
ChDAreaMorph >> mouseUp: anEvent [

	controller onMouseUpAt: (self eventPointOf: anEvent) event: anEvent
]

{ #category : #initialization }
ChDAreaMorph >> overlap: aSourceForm at: zeroBasedIndex with: aFrom [

	| aCanvas |
	
	zeroBasedIndex logCr.
		
	aCanvas := FormCanvas on: aSourceForm.
	aCanvas translucentImage: aFrom at: ((self cellSize*zeroBasedIndex)@0).
	

"	aCanvas drawString: zeroBasedIndex asString at: ((self cellSize*zeroBasedIndex)@0) .

"
]

{ #category : #initialization }
ChDAreaMorph >> run [ 

	stepping := true.
	self area simulation resetTime.
	self startStepping.
]

{ #category : #initialization }
ChDAreaMorph >> step [
	
	stepping ifTrue: [ 
		(self area simulation time+1) >= 280 ifTrue: [ 
			self stopStepping.
			stepping := false.
			^ self ].

		self area simulation step.
		self changed ].
]

{ #category : #initialization }
ChDAreaMorph >> stepTime [
	^ 1 
]

{ #category : #accessing }
ChDAreaMorph >> suppressedCells [
	^ suppressedCells
]

{ #category : #accessing }
ChDAreaMorph >> suppressedCells: anObject [
	suppressedCells := anObject
]

{ #category : #initialization }
ChDAreaMorph >> takesKeyboardFocus [
	^ true
]
