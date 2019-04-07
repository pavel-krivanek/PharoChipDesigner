Class {
	#name : #ChDAreaController,
	#superclass : #Object,
	#instVars : [
		'view',
		'area',
		'inputMode',
		'mouseDown',
		'lastCell',
		'deleteMode',
		'viaMode'
	],
	#category : #ChipDesigner
}

{ #category : #initialization }
ChDAreaController >> area [

	^ area
]

{ #category : #accessing }
ChDAreaController >> area: anObject [
	area := anObject
]

{ #category : #initialization }
ChDAreaController >> at: aPoint [

	^ self atX: aPoint x y: aPoint y
]

{ #category : #initialization }
ChDAreaController >> cellEvent: anEvent at: aPoint [

	| cell |
	
	(aPoint x > self area width or: [ aPoint y > self area height ]) ifTrue: [ ^ self ].
	
	cell := self area atX: aPoint x y: aPoint y.
	cell = lastCell ifTrue: [ ^ self ].
	
	viaMode ifTrue: [ 
		cell toggleVia.
		self viaMode: false.
		self changed.
		^ self ].
	
	deleteMode ifFalse: [ 
		(anEvent redButtonPressed and: [anEvent shiftPressed not]) ifTrue: [
			area metalLayer setFor: cell with: lastCell	 mode: #metal].
		
		(anEvent yellowButtonPressed and: [anEvent shiftPressed not]) ifTrue: [ .
			area substrateLayer setFor: cell with: lastCell mode: #n ].

		(anEvent shiftPressed and: [anEvent controlKeyPressed not]) ifTrue: [ 
			area substrateLayer setFor: cell with: lastCell mode: #p ].
	].

	(deleteMode and: [anEvent shiftPressed not]) ifTrue: [ 
		area metalLayer fullClear: cell.
		area updateCell: cell mode: #metal.  ].
	(deleteMode and: [anEvent shiftPressed]) ifTrue: [ 
		area substrateLayer fullClear: cell.		
		area updateCell: cell mode: #n.].	

	lastCell := cell.
	self changed.
]

{ #category : #initialization }
ChDAreaController >> changed [ 

	view changed
]

{ #category : #accessing }
ChDAreaController >> deleteMode [
	^ deleteMode
]

{ #category : #accessing }
ChDAreaController >> deleteMode: anObject [
	deleteMode := anObject
]

{ #category : #initialization }
ChDAreaController >> initialize [ 

	super initialize.
	
	area := ChDArea withDefaultExtent.
	
	inputMode := #metal.
		
	mouseDown := false.
	deleteMode := false.
	viaMode := false.
	
]

{ #category : #accessing }
ChDAreaController >> inputMode [
	^ inputMode
]

{ #category : #accessing }
ChDAreaController >> inputMode: anObject [
	inputMode := anObject
]

{ #category : #initialization }
ChDAreaController >> keyStroke: event [ 
	"Process keys navigation and space to toggle."
	
	event keyCharacter = $x
		ifTrue: [deleteMode := deleteMode not]
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
	self cellEvent: anEvent at: aPoint
]

{ #category : #accessing }
ChDAreaController >> onMouseUpAt: aPoint event: anEvent [

	self mouseDown: false.
	self lastCell: nil.

]

{ #category : #initialization }
ChDAreaController >> toggleViaFor: aCell [

	aCell via: aCell via not
]

{ #category : #accessing }
ChDAreaController >> viaMode [
	^ viaMode
]

{ #category : #accessing }
ChDAreaController >> viaMode: anObject [
	viaMode := anObject
]

{ #category : #accessing }
ChDAreaController >> view [
	^ view
]

{ #category : #accessing }
ChDAreaController >> view: anObject [
	view := anObject
]
