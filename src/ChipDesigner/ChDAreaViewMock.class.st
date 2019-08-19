"
I am a mock view that replaces the area morph in tests
"
Class {
	#name : #ChDAreaViewMock,
	#superclass : #Object,
	#instVars : [
		'changed'
	],
	#category : #'ChipDesigner-Mocks'
}

{ #category : #updating }
ChDAreaViewMock >> changed [

	changed := true
]

{ #category : #updating }
ChDAreaViewMock >> initialize [

	super initialize.
	changed := false.
]

{ #category : #updating }
ChDAreaViewMock >> wasChanged [

	^ changed
]
