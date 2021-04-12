Class {
	#name : #ChDClassicLevelPort,
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
ChDClassicLevelPort class >> name: aString expectedSequence: expectedSequenceNumber [

	^ self new
		name: aString;
		sequence: 0;
		expectedSequence: expectedSequenceNumber;
		yourself

]

{ #category : #'as yet unclassified' }
ChDClassicLevelPort class >> name: aString sequence: sequenceNumber [

	^ self new
		name: aString;
		sequence: sequenceNumber;
		expectedSequence: 0;
		yourself

]

{ #category : #'as yet unclassified' }
ChDClassicLevelPort class >> notConnectedNamed: aString [ 

	^ self new
		name: aString;
		sequence: '000000000000000000000000000000000000000000000000000000000000000000000000';
		expectedSequence: 0;
		yourself

]

{ #category : #accessing }
ChDClassicLevelPort >> expectedSequence [
	^ expectedSequence
]

{ #category : #accessing }
ChDClassicLevelPort >> expectedSequence: anObject [
	expectedSequence := anObject
]

{ #category : #accessing }
ChDClassicLevelPort >> isInput [
	^ isInput
]

{ #category : #accessing }
ChDClassicLevelPort >> isInput: anObject [
	isInput := anObject
]

{ #category : #accessing }
ChDClassicLevelPort >> name [
	^ name
]

{ #category : #accessing }
ChDClassicLevelPort >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ChDClassicLevelPort >> sequence [
	^ sequence
]

{ #category : #accessing }
ChDClassicLevelPort >> sequence: anObject [
	sequence := anObject
]
