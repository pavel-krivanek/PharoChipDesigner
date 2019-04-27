Class {
	#name : #ChDClassicLevel9,
	#superclass : #ChDClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDClassicLevel9 class >> levelName [

	^ '9) KD124 - 2-To-4 Line Decoder'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel9 >> instructions [ 

	^ 'classic09.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel9 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'A'
			sequence: 1850865943249789195708785025415271235436537566695045654416161566557536437402624.
		ChipDesignerClassicLevelPort 
			name: 'B'
			sequence: 1895284918403236866476332884059340614902393224909993675311863765014348836084121600.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: 1940771756443149429643573188155871287694003225509433272930284177197122320607779750911.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: 1850864176404409412385783588278333501220317796254646216368776767615761344625664.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: 1895284916636391486693009882622203677168177005139553275873816380215407060991344640.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: 1766845379783323001437136937734216219770440399438047384798941775092776960.	 
		}


]
