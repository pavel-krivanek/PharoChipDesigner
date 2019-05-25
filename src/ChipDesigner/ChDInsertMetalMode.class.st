Class {
	#name : #ChDInsertMetalMode,
	#superclass : #ChDInputMode,
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDInsertMetalMode >> affectsMetal [

	^ true
]

{ #category : #testing }
ChDInsertMetalMode >> alternative [

	^ ChDInsertNSubstrateMode new
]

{ #category : #testing }
ChDInsertMetalMode >> isInsertMetal [

	^ true
]

{ #category : #testing }
ChDInsertMetalMode >> shifted [

	^ ChDInsertPSubstrateMode new
]
