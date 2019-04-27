Class {
	#name : #ChDClassicLevel19,
	#superclass : #ChDClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDClassicLevel19 class >> levelName [

	^ '19) X903 - Gatling Cannon Fire Controller'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel19 >> instructions [ 

	^ 'classic19.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel19 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'FIRE'
			sequence: 1809251394333065553493296640760748558846215340791094592969933453019578368000.
		ChipDesignerClassicLevelPort 
			name: 'LOCK'
			sequence: 1725434941193085158148186249241239458149418352329945174454753508196352.
		ChipDesignerClassicLevelPort 
			name: 'TRIG'
			expectedSequence: 219302990169469619443410726372666583952334205014877850063607151304978202624.

		ChipDesignerClassicLevelPort 
			name: 'A+'
			expectedSequence: 1942668892223962223854685129430447372591073575001175499172904918794961266945319501823.	
		ChipDesignerClassicLevelPort 
			name: 'A-'
			expectedSequence: 1766847064776777393071534051333264050964022078907490943943018259888996352.	 
		ChipDesignerClassicLevelPort 
			name: 'B+'
			expectedSequence: 1725436586696071671424842296772093990663871623393249879262765017726975.	 
		ChipDesignerClassicLevelPort 
			name: 'B-'
			expectedSequence: 1942668892225727345482875210751847481800110066958148857380189016489025022440190771200.	 
		}


]
