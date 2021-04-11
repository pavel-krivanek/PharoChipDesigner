Class {
	#name : #ChDClassicLevel17,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel17 class >> levelName [

	^ '[17] X901 - Radio Message Stream Decoder'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel17 >> instructions [ 

	^ 'classic17.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel17 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: 'K0'
			sequence: '00000000000000000000000000000000003FF003FF003FF0000000000003FF00000FFC00'.
		ChDClassicLevelPort 
			name: 'K1'
			sequence: '00000000000000000000000000000000003FFFFC0000000FFFFF00000003FFFFFFF00000'.
		ChDClassicLevelPort 
			name: 'K2'
			sequence: '0000000000000000000000000000000000000FFFFFFFC00003FF0000000000FFC0000000'.
		ChDClassicLevelPort 
			name: 'IN'
			sequence: '0000000FFFFF003FF00000FFC00FFFFF0000000000000000000000000000000000000000'.

		ChDClassicLevelPort 
			name: 'OUT0'
			expectedSequence: '0000000FFFFF003FF00000FFC00FFFFFFFC00FFC00FFC00FFFFFFFC00003FF00000FFC00'.	
		ChDClassicLevelPort 
			name: 'OUT1'
			expectedSequence: '0000000003FFFFC00FFC00003FF003FFFFC00003FFFFFFF00000FFFFFFFC0000000FFFFF'.	 
		ChDClassicLevelPort 
			name: 'OUT2'
			expectedSequence: '000000000000FFFFF003FF00000FFC0000000FFFFFFFC00003FF003FFFFFFF003FFFFFFF'.	 
		ChDClassicLevelPort 
			name: 'CLK'
			sequence: '00003E0F83E0F83E0F83E0F83E0F83E000000000000000000000003E0000000000000000'.	 
		}


]
