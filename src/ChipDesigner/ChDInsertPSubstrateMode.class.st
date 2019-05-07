Class {
	#name : #ChDInsertPSubstrateMode,
	#superclass : #ChDInsertSubstrateMode,
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDInsertPSubstrateMode >> affectsPSubstrate [

	^ true
]

{ #category : #testing }
ChDInsertPSubstrateMode >> unshifted [

	^ ChDInsertMetalMode new
]
