Class {
	#name : #ChDAreaMorph,
	#superclass : #Morph,
	#instVars : [
		'controller',
		'area',
		'inputMode',
		'mouseDown',
		'lastCell',
		'deleteMode',
		'suppressedCells',
		'stepping',
		'graphics'
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
ChDAreaMorph >> cellSize [ 

	^ 13
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
ChDAreaMorph >> drawCellX: x y: y type: type sourceForm: aFormArray on: aCanvas origin: origin block: aBlock layer: aLayer cellForms: cellForms [

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

{ #category : #initialization }
ChDAreaMorph >> drawOn: aCanvas [

	| origin drawSuppressed  |
		
	origin := self innerBounds origin.

	
	drawSuppressed := suppressedCells notEmpty.

	1 to: area width do: [ :x |
		1 to: area height do: [ :y | 
			| cell | 
			cell := area atX: x y:y.

			aCanvas drawImage: graphics bgForm at: origin + ((self cellSize*(x-1))@(self cellSize*(y-1))).

			self drawJunctionX: x y: y sourceForm: graphics sourceForm on: aCanvas origin: origin block: [:aCell | aCell junctionType notNil] layer: area substrateLayer.
		
			self drawCellX: x y: y type: #n sourceForm: graphics nForms on: aCanvas origin: origin block: [:aCell | (aCell substrateType = #n) and: [aCell junctionType isNil]] layer: area substrateLayer cellForms: graphics cellForms.
			self drawCellX: x y: y type: #p sourceForm: graphics pForms on: aCanvas origin: origin block: [:aCell | (aCell substrateType = #p) and: [aCell junctionType isNil]] layer: area substrateLayer cellForms: graphics cellForms.
			self drawCellX: x y: y type: #metal sourceForm: graphics metalForms on: aCanvas origin: origin block: [:aCell | aCell metalConnections notNil] layer: area metalLayer cellForms: graphics cellForms.
			cell via ifTrue: [ 
				aCanvas translucentImage: graphics viaForm at: origin + ((self cellSize*(x-1))@(self cellSize*(y-1))) ].

			drawSuppressed ifTrue: [ 
				(suppressedCells includes: (x@y)) ifTrue: [ 
					aCanvas translucentImage: graphics suppressForm at: origin + ((self cellSize*(x-1))@(self cellSize*(y-1)))					
					 ]
				 ]	
			 ]].
	
	area descriptions do: [ :association |
		| p |
		p := ((self cellSize*(association value x-1))@(self cellSize*(association value y-1))).
		aCanvas drawString: association key at: origin + p + (-5 @ 0).
		 ].
	
	area selection ifNotNil: [ 
		| r |
		r := Rectangle 
			origin: (origin + ((self cellSize*(area selection topLeft x-1))@(self cellSize*(area selection topLeft y-1)))) 
			corner: (origin + ((self cellSize*(area selection bottomRight x))@(self cellSize*(area selection bottomRight y)))). 
		aCanvas frameAndFillRectangle: r fillColor: Color transparent borderWidth: 1 borderColor: Color white ].
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

	area := anArea.

	controller := ChDAreaController new.
	controller area: area.
	controller view: self.
	
	graphics := ChDGraphicsProvider new.
	
	self resetExtent.
	
	suppressedCells := OrderedCollection new.
	self stopStepping.
	
]

{ #category : #initialization }
ChDAreaMorph >> keyDown: anEvent [

	anEvent keyValue = 16 ifTrue: [
		self controller shiftInputMode.
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
		ifTrue: [ self toggleRun ]
]

{ #category : #initialization }
ChDAreaMorph >> keyUp: anEvent [

	anEvent keyValue = 16 ifTrue: [
		self controller inputMode: self controller inputMode unshifted.
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
ChDAreaMorph >> resetExtent [

	self extent: self cellSize*area width@(self cellSize*area height).

]

{ #category : #initialization }
ChDAreaMorph >> step [
	
	area simulation stepping ifTrue: [ 
		(self area simulation time) >= 280 ifTrue: [ 
			self stopStepping.
			area simulation stepping: false.
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

{ #category : #initialization }
ChDAreaMorph >> toggleRun [ 

	area simulation toggleStepping.

	area simulation stepping ifTrue: [ 
		self area simulation resetTime.
		self startStepping ]
]
