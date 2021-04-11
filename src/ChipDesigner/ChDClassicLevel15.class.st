Class {
	#name : #ChDClassicLevel15,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel15 class >> levelName [

	^ '[15] KR8S1 - 8 Bit Addressable SRAM'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel15 >> instructions [ 

	^ 'classic15.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel15 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: 'A0'
			sequence: '0000000FFC00003FFFFC00FFFFF003FF00000FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort 
			name: 'A1'
			sequence: '0000000003FFFFFFFFFC0000000FFFFF00000003FFFFC00003FFFFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort 
			name: 'A2'
			sequence: '00000000000000000003FFFFFFFFFFFF0000000000003FFFFFFFFFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort notConnectedNamed: 'N/C'.

		ChDClassicLevelPort 
			name: 'R/W'
			sequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC000000000000000000000000000FFC0000000'.	 
		ChDClassicLevelPort 
			name: 'CLK'
			sequence: '00003E0F83E0F83E0F83E0F83E0F83E0003FFFFFFFFFFFFFFFFFFFFFFFFC00F8000FFC00'.	 
		ChDClassicLevelPort 
			name: 'Din'
			sequence: '00003FF00000FFFFF00000FFC00003FF0000000000000000000000000000000000000000'.	 
		ChDClassicLevelPort 
			name: 'Dout'
			expectedSequence: '00000000000000000000000000000000003FF003FF0000000000FFFFFFFC000000000000'.	 
		}


]
