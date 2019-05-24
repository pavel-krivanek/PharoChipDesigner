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
		self insertMetalMode.
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
		area updateCell: cell mode: #metal.  
		self announceDirtyCells: cell withAdjacentCells ].
	(inputMode isDelete and: [anEvent shiftPressed]) ifTrue: [ 
		area substrateLayer fullClear: cell.		
		area updateCell: cell mode: #n.
		self announceDirtyCells: cell withAdjacentCells ].	

	lastCell := cell.
	self changed.
]

{ #category : #initialization }
ChDAreaController >> changed [ 

	view changed.
]

{ #category : #'input modes' }
ChDAreaController >> deleteMetalMode [ 

	self inputMode: ChDDeleteMetalMode new
]

{ #category : #'input modes' }
ChDAreaController >> deleteSubstrateMode [ 

	self inputMode: ChDDeleteSubstrateMode new
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

{ #category : #'input modes' }
ChDAreaController >> insertMetalMode [ 

	self inputMode: ChDInsertMetalMode new
]

{ #category : #'input modes' }
ChDAreaController >> insertNSubstrateMode [ 

	self inputMode: ChDInsertNSubstrateMode new
]

{ #category : #'input modes' }
ChDAreaController >> insertPSubstrateMode [ 

	self inputMode: ChDInsertPSubstrateMode new
]

{ #category : #'input modes' }
ChDAreaController >> insertViaMode [ 

	self inputMode: ChDInsertViaMode new
]

{ #category : #initialization }
ChDAreaController >> keyStroke: event [ 
	"Process keys navigation and space to toggle."
	
	event keyCharacter = $x
		ifTrue: [ inputMode isDelete 
			ifFalse: [ self deleteMetalMode ]
			ifTrue: [ self insertMetalMode ] ]
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

{ #category : #'input modes' }
ChDAreaController >> selectMode [ 

	self inputMode: ChDSelectMode new
]

{ #category : #accessing }
ChDAreaController >> shiftInputMode [

	inputMode := inputMode shifted
]

{ #category : #accessing }
ChDAreaController >> swapDeleteMode [

	inputMode isDelete 
		ifTrue: [ self insertMetalMode ]
		ifFalse: [ 
			inputMode buttonIndex = 1
				ifTrue: [ self deleteMetalMode ]
				ifFalse: [ self insertMetalMode ]
			]
]

{ #category : #accessing }
ChDAreaController >> swapViaMode [

	inputMode isInsertVia  
		ifTrue: [ self insertMetalMode ]
		ifFalse: [ self insertViaMode ]

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
