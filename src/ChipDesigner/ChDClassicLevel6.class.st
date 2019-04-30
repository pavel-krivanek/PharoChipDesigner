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
			sequence: 1530998963189262013771403260445641188484342574639741952.
		ChipDesignerClassicLevelPort 
			name: 'R0'
			sequence: 1850864176402726061223642463498245777093472211379536359756185415123953619304448.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Q0'
			expectedSequence: 1809251394333065553493295144183071933364084496555499427287387029111807409152.			

		ChipDesignerClassicLevelPort 
			name: 'S1'
			sequence: 1807484547268287169163713343261431495587647078220870135324899297750015803392.	 
		ChipDesignerClassicLevelPort 
			name: 'R1'
			sequence: 1895284916638115238283040826654075198019449427971330348689640088891208202662707200.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: 1852671660951679345059503091828672469782946080473364738826495370471075711287296.	 
		}


]
