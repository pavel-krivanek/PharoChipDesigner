Class {
	#name : #ChDSelectMode,
	#superclass : #ChDInputMode,
	#instVars : [
		'isSelecting',
		'wantsMenu'
	],
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #accessing }
ChDSelectMode >> alternative [ 

	isSelecting := false.
	wantsMenu := true.
]

{ #category : #testing }
ChDSelectMode >> buttonIndex [

	^ 3
]

{ #category : #accessing }
ChDSelectMode >> initialize [ 

	super initialize.
	
	isSelecting := false.
	wantsMenu := false.
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

{ #category : #accessing }
ChDSelectMode >> wantsMenu [
	^ wantsMenu
]

{ #category : #accessing }
ChDSelectMode >> wantsMenu: anObject [
	wantsMenu := anObject
]
