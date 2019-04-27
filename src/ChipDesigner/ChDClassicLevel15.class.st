Class {
	#name : #ChDClassicLevel15,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel15 class >> levelName [

	^ '15) KR8S1 - 8 Bit Addressable SRAM'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel15 >> instructions [ 

	^ 'classic15.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel15 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: 1895286724122662508214109177388798933309663850357750323939543979491114409798926336.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: 1895286724122662508215712978414687229759248494980929054288416250971054156172754944.
		ChipDesignerClassicLevelPort 
			name: 'A2'
			sequence: 1895286724122662508215714547687127922503433457457764858376501165431315121670455296.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort 
			name: 'R/W'
			sequence: 1807484547268287169163713343260005643052645494187512048011901573649422876671.	 
		ChipDesignerClassicLevelPort 
			name: 'CLK'
			sequence: 1895284971410375931409621740651284887738364994933130285067124721554820918494133248.	 
		ChipDesignerClassicLevelPort 
			name: 'Din'
			sequence: 1327929922807013280615360487018724352.	 
		ChipDesignerClassicLevelPort 
			name: 'Dout'
			expectedSequence: 1725436585090702902601158765809367913170417459559269372143153291722752.	 
		}


]
