Class {
	#name : #ChDClassicLevel18,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel18 class >> levelName [

	^ '[18] X902 - Grenade Launcher Ammo Counter'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel18 >> instructions [ 

	^ 'classic18.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel18 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'RST'
			sequence: '00FFC00000000000000000000000000000000003FF0000000000003FF000000000000000'.
		ChipDesignerClassicLevelPort 
			name: 'DEC'
			sequence: '0000000F83E0F83E0F83E0F83E0F83E0F83E000000003E0F83E000000003E0F83E000000'.
		ChipDesignerClassicLevelPort 
			name: 'LOW'
			expectedSequence: '000000000000000000000000000FFFFFFFFFFFFC00000000000000000000000000000000'.

		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: '0000000FFC00FFC00FFC00FFC00FFC00FFC0000000003FF003FFFFC00003FF003FFFFFFF'.	
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: '0000000FFFFF00000FFFFF00000FFFFF0000000000003FFFFC0000000003FFFFC0000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: '00FFFFF0000000000FFFFFFFFFF0000000000003FFFFC0000000003FFFFC000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: '00FFFFFFFFFFFFFFF00000000000000000000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 
		}


]
