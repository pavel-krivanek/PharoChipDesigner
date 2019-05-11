Class {
	#name : #ChDInputMode,
	#superclass : #Object,
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDInputMode >> affectsMetal [

	^ false
]

{ #category : #testing }
ChDInputMode >> affectsNSubstrate [

	^ false
]

{ #category : #testing }
ChDInputMode >> affectsPSubstrate [

	^ false
]

{ #category : #testing }
ChDInputMode >> affectsSubstrate [

	^ false
]

{ #category : #testing }
ChDInputMode >> buttonIndex [

	^ 1
]

{ #category : #testing }
ChDInputMode >> isDelete [

	^ false
]

{ #category : #testing }
ChDInputMode >> isInputMode [

	^ true
]

{ #category : #testing }
ChDInputMode >> isInsertVia [

	^ false
]

{ #category : #testing }
ChDInputMode >> isSelect [

	^ false
]

{ #category : #testing }
ChDInputMode >> shifted [

	^ self
]

{ #category : #testing }
ChDInputMode >> unshifted [

	^ self
]
