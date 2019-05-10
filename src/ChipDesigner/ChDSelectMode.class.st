Class {
	#name : #ChDSelectMode,
	#superclass : #ChDInputMode,
	#instVars : [
		'isSelecting'
	],
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDSelectMode >> buttonIndex [

	^ 3
]

{ #category : #accessing }
ChDSelectMode >> initialize [ 

	super initialize.
	
	isSelecting := false.
]

{ #category : #testing }
ChDSelectMode >> isSelect [ 

	^ true
]

{ #category : #accessing }
ChDSelectMode >> isSelecting [
	^ isSelecting
]

{ #category : #accessing }
ChDSelectMode >> isSelecting: anObject [
	isSelecting := anObject
]
