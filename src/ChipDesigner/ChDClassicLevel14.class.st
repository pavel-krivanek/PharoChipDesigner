Class {
	#name : #ChDClassicLevel14,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel14 class >> levelName [

	^ '[14] KC84S - 4-Bit Shift Register (S-To-P)'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel14 >> instructions [ 

	^ 'classic14.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel14 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'D'
			sequence: '0000000FFFFF003FF00000FFC00003FFFFFFF00000FFC00FFFFFFFC00FFC00003FFFFC00'.
		ChipDesignerClassicLevelPort 
			name: 'CLK'
			sequence: '0000000F83E0F83E0F83E0F83E0F83E0F83E0F83E0F800000000003E0F83E00000000000'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort 
			name: 'Q0'
			expectedSequence: '0000000FFFFF003FF00000FFC00003FFFFFFF00000FFFFFFFFFFFFC00FFC000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Q1'
			expectedSequence: '0000000003FFFFC00FFC00003FF00000FFFFFFFC000000000000003FF003FFFFFFFFFFFF'.	 
		ChipDesignerClassicLevelPort 
			name: 'Q2'
			expectedSequence: '000000000000FFFFF003FF00000FFC00003FFFFFFF000000000000000FFC000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Q3'
			expectedSequence: '000000000000003FFFFC00FFC00003FF00000FFFFFFFFFFFFFFFFFC00003FFFFFFFFFFFF'.	 
		}


]
