Class {
	#name : #ChDClassicLevel13,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel13 class >> levelName [

	^ '[13] KC84C - 4-Bit Counter With Clear'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel13 >> instructions [ 

	^ 'classic13.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel13 >> portsDefinition [

	^ { 
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort 
			name: 'CLR'
			sequence: '00FFC000000000000000000000000000000000000000000003FF000000000000000FFC00'.
		ChDClassicLevelPort 
			name: 'INC'
			sequence: '0000000F83E0F83E0F83E0F83E0F83E0F83E0F83E0F800000000003E0F83E00000000000'.
		ChDClassicLevelPort notConnectedNamed: 'N/C'.

		ChDClassicLevelPort 
			name: 'Y0'
			expectedSequence: '0000000FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFFFFFFC00003FF003FFFFFFF00000'.	 
		ChDClassicLevelPort 
			name: 'Y1'
			expectedSequence: '0000000003FFFFC00003FFFFC00003FFFFC00003FFFFFFFFFC0000000FFFFFFFFFF00000'.	 
		ChDClassicLevelPort 
			name: 'Y2'
			expectedSequence: '000000000000003FFFFFFFFFC0000000003FFFFFFFFFFFFFFC0000000000000000000000'.	 
		ChDClassicLevelPort 
			name: 'Y3'
			expectedSequence: '0000000000000000000000003FFFFFFFFFFFFFFFFFFFFFFFFC0000000000000000000000'.	 
		}


]
