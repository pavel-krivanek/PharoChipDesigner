Class {
	#name : #ChDAreaController,
	#superclass : #Object,
	#instVars : [
		'view',
		'area',
		'inputMode',
		'mouseDown',
		'lastCell',
		'announcer'
	],
	#category : #ChipDesigner
}

{ #category : #initialization }
ChDAreaController >> announceDirtyCells: dirtyCells [ 

	area announceDirtyCells: dirtyCells
]

{ #category : #accessing }
ChDAreaController >> announceModeChange [

	announcer announce: (ChDModeAnnouncement new 
		controller: self;
		inputMode: inputMode)
]

{ #category : #initialization }
ChDAreaController >> announcer [

	^ announcer
]

{ #category : #initialization }
ChDAreaController >> area [

	^ area
]

{ #category : #accessing }
ChDAreaController >> area: anObject [
	area := anObject
]

{ #category : #initialization }
ChDAreaController >> cellEvent: anEvent at: aPoint [

	| cell |
	
	(aPoint x > self area width or: [ aPoint y > self area height ]) ifTrue: [ ^ self ].
	
	cell := self area atX: aPoint x y: aPoint y.
	cell = lastCell ifTrue: [ ^ self ].
	
	inputMode isInsertVia ifTrue: [ 
		cell toggleVia.
		self inputMode: ChDInsertMetalMode new.
		self announceDirtyCells: { cell }.
		self changed.
		^ self ].
	
	inputMode isSelect
		ifTrue: [
			 anEvent yellowButtonPressed ifTrue: [
				inputMode isSelecting: false.
				self openSelectionMenu.
				^ self ].
			inputMode isSelecting
				ifFalse: [
					inputMode isSelecting: true.
					area setSelection: aPoint.
					self changed ].
			(area updateSelection: aPoint)
				ifTrue: [ self changed ].
			^ self ]
		ifFalse: [ area deselect ].
	
	inputMode isDelete ifFalse: [ 
		(anEvent redButtonPressed and: [anEvent shiftPressed not]) ifTrue: [
			area metalLayer setFor: cell with: lastCell	 mode: #metal].
		
		(anEvent yellowButtonPressed and: [anEvent shiftPressed not]) ifTrue: [ .
			area substrateLayer setFor: cell with: lastCell mode: #n ].

		(anEvent shiftPressed and: [anEvent controlKeyPressed not]) ifTrue: [ 
			area substrateLayer setFor: cell with: lastCell mode: #p ].
		
		self announceDirtyCells: cell withAdjacentCells.
	].

	(inputMode isDelete and: [anEvent shiftPressed not]) ifTrue: [ 
		area metalLayer fullClear: cell.
		area updateCell: cell mode: #metal.  ].
	(inputMode isDelete and: [anEvent shiftPressed]) ifTrue: [ 
		area substrateLayer fullClear: cell.		
		area updateCell: cell mode: #n.].	

	lastCell := cell.
	self changed.
]

{ #category : #initialization }
ChDAreaController >> changed [ 

	view changed.
]

{ #category : #accessing }
ChDAreaController >> finishSelection [

	inputMode isSelecting: false
	
]

{ #category : #initialization }
ChDAreaController >> initialize [ 

	super initialize.
	
	area := ChDArea withDefaultExtent.
	
	inputMode := ChDInsertMetalMode new.
		
	mouseDown := false.
	
	announcer := Announcer new.
	
]

{ #category : #accessing }
ChDAreaController >> inputMode [
	^ inputMode
]

{ #category : #accessing }
ChDAreaController >> inputMode: anObject [

	inputMode := anObject.
	
	self announceModeChange.
]

{ #category : #initialization }
ChDAreaController >> keyStroke: event [ 
	"Process keys navigation and space to toggle."
	
	event keyCharacter = $x
		ifTrue: [ inputMode := inputMode isDelete 
			ifFalse: [ ChDDeleteMetalMode new ]
			ifTrue: [ ChDInsertMetalMode new ] ]
]

{ #category : #accessing }
ChDAreaController >> lastCell [
	^ lastCell
]

{ #category : #accessing }
ChDAreaController >> lastCell: anObject [
	lastCell := anObject
]

{ #category : #initialization }
ChDAreaController >> mouseDown [ 
	^ mouseDown
]

{ #category : #initialization }
ChDAreaController >> mouseDown: aBoolean [

	mouseDown := aBoolean.

]

{ #category : #accessing }
ChDAreaController >> onMouseDownAt: aPoint event: anEvent [

	self mouseDown: true.
	self cellEvent: anEvent at: aPoint
]

{ #category : #accessing }
ChDAreaController >> onMouseMoveAt: aPoint event: anEvent [

	self mouseDown ifFalse: [ ^ self ].
	
	(inputMode isSelect and: [inputMode isSelecting not])
		ifTrue: [ ^ self ].
	
	self cellEvent: anEvent at: aPoint
]

{ #category : #accessing }
ChDAreaController >> onMouseUpAt: aPoint event: anEvent [

	self mouseDown: false.
	self lastCell: nil.
	
	self inputMode isSelect ifTrue: [ 
		self finishSelection ]

]

{ #category : #initialization }
ChDAreaController >> openSelectionMenu [

	announcer announce: (ChDContextMenuAnnouncement new 
		controller: self)
]

{ #category : #accessing }
ChDAreaController >> shiftInputMode [

	inputMode := inputMode shifted
]

{ #category : #accessing }
ChDAreaController >> swapDeleteMode [

	self inputMode: (inputMode isDelete 
		ifTrue: [ ChDInsertMetalMode new ]
		ifFalse: [ 
			inputMode buttonIndex = 1
				ifTrue: [ ChDDeleteMetalMode new ]
				ifFalse: [  ChDInsertMetalMode new ]
			])

]

{ #category : #accessing }
ChDAreaController >> swapViaMode [

	self inputMode: (inputMode isInsertVia  
		ifTrue: [ ChDInsertMetalMode new ]
		ifFalse: [ ChDInsertViaMode new ])

]

{ #category : #initialization }
ChDAreaController >> toggleViaFor: aCell [

	aCell via: aCell via not
]

{ #category : #accessing }
ChDAreaController >> view [
	^ view
]

{ #category : #accessing }
ChDAreaController >> view: anObject [
	view := anObject
]
