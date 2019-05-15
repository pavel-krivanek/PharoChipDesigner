Class {
	#name : #ChDClassicLevels,
	#superclass : #ChDGenericDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDClassicLevels class >> designIcon [ 
	
	^ self iconNamed: #smallOpen
]

{ #category : #'instance creation' }
ChDClassicLevels class >> designName [

	^ 'Classic levels'
]

{ #category : #'instance creation' }
ChDClassicLevels class >> isRoot [ 

	^ true
]

{ #category : #'instance creation' }
ChDClassicLevels class >> levels [

	^ { 
		ChDClassicLevel1.
		ChDClassicLevel2.
		ChDClassicLevel3.
		ChDClassicLevel4.
		ChDClassicLevel5.
		ChDClassicLevel6.
		ChDClassicLevel7.
		ChDClassicLevel8.
		ChDClassicLevel9.
		ChDClassicLevel10.
		ChDClassicLevel11.
		ChDClassicLevel12.
		ChDClassicLevel13.
		ChDClassicLevel14.
		ChDClassicLevel15.
		ChDClassicLevel16.
		ChDClassicLevel17.
		ChDClassicLevel18.
		ChDClassicLevel19.
	 }
]

{ #category : #'instance creation' }
ChDClassicLevels class >> priority [ 

	^ 200
]

{ #category : #'instance creation' }
ChDClassicLevels class >> selectable [ 

	^ false
]
