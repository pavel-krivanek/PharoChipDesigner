Class {
	#name : #ChDClassicLevel7,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel7 class >> levelName [

	^ '[07] KL2T1 - Dual Toggle Latch'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel7 >> instructions [ 

	^ 'classic07.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel7 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'T0'
			sequence: '00003E000000F80000000000000F8000F800000000003E0000000000000000003E000000'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Q0'
			expectedSequence: '00003FFFFFFF000000000000000FFFFF0000000000003FFFFFFFFFFFFFFFFFFFC0000000'.			

		ChipDesignerClassicLevelPort 
			name: 'T1'
			sequence: '0000000F83E000000F800000000003E000000F8000000000000000000F8000F8000F8000'.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Q1'
			expectedSequence: '0000000FFC0000000FFFFFFFFFFFFC0000000FFFFFFFFFFFFFFFFFFFF00000FFFFF00000'.	 
		}


]
