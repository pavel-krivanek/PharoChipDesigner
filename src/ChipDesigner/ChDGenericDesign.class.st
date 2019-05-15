Class {
	#name : #ChDGenericDesign,
	#superclass : #Object,
	#category : #'ChipDesigner-Levels'
}

{ #category : #'as yet unclassified' }
ChDGenericDesign class >> designIcon [ 
	
	^ self iconNamed: #smallPaint
]

{ #category : #'as yet unclassified' }
ChDGenericDesign class >> designName [

	^ 'unnamed'
]

{ #category : #'as yet unclassified' }
ChDGenericDesign class >> isRoot [ 

	^ false
]

{ #category : #'as yet unclassified' }
ChDGenericDesign class >> selectable [

	^ false
]
