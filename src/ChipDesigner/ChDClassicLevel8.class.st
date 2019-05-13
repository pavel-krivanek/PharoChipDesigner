Class {
	#name : #ChDClassicLevel8,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel8 class >> levelName [

	^ '[08] K0224X - Dual Frequency Oscillator'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel8 >> instructions [ 

	^ 'classic08.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel8 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'S0'
			sequence: '000000000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFFF00000'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC0'
			expectedSequence: '00FFC00FFC00F83E0F83E0F83E0F83E0F83E0FFC00FFC00F83E0F83E0F83E0F83E0FFC00'.			

		ChipDesignerClassicLevelPort 
			name: 'S1'
			sequence: '0000000FFFFFFFFFFFFFFF0000000000FFFFFFFFFF0000000000FFFFFFFFFF0000000000'.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC1'
			expectedSequence: '00FFC00F83E0F83E0F83E0FFC00FFC00F83E0F83E0FFC00FFC00F83E0F83E0FFC00FFFE0'.	 
		}


]
