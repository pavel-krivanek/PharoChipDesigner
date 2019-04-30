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
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: 1807484548951638332871050064150417808546271801152871425639336334841190810623.
		ChipDesignerClassicLevelPort 
			name: 'A2'
			sequence: 1807484547269931066782991785428060059785466597904927945672633562124766938111.
		ChipDesignerClassicLevelPort 
			name: 'A3'
			sequence: 1895286724120940438332946554699648321487632970982088488659496892968870214733134848.			

		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: 1940773605501606408411247797646130107709097173843308165621322836656232183463544880128.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: 1942668890418244521967823573952468842491989030505867720098940984099567950364017687552.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: 1942668890418244523649530840040527121214346779266672923346884464066270723080441560064.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: 1940773605501608130481128960268819258320919206081157432763152912845935414990475363327.	 
		}


]
