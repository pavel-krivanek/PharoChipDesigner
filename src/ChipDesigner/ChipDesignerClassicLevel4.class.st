Class {
	#name : #ChipDesignerClassicLevel4,
	#superclass : #ChipDesignerClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChipDesignerClassicLevel4 class >> levelName [

	^ '4) KO229 - Power On Reset Generator'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel4 >> instructions [ 

	^ 'classic04.png'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel4 >> portsDefinition [

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
