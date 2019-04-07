Class {
	#name : #ChDGeneratorRegion,
	#superclass : #ChDRegion,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDGeneratorRegion >> currentState [

	^ #(0 1) atRandom
]

{ #category : #accessing }
ChDGeneratorRegion >> isSpecial [

	^ true
]
