Class {
	#name : #ChDClassicLevel12,
	#superclass : #ChDClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDClassicLevel12 class >> levelName [

	^ '12) KM141P - 4-To-1 Multiplexer'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel12 >> instructions [ 

	^ 'classic12.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel12 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A'
			sequence: 1850865943249790839606404302362323114863758031704388034629824206354606950710272.
		ChipDesignerClassicLevelPort 
			name: 'B'
			sequence: 1897135782579639592537556526522838860679485337321133523702681969833725322516757504.
		ChipDesignerClassicLevelPort 
			name: 'C'
			sequence: 1897135782579641277532617854667504306087344222231278132096703193369203244061949952.
		ChipDesignerClassicLevelPort 
			name: 'D'
			sequence: 1897135780814517965988162088394521957177606090422467821574013580817112351241142271.

		ChipDesignerClassicLevelPort 
			name: 'Z'
			expectedSequence: 1897135780814517965988162088394521957176212295175489579199159869680060105751526400.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'S0'
			sequence: 1850865943249789195708785025415271235436537566695045654416161566557536437402624.	 
		ChipDesignerClassicLevelPort 
			name: 'S1'
			sequence: 1895284918403236866476332884059340614902393224909993675311863765014348836084121600.	 
		}


]
