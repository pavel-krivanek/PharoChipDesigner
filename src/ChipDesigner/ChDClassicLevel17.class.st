Class {
	#name : #ChDClassicLevel17,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel17 class >> levelName [

	^ '17) X901 - Radio Message Stream Decoder'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel17 >> instructions [ 

	^ 'classic17.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel17 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'K0'
			sequence: 1895284918401513114884696572789642910784716455884081128531064682058084438513811456.
		ChipDesignerClassicLevelPort 
			name: 'K1'
			sequence: 1852673426071622541686431325043768396982498702023804538233860031445058979889152.
		ChipDesignerClassicLevelPort 
			name: 'K2'
			sequence: 1807484547268288774532483664981286225742674344273766467827228152751506587648.
		ChipDesignerClassicLevelPort 
			name: 'IN'
			sequence: 1329226729371046759291967913512140800.

		ChipDesignerClassicLevelPort 
			name: 'OUT0'
			expectedSequence: 1895284918401513116530201127048848106409597463616419853698638263012331630432878592.	
		ChipDesignerClassicLevelPort 
			name: 'OUT1'
			expectedSequence: 1942667039552302999296920220392193862874009856553436200639472203540349553855587942400.	 
		ChipDesignerClassicLevelPort 
			name: 'OUT2'
			expectedSequence: 1942668890418244523649530838471254679061526812229225758819644994608751215692904136704.	 
		ChipDesignerClassicLevelPort 
			name: 'CLK'
			sequence: 51010641276957387306804044659318145290700718376244121432300223488.	 
		}


]
