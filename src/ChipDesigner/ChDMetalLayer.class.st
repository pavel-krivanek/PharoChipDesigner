"
I provide operations for the metal layer of the surface area
"
Class {
	#name : #ChDMetalLayer,
	#superclass : #ChDLayer,
	#category : #ChipDesigner
}

{ #category : #'as yet unclassified' }
ChDMetalLayer >> connectedNeighboursOf: aCell [

	| result |
	
	result := OrderedCollection new.
	((aCell metalConnections bitAnd: 2r0001) > 0) ifTrue: [ result add: aCell topology up ].
	((aCell metalConnections bitAnd: 2r0010) > 0) ifTrue: [ result add: aCell topology right ].
	((aCell metalConnections bitAnd: 2r0100) > 0) ifTrue: [ result add: aCell topology down ].
	((aCell metalConnections bitAnd: 2r1000) > 0) ifTrue: [ result add: aCell topology left ].
	^ result
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> connectionsFor: aCell [

	^ aCell metalConnections.
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> connectionsFor: aCell add: anInteger [

	^ aCell metalConnections: ((aCell metalConnections ifNil: [ 0 ]) bitOr: anInteger)
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> connectionsFor: aCell delete: anInteger [

	aCell metalConnections ifNil: [ ^ self ].

	^ aCell metalConnections: (aCell metalConnections bitAnd: anInteger bitInvert)
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> cornersFor: aCell [

	^ aCell metalCorners.
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> fullClear: aCell [

	| oldConnections |
	
	oldConnections := aCell metalConnections.

	aCell metalConnections: nil.
	aCell clearVia.
	aCell unsetAdjacentMetalCorners.
	
	self clear: aCell withOld: oldConnections.
]

{ #category : #accessing }
ChDMetalLayer >> isMetal [

	^ true
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> isSetFor: aCell [

	^ aCell metalConnections notNil
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> mode: mode compatibleWith: lastCell [

	^ true
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> name [

	^ #metal
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> regionOf: aCell [

	^ aCell metalRegion 
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> setFor: aCell mode: aMode [

	aCell metalRegion ifNotNil: [ ^ self ].
	aCell metalConnections ifNil: [ aCell metalConnections: 0 ].
	 
	self setRegionOf: aCell to: self area newMetalRegion.
	aCell metalRegion cells add: aCell. 
]

{ #category : #'as yet unclassified' }
ChDMetalLayer >> setRegionOf: aCell to: aRegion [

	^ aCell metalRegion: aRegion
]
