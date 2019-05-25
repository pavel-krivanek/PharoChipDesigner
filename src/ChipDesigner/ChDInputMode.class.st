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
ChDInputMode >> alternative [

	^ self
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
ChDInputMode >> isDeleteMetal [

	^ false
]

{ #category : #testing }
ChDInputMode >> isDeleteSubstrate [

	^ false
]

{ #category : #testing }
ChDInputMode >> isInputMode [

	^ true
]

{ #category : #testing }
ChDInputMode >> isInsertMetal [

	^ false
]

{ #category : #testing }
ChDInputMode >> isInsertNSubstrate [

	^ false
]

{ #category : #testing }
ChDInputMode >> isInsertPSubstrate [

	^ false
]

{ #category : #testing }
ChDInputMode >> isInsertSubstrate [

	^ false
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
ChDInputMode >> natural [

	^ self
]

{ #category : #testing }
ChDInputMode >> shifted [

	^ self
]

{ #category : #testing }
ChDInputMode >> unshifted [

	^ self
]
