"
I am a UI independent controller that defines operations on a given area. I make writing of the UI tests possible. 

I keep reference to an area, I keep information about the input mode and I have an announcer for UI events.

I have a reference to the view to update it directly.

I expect Morphic event classes API so I still have Moprhic as a dependency (more or less) 
"
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

{ #category : #'events processing' }
ChDAreaController >> adjustInputModeFromEvent: anEvent [

	inputMode := anEvent shiftPressed 
		ifTrue: [ inputMode shifted ]
		ifFalse: [ inputMode := inputMode unshifted ].
	
	anEvent yellowButtonPressed
		ifTrue: [ inputMode := inputMode alternative ].
	anEvent redButtonPressed
		ifTrue: [ inputMode := inputMode natural ].

]

{ #category : #announcements }
ChDAreaController >> announceDirtyCells: dirtyCells [ 

	area announceDirtyCells: dirtyCells
]

{ #category : #announcements }
ChDAreaController >> announceModeChange [

	announcer announce: (ChDModeAnnouncement new 
		controller: self;
		inputMode: inputMode)
]

{ #category : #accessing }
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

{ #category : #'events processing' }
ChDAreaController >> cellEventAt: aPoint [

	| cell |
	
	aPoint ifNil: [ ^ self ].
	
	(aPoint x < 0 or: [ aPoint y < 0 ]) ifTrue: [ ^ self ].
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
			inputMode wantsMenu ifTrue: [ 
				inputMode isSelecting: false.
				inputMode wantsMenu: false.
				mouseDown := false.
				area selection ifNotNil: [ 
					self openSelectionMenu ].
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
		inputMode isInsertMetal ifTrue: [
			area metalLayer setFor: cell with: lastCell	 mode: #metal].
		
		inputMode isInsertNSubstrate ifTrue: [ .
			area substrateLayer setFor: cell with: lastCell mode: #n ].

		inputMode isInsertPSubstrate ifTrue: [ 
			area substrateLayer setFor: cell with: lastCell mode: #p ].
		
		self announceDirtyCells: cell withAdjacentCells.
	].

	inputMode isDeleteMetal ifTrue: [ 
		area metalLayer fullClear: cell.
		area updateCell: cell mode: #metal.  
		self announceDirtyCells: cell withAdjacentCells ].
	inputMode isDeleteSubstrate ifTrue: [ 
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

{ #category : #accessing }
ChDAreaController >> mouseDown [ 
	^ mouseDown
]

{ #category : #accessing }
ChDAreaController >> mouseDown: aBoolean [

	mouseDown := aBoolean.

]

{ #category : #accessing }
ChDAreaController >> onMouseDownAt: aPoint [

	self mouseDown: true.

	self cellEventAt: aPoint
]

{ #category : #accessing }
ChDAreaController >> onMouseDownAt: aPoint event: anEvent [

	self mouseDown: true.

	self adjustInputModeFromEvent: anEvent.

	self cellEventAt: aPoint
]

{ #category : #accessing }
ChDAreaController >> onMouseMoveAt: aPoint [

	self mouseDown ifFalse: [ ^ self ].
	
	(inputMode isSelect and: [inputMode isSelecting not])
		ifTrue: [ ^ self ].
	
	self cellEventAt: aPoint
]

{ #category : #accessing }
ChDAreaController >> onMouseUpAt: aPoint [

	self mouseDown: false.
	self lastCell: nil.
	
	self inputMode isSelect ifTrue: [ 
		self finishSelection ]

]

{ #category : #accessing }
ChDAreaController >> onRightMouseMoveAt: aPoint [ 

	self onMouseMoveAt: aPoint.
]

{ #category : #announcements }
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
