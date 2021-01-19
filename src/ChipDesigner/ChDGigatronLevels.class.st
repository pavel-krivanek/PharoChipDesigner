Class {
	#name : #ChDGigatronLevels,
	#superclass : #ChDGenericDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDGigatronLevels class >> designIcon [ 
	
	^ self iconNamed: #smallOpen
]

{ #category : #'instance creation' }
ChDGigatronLevels class >> designName [

	^ 'Gigatron levels'
]

{ #category : #'instance creation' }
ChDGigatronLevels class >> isRoot [ 

	^ true
]

{ #category : #'instance creation' }
ChDGigatronLevels class >> levels [

	^ { 
		ChDGigatronLevel1.
		ChDGigatronLevel2.
		ChDGigatronLevel3.
	 }
]

{ #category : #'instance creation' }
ChDGigatronLevels class >> priority [ 

	^ 300
]
