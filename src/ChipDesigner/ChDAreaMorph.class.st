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
		'display',
		'graphics'
	],
	#category : #ChipDesigner
}

{ #category : #'instance creation' }
ChDAreaMorph class >> for: anArea [

	^ self basicNew initialize initializeFor: anArea graphics: ChDGraphicsProvider forTools; yourself.
]

{ #category : #'instance creation' }
ChDAreaMorph class >> for: anArea graphics: graphicsProvider [

	^ self basicNew initialize initializeFor: anArea graphics: graphicsProvider; yourself.
]

{ #category : #'instance creation' }
ChDAreaMorph class >> new [ 

	| area |
	
	area := ChDArea withDefaultExtent.	
	^ self basicNew initialize initializeFor: area graphics: ChDGraphicsProvider forTools; yourself.
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
ChDAreaMorph >> display [ 
	^ display
]

{ #category : #initialization }
ChDAreaMorph >> drawOn: aCanvas [

	| origin |
	
	origin := self innerBounds origin.

	display drawOn: aCanvas at: origin.
	
	self drawSelectionOn: aCanvas at: origin 
	
	
	
]

{ #category : #initialization }
ChDAreaMorph >> drawSelectionOn: aCanvas at: origin [
	
	area selection ifNotNil: [ 
		| r |
		r := Rectangle 
			origin: (origin + (((13*(area selection topLeft x-1))@(13*(area selection topLeft y-1)))*self zoom)) 
			corner: (origin + (((13*(area selection bottomRight x))@(13*(area selection bottomRight y)))*self zoom)). 
		aCanvas frameAndFillRectangle: r fillColor: Color transparent borderWidth: 1 borderColor: Color white ].	

]

{ #category : #initialization }
ChDAreaMorph >> eventPointOf: anEvent [

	| eventPoint |
	
	eventPoint := (((anEvent cursorPoint - self position) / display zoom) // self cellSize) + (1@1).

	(eventPoint x <= 0 or: [ eventPoint y > self area width ]) ifTrue: [ ^ nil ].
	(eventPoint y <= 0 or: [ eventPoint y > self area height ]) ifTrue: [ ^ nil ].

	^ eventPoint
]

{ #category : #accessing }
ChDAreaMorph >> graphics [
	^ graphics
]

{ #category : #accessing }
ChDAreaMorph >> graphics: anObject [
	graphics := anObject
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
		
	display := ChDAreaDisplay new.
	display area: area.

	self resetExtent.
	
	suppressedCells := OrderedCollection new.
	self stopStepping.
	
	
]

{ #category : #initialization }
ChDAreaMorph >> initializeFor: anArea graphics: graphicsProvider [

	area := anArea.
	graphics := graphicsProvider.

	controller := ChDAreaController new.
	controller area: area.
	controller view: self.
		
	display := ChDAreaDisplay new.
	display graphics: graphics.
	display area: area.

	self resetExtent.
	
	suppressedCells := OrderedCollection new.
	self stopStepping.
	
	
]

{ #category : #initialization }
ChDAreaMorph >> keyDown: anEvent [

	anEvent keyValue = 16 ifTrue: [
		"shift"
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

	| eventPoint |
	
	eventPoint := self eventPointOf: anEvent. 
	eventPoint ifNil: [ ^ self ].
	
	controller onMouseMoveAt: eventPoint.
]

{ #category : #initialization }
ChDAreaMorph >> mouseUp: anEvent [

	controller onMouseUpAt: (self eventPointOf: anEvent).
]

{ #category : #initialization }
ChDAreaMorph >> resetExtent [

	self extent: (self cellSize*area width@(self cellSize*area height)) * display zoom.

	display resetExtent.

]

{ #category : #initialization }
ChDAreaMorph >> step [
	
	area simulation stepping ifTrue: [ 
		(self area simulation time) >= 280 ifTrue: [ 
			self stopStepping.
			area simulation stop.
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
	suppressedCells := anObject.
	display suppressedCells: anObject
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

{ #category : #initialization }
ChDAreaMorph >> zoom [

	^ display zoom
]

{ #category : #initialization }
ChDAreaMorph >> zoom: aNumber [

	^ display zoom: aNumber
]
