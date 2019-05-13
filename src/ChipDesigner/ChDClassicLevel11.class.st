Class {
	#name : #ChDClassicLevel11,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel11 class >> levelName [

	^ '[11] KC82F - Divide-By-Four Counter'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel11 >> instructions [ 

	^ 'classic11.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel11 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'IN'
			sequence: '00003E0F83E0F83E0F83E0F800000000F83E000000F83E000000F83E0F8000003E000000'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OUT'
			expectedSequence: '00003FFFFC00003FFFFC000000000000FFFFFFFFFF0000000000FFFFF000000000000000'.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		}


]
