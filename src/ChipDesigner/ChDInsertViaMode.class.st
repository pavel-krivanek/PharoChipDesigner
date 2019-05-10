Class {
	#name : #ChDInsertViaMode,
	#superclass : #ChDInputMode,
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDInsertViaMode >> affectsMetal [

	^ true
]

{ #category : #testing }
ChDInsertViaMode >> affectsSubstrate [

	^ true
]

{ #category : #testing }
ChDInsertViaMode >> buttonIndex [

	^ 2
]

{ #category : #testing }
ChDInsertViaMode >> isInsertVia [ 

	^ true
]
