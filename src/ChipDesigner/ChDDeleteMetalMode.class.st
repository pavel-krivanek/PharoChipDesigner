Class {
	#name : #ChDDeleteMetalMode,
	#superclass : #ChDDeleteMode,
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDDeleteMetalMode >> affectsMetal [

	^ true
]

{ #category : #testing }
ChDDeleteMetalMode >> isDeleteMetal [

	^ true
]

{ #category : #testing }
ChDDeleteMetalMode >> shifted [

	^ ChDDeleteSubstrateMode new
]
