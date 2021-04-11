Class {
	#name : #ChDClassicLevel4,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel4 class >> levelName [

	^ '[04] KO229 - Power On Reset Generator'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel4 >> instructions [ 

	^ 'classic04.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel4 >> portsDefinition [

	^ { 
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort notConnectedNamed: 'N/C'.

		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort 
			name: 'RST'
			expectedSequence: '00FFC0000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChDClassicLevelPort 
			name: '/RST'
			expectedSequence: '00003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		}


]
