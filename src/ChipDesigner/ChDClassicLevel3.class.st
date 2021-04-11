Class {
	#name : #ChDClassicLevel3,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel3 class >> levelName [

	^ '[03] KT141AO - 4-Input AND/OR Gate'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel3 >> instructions [ 

	^ 'classic03.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel3 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: 'A'
			sequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FFFFFFF003FFFFC00'.
		ChDClassicLevelPort 
			name: 'B'
			sequence: '0000000FFFFF00000FFFFF003FFFFFFF00000FFFFF00000003FF00000FFFFF00000FFC00'.
		ChDClassicLevelPort 
			name: 'C'
			sequence: '0000000003FFFFFFFFFFFF003FF00000FFFFFFFFFF0000000000FFFFFFFFFF00000FFC00'.
		ChDClassicLevelPort 
			name: 'D'
			sequence: '0000000003FF0000000000FFFFFFFFFFFFFFFFFFFF0000000000FFC00FFFFF003FFFFC00'.			

		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort 
			name: 'X'
			expectedSequence: '0000000003FF0000000000003FF0000000000003FF000000000000000FFFFF00000FFC00'.	 
		ChDClassicLevelPort 
			name: 'Y'
			expectedSequence: '00003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003FF003FFFFFFFFFFFF003FFFFC00'.	 
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		}


]
