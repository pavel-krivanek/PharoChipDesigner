Class {
	#name : #ChDClassicLevel9,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel9 class >> levelName [

	^ '[09] KD124 - 2-To-4 Line Decoder'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel9 >> instructions [ 

	^ 'classic09.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel9 >> portsDefinition [

	^ { 
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort 
			name: 'A'
			sequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FFFFFFF003FF00000'.
		ChDClassicLevelPort 
			name: 'B'
			sequence: '0000000FFFFF00000FFFFF00000FFFFF00000FFFFF00000003FF00000FFFFF00000FFC00'.
		ChDClassicLevelPort notConnectedNamed: 'N/C'.	

		ChDClassicLevelPort 
			name: 'Y0'
			expectedSequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC00FFC00FFC0000000FFC00003FF'.	 
		ChDClassicLevelPort 
			name: 'Y1'
			expectedSequence: '00003FF00000003FF00000003FF00000003FF00000003FF00000003FF00000003FF00000'.	 
		ChDClassicLevelPort 
			name: 'Y2'
			expectedSequence: '0000000FFC0000000FFC0000000FFC0000000FFC000000000000000000000000000FFC00'.	 
		ChDClassicLevelPort 
			name: 'Y3'
			expectedSequence: '0000000003FF00000003FF00000003FF00000003FF00000003FF00000FFFFF0000000000'.	 
		}


]
