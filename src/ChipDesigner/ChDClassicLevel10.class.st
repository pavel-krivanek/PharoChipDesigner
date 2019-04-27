Class {
	#name : #ChDClassicLevel10,
	#superclass : #ChDClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDClassicLevel10 class >> levelName [

	^ '10) KA189 - 2Bit Adder With Carry'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel10 >> instructions [ 

	^ 'classic10.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel10 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: 1850865943249789195708785025415271235436537566695045654416161566557536437402624.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: 1895284918403236866476332884059340614902393224909993675311863765014348836084121600.
		ChipDesignerClassicLevelPort 
			name: 'B0'
			sequence: 1766847064776777391539039971969013883308832942174222524326649533772595200.
		ChipDesignerClassicLevelPort 
			name: 'B1'
			sequence: 1897135780814517965988162088394521957177606090422467821574013580817111251729514496.

		ChipDesignerClassicLevelPort 
			name: 'S0'
			expectedSequence: 1850864176402727706726632040269405876987607050463598402379256703304731253013504.	 
		ChipDesignerClassicLevelPort 
			name: 'S1'
			expectedSequence: 1850864178128162647919714134924548146861407824096101962133986297735972364746752.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'C'
			expectedSequence: 1895284918403236866474727515290515471298434657210448794818436537064337642463690752.	 
		}


]
