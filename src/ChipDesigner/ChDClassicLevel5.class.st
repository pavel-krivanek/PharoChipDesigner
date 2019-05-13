Class {
	#name : #ChDClassicLevel5,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel5 class >> levelName [

	^ '[05] KO223 - Dual Fixed Frequency Oscillator'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel5 >> instructions [ 

	^ 'classic05.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel5 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'EN0'
			sequence: '000000000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFC0000000'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC0'
			expectedSequence: '000000000000FFC00FFC00FFC00FFC00FFC000000000000FFC00FFC00FFC00FFC0000000'.			

		ChipDesignerClassicLevelPort 
			name: 'EN1'
			sequence: '0000000FFFFFFFFFFFFFFF0000000000FFFFFFFFFF0000000000FFFFFFFFFFFFC0000000'.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC1'
			expectedSequence: '0000000FFC00FFC00FFC000000000000FFC00FFC000000000000FFC00FFC00FFC0000000'.	 
		}


]
