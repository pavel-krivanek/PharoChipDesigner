Class {
	#name : #ChDDesign,
	#superclass : #ChDGenericDesign,
	#instVars : [
		'area',
		'ports',
		'sequences',
		'scopes',
		'graphics'
	],
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDDesign class >> designName [

	 ^ 'Playground 100x100'
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

{ #category : #'instance creation' }
ChDDesign class >> on: area graphics: graphicsProvider [

	^ self basicNew
		area: area;
		graphics: graphicsProvider;
		initialize
]

{ #category : #accessing }
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

{ #category : #accessing }
ChDDesign >> graphics [
	^ graphics
]

{ #category : #accessing }
ChDDesign >> graphics: anObject [
	graphics := anObject
]

{ #category : #accessing }
ChDDesign >> scopes [ 

	^ scopes
]
