Class {
	#name : #ChDClassicLevel9,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel9 class >> levelName [

	^ '[09] KD124 - 2-To-4 Line Decoder'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel9 >> instructions [ 

	^ 'classic09.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel9 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: 'A0'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort 
			name: 'A1'
			sequence: '00FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC0000000'.
		ChDClassicLevelPort 
			name: 'A2'
			sequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000'.
		ChDClassicLevelPort 
			name: 'A3'
			sequence: '00003FF00000FFC00FFC00003FF003FF00000FFC00FFC00003FF003FF00000FFC00FFC00'.			

		ChDClassicLevelPort 
			name: 'Y0'
			expectedSequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF'.	 
		ChDClassicLevelPort 
			name: 'Y1'
			expectedSequence: '00003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFFFF'.	 
		ChDClassicLevelPort 
			name: 'Y2'
			expectedSequence: '00003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF'.	 
		ChDClassicLevelPort 
			name: 'Y3'
			expectedSequence: '00FFC00FFFFF003FF003FFFFC00FFC00FFFFF003FF003FFFFC00FFC00FFFFF003FF003FF'.	 
		}


]
