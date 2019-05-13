Class {
	#name : #ChDClassicLevel12,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel12 class >> levelName [

	^ '[12] KM141P - 4-To-1 Multiplexer'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel12 >> instructions [ 

	^ 'classic12.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel12 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A'
			sequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FFFFFFFFFFFF003FF00000'.
		ChipDesignerClassicLevelPort 
			name: 'B'
			sequence: '00003FFFFFFF00000FFFFF00000FFFFF00000FFFFF00000003FF00000FFFFF003FFFFC00'.
		ChipDesignerClassicLevelPort 
			name: 'C'
			sequence: '000000000000FFFFFFFFFF0000000000FFFFFFFFFF003FFFFFFFFFFFFFFFFF003FFFFC00'.
		ChipDesignerClassicLevelPort 
			name: 'D'
			sequence: '00FFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFFF0000000000FFC00FFC00003FFFFC00'.

		ChipDesignerClassicLevelPort 
			name: 'Z'
			expectedSequence: '00003FF003FF00000FFC0000000003FF00000FFFFF0000000000FFC00FFC00003FFFFC00'.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'S0'
			sequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FFFFFFF003FF00000'.	 
		ChipDesignerClassicLevelPort 
			name: 'S1'
			sequence: '0000000FFFFF00000FFFFF00000FFFFF00000FFFFF00000003FF00000FFFFF00000FFC00'.	 
		}


]
