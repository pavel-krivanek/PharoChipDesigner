Class {
	#name : #ChDInsertNSubstrateMode,
	#superclass : #ChDInsertSubstrateMode,
	#category : #'ChipDesigner-Input Modes'
}

{ #category : #testing }
ChDInsertNSubstrateMode >> affectsNSubstrate [

	^ true
]

{ #category : #testing }
ChDInsertNSubstrateMode >> isInsertNSubstrate [

	^ true
]

{ #category : #testing }
ChDInsertNSubstrateMode >> natural [ 

	^ ChDInsertMetalMode new
]

{ #category : #testing }
ChDInsertNSubstrateMode >> shifted [ 

	^ ChDInsertPSubstrateMode new
]
