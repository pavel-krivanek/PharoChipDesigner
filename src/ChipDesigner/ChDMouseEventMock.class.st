Class {
	#name : #ChDMouseEventMock,
	#superclass : #Object,
	#instVars : [
		'red',
		'yellow',
		'shift',
		'control'
	],
	#category : #'ChipDesigner-Mocks'
}

{ #category : #accessing }
ChDMouseEventMock >> control [ 

	control := true
]

{ #category : #accessing }
ChDMouseEventMock >> controlKeyPressed [

	^ control
]

{ #category : #accessing }
ChDMouseEventMock >> initialize [

	super initialize.
	red := false.
	yellow := false.
	shift := false.
	control := false.
]

{ #category : #accessing }
ChDMouseEventMock >> red [ 

	red := true
]

{ #category : #accessing }
ChDMouseEventMock >> redButtonPressed [

	^ red
]

{ #category : #accessing }
ChDMouseEventMock >> shift [ 

	shift := true
]

{ #category : #accessing }
ChDMouseEventMock >> shiftPressed [

	^ shift
]

{ #category : #accessing }
ChDMouseEventMock >> yellow [ 

	yellow := true
]

{ #category : #accessing }
ChDMouseEventMock >> yellowButtonPressed [

	^ yellow
]
