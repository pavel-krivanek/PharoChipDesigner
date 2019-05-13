Class {
	#name : #ChDClassicLevel2,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel2 class >> levelName [

	^ '[02] KT221A - Dual 2-Input AND Gate'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel2 >> instructions [ 

	^ 'classic02.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel2 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF00000'.
		ChipDesignerClassicLevelPort 
			name: 'B0'
			sequence: '0000000FFFFF00000FFFFF00000FFFFF00000FFFFF00000FFFFF00000FFFFF00000FFC00'.
		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: '0000000003FF00000003FF00000003FF00000003FF00000003FF00000003FF0000000000'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: '00003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00'.	 
		ChipDesignerClassicLevelPort 
			name: 'B1'
			sequence: '0000000FFC0000000003FF0000000000FFC0000000003FF0000000000FFC000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: '0000000FFC0000000003FF00000000000000000000003FF0000000000FFC000000000000'.	 
		}


]
