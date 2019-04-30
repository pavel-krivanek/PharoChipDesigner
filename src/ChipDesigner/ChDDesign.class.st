Class {
	#name : #ChDDesign,
	#superclass : #Object,
	#category : #'ChipDesigner-Levels'
}

{ #category : #'as yet unclassified' }
ChDDesign class >> designIcon [ 
	
	^ self iconNamed: #smallPaint
]

{ #category : #'as yet unclassified' }
ChDDesign class >> designName [

	^ 'unnamed'
]

{ #category : #'as yet unclassified' }
ChDDesign class >> isRoot [ 

	^ false
]

{ #category : #'as yet unclassified' }
ChDDesign class >> selectable [

	^ false
]
