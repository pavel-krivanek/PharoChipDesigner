Class {
	#name : #ChDDesign,
	#superclass : #ChDGenericDesign,
	#instVars : [
		'area',
		'ports',
		'sequences',
		'scopes'
	],
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDDesign class >> designName [

	 ^ 'Playground 100x100'
]

{ #category : #'as yet unclassified' }
ChDDesign class >> isRoot [ 

	^ false
]

{ #category : #'instance creation' }
ChDDesign class >> levelName [

	 ^ self subclassResponsibility
]

{ #category : #'instance creation' }
ChDDesign class >> levels [

	^ Array new
]

{ #category : #'instance creation' }
ChDDesign class >> on: area [

	^ self basicNew
		area: area;
		initialize
]

{ #category : #'as yet unclassified' }
ChDDesign class >> priority [ 

	^ 300
]

{ #category : #'as yet unclassified' }
ChDDesign class >> selectable [

	^ true
]

{ #category : #accessing }
ChDDesign >> area [
	^ area
]

{ #category : #accessing }
ChDDesign >> area: anObject [
	area := anObject
]

{ #category : #'as yet unclassified' }
ChDDesign >> scopes [ 

	^ scopes
]
