Class {
	#name : #ChDGenericDesign,
	#superclass : #Object,
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDGenericDesign class >> designIcon [ 
	
	^ self iconNamed: #smallPaint
]

{ #category : #'instance creation' }
ChDGenericDesign class >> designName [

	^ 'unnamed'
]

{ #category : #testing }
ChDGenericDesign class >> isRoot [ 

	^ false
]

{ #category : #'as yet unclassified' }
ChDGenericDesign class >> selectable [

	^ false
]
