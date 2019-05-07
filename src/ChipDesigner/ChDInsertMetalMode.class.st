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
ChDInsertMetalMode >> shifted [

	^ ChDInsertPSubstrateMode new
]
