Class {
	#name : #ChDClassicLevel6,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel6 class >> levelName [

	^ '[06] KL2S1 - Dual Set-Reset Latch'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel6 >> instructions [ 

	^ 'classic06.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel6 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'S0'
			sequence: '00003FF00000000000000000000FFC000000000000003FF0000000000000000000000000'.
		ChipDesignerClassicLevelPort 
			name: 'R0'
			sequence: '000000000000FFC00000000000000000FFC000000000000000000000000000003FF00000'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Q0'
			expectedSequence: '00003FFFFFFF000000000000000FFFFF0000000000003FFFFFFFFFFFFFFFFFFFC0000000'.			

		ChipDesignerClassicLevelPort 
			name: 'S1'
			sequence: '0000000FFC0000000FFC00000000000000000FFC0000000000000000000000FFC0000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'R1'
			sequence: '0000000003FF000000000000000003FF0000000000000000000000000FFC0000000FFC00'.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: '0000000FFC0000000FFFFFFFFFFFFC0000000FFFFFFFFFFFFFFFFFFFF00000FFFFF00000'.	 
		}


]
