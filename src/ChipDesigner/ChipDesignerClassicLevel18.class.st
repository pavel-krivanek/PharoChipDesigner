Class {
	#name : #ChipDesignerClassicLevel18,
	#superclass : #ChipDesignerClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChipDesignerClassicLevel18 class >> levelName [

	^ '18) X902 - Grenade Launcher Ammo Counter'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel18 >> instructions [ 

	^ 'classic18.png'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel18 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'RST'
			sequence: 1683351162139593782584607863394366524919965337289985724725176828927.
		ChipDesignerClassicLevelPort 
			name: 'DEC'
			sequence: 56141618971867349748073722910385762436120529410491668538043523607018773413888.
		ChipDesignerClassicLevelPort 
			name: 'LOW'
			expectedSequence: 1427247692705958613407685741220093639679541248.

		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: 1942668890418242798216233543008435475852109669701442019623528616285891624300570476544.	
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: 1809249668896478857421623719340776555066668739580174197641003792721326899200.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: 1725434941193083627149223059979225688044232121322462444323298346008575.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: 1942668892225729070919461906823518906640979591359433561370754123770607711573432598527.	 
		}


]
