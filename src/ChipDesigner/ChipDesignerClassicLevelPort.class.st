Class {
	#name : #ChipDesignerClassicLevelPort,
	#superclass : #Object,
	#instVars : [
		'name',
		'sequence',
		'expectedSequence',
		'isInput'
	],
	#category : #ChipDesigner
}

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevelPort class >> name: aString expectedSequence: expectedSequenceNumber [

	^ self new
		name: aString;
		sequence: 0;
		expectedSequence: expectedSequenceNumber;
		yourself

]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevelPort class >> name: aString sequence: sequenceNumber [

	^ self new
		name: aString;
		sequence: sequenceNumber;
		expectedSequence: 0;
		yourself

]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> expectedSequence [
	^ expectedSequence
]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> expectedSequence: anObject [
	expectedSequence := anObject
]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> isInput [
	^ isInput
]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> isInput: anObject [
	isInput := anObject
]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> name [
	^ name
]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> sequence [
	^ sequence
]

{ #category : #accessing }
ChipDesignerClassicLevelPort >> sequence: anObject [
	sequence := anObject
]
