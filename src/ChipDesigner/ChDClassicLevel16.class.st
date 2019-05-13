Class {
	#name : #ChDClassicLevel16,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel16 class >> levelName [

	^ '[16] KA181 - 2-Bit Logical Function Unit'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel16 >> instructions [ 

	^ 'classic16.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel16 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: '00003FF00000003FFFFC00FFC0000000FFFFF003FF00000003FFFFC00FFC0000000FFFFF'.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: '0000000003FF00000FFC0000000FFC00003FF00000003FF00000FFC0000000FFC00003FF'.
		ChipDesignerClassicLevelPort 
			name: 'B0'
			sequence: '0000000FFC0000000FFC00003FF00000003FF00000FFC0000000FFC00003FF00000003FF'.
		ChipDesignerClassicLevelPort 
			name: 'B1'
			sequence: '0000000003FFFFFFFFFC0000000FFFFFFFFFF00000003FFFFFFFFFC0000000FFFFFFFFFF'.

		ChipDesignerClassicLevelPort 
			name: 'F0'
			sequence: '00000000000000000003FFFFFFFFFFFFFFFFF000000000000000003FFFFFFFFFFFFFFFFF'.	
		ChipDesignerClassicLevelPort 
			name: 'F1'
			sequence: '0000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 
		ChipDesignerClassicLevelPort 
			name: 'C0'
			expectedSequence: '00000000000000000FFC00FFFFF00000FFFFF003FFFFC00003FF003FF003FFFFFFF00000'.	 
		ChipDesignerClassicLevelPort 
			name: 'C1'
			expectedSequence: '0000000003FF00000FFC0000000FFFFFFFFFF0000000000FFFFF003FFFFFFF003FFFFC00'.	 
		}


]
