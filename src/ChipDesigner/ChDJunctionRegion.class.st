Class {
	#name : #ChDJunctionRegion,
	#superclass : #ChDRegion,
	#instVars : [
		'open',
		'vccRegion'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDJunctionRegion >> initialize [

	super initialize.
	
	open := false.
]

{ #category : #accessing }
ChDJunctionRegion >> isJunction [

	^ true
]

{ #category : #accessing }
ChDJunctionRegion >> isSpecial [

	^ true
]

{ #category : #accessing }
ChDJunctionRegion >> open [
	^ open
]

{ #category : #accessing }
ChDJunctionRegion >> open: anObject [
	open := anObject
]

{ #category : #accessing }
ChDJunctionRegion >> vccRegion [
	^ vccRegion
]

{ #category : #accessing }
ChDJunctionRegion >> vccRegion: anObject [
	vccRegion := anObject
]
