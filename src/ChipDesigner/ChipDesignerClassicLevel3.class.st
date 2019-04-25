Class {
	#name : #ChipDesignerClassicLevel3,
	#superclass : #ChipDesignerClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChipDesignerClassicLevel3 class >> levelName [

	^ 'KT141AO - 4-Input AND/OR Gate'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel3 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A'
			sequence: 1897135782579641275888718667647618946977759646573899797852257896608079642383875072.
		ChipDesignerClassicLevelPort 
			name: 'B'
			sequence: 1895284918403236866476332884059340614902393224909994941724523953958370057888202752.
		ChipDesignerClassicLevelPort 
			name: 'C'
			sequence: 1895284918403238551469787274161243647711336992316038960784724448312193959961034752.
		ChipDesignerClassicLevelPort 
			name: 'D'
			sequence: 1897135782579639594179848777030960768954955349886838941206589942299927920404070400.			

		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'X'
			expectedSequence: 1895284918403236866474727515290515469871188324304731135791141220154895078055215104.	 
		ChipDesignerClassicLevelPort 
			name: 'Y'
			expectedSequence: 1897135782579641277532616286924566000283042122971497353114115298483274780854189056.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		}


]
