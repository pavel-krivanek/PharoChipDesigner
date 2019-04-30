Class {
	#name : #ChDClassicLevel8,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel8 class >> levelName [

	^ '[08] K0224X - Dual Frequency Oscillator'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel8 >> instructions [ 

	^ 'classic08.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel8 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'S0'
			sequence: 1852673427797059126777134227643465661157257971211385820668120117426910973132800.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC0'
			expectedSequence: 1895341058255415639999881916994233443817747041792403426342761634783158282556015615.			

		ChipDesignerClassicLevelPort 
			name: 'S1'
			sequence: 1766847064776777391539039971969013883308832942174222524326650633283174400.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC1'
			expectedSequence: 60706552016164324495538329013979241082942646642274207668493756788325128787624723455.	 
		}


]
