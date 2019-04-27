Class {
	#name : #ChDClassicLevel4,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel4 class >> levelName [

	^ '4) KO229 - Power On Reset Generator'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel4 >> instructions [ 

	^ 'classic04.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel4 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'RST'
			expectedSequence: 1023.	 
		ChipDesignerClassicLevelPort 
			name: '/RST'
			expectedSequence: 1942668892225729070919461906823518906642406839052139521251812409738904285205208497152.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		}


]
