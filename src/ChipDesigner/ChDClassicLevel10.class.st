Class {
	#name : #ChDClassicLevel10,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel10 class >> levelName [

	^ '[10] KA189 - 2Bit Adder With Carry'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel10 >> instructions [ 

	^ 'classic10.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel10 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: 'A0'
			sequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FFFFFFF003FF00000'.
		ChDClassicLevelPort 
			name: 'A1'
			sequence: '0000000FFFFF00000FFFFF00000FFFFF00000FFFFF00000003FF00000FFFFF00000FFC00'.
		ChDClassicLevelPort 
			name: 'B0'
			sequence: '000000000000FFFFFFFFFF0000000000FFFFFFFFFF0000000000FFFFFFFFFF0000000000'.
		ChDClassicLevelPort 
			name: 'B1'
			sequence: '0000000000000000000000FFFFFFFFFFFFFFFFFFFF0000000000FFC00FFC00003FFFFC00'.

		ChDClassicLevelPort 
			name: 'S0'
			expectedSequence: '00003FF003FFFFC00FFC00003FF003FFFFC00FFC00003FF003FFFFC0000000003FF00000'.	 
		ChDClassicLevelPort 
			name: 'S1'
			expectedSequence: '0000000FFFFF003FFFFC00FFFFF00000FFC00003FF00000003FFFFFFFFFC00003FF00000'.	 
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort 
			name: 'C'
			expectedSequence: '00000000000000000003FF00000FFFFF003FFFFFFF000000000000000FFFFF00000FFC00'.	 
		}


]
