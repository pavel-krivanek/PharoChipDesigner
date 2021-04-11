Class {
	#name : #ChDClassicLevel19,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel19 class >> levelName [

	^ '[19] X903 - Gatling Cannon Fire Controller'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel19 >> instructions [ 

	^ 'classic19.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel19 >> portsDefinition [

	^ { 
		ChDClassicLevelPort notConnectedNamed: 'N/C'.
		ChDClassicLevelPort 
			name: 'FIRE'
			sequence: '0000000003FFFFFFFFFFFFFFFFFFFC00003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0000000'.
		ChDClassicLevelPort 
			name: 'LOCK'
			sequence: '0000000000000000000000000000000000000003FFFFFFF00000003FFFFC000000000000'.
		ChDClassicLevelPort 
			name: 'TRIG'
			expectedSequence: '0000000000F83E0F83E0F83E0F83E000000F83E000000003E0F83E000000F83E00000000'.

		ChDClassicLevelPort 
			name: 'A+'
			expectedSequence: '00FFFFFFFC00003FFFFC00003FFFFFFFFFC000000000000FFFFF0000000000FFFFFFFFFF'.	
		ChDClassicLevelPort 
			name: 'A-'
			expectedSequence: '0000000003FFFFC00003FFFFC0000000003FFFFFFFFFFFF00000FFFFFFFFFF0000000000'.	 
		ChDClassicLevelPort 
			name: 'B+'
			expectedSequence: '00FFFFFFFFFF00000FFFFF00000FFFFFFFFFF0000000000003FFFFFFFFFC000000000000'.	 
		ChDClassicLevelPort 
			name: 'B-'
			expectedSequence: '000000000000FFFFF00000FFFFF0000000000FFFFFFFFFFFFC0000000003FFFFFFFFFFFF'.	 
		}


]
