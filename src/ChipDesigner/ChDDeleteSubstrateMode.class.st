Class {
	#name : #ChDDeleteSubstrateMode,
	#superclass : #ChDDeleteMode,
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDDeleteSubstrateMode >> affectsSubstrate [

	^ true
]

{ #category : #testing }
ChDDeleteSubstrateMode >> isDeleteSubstrate [

	^ true
]

{ #category : #testing }
ChDDeleteSubstrateMode >> unshifted [

	^ ChDDeleteMetalMode new
]
