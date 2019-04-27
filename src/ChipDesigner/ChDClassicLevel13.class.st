Class {
	#name : #ChDClassicLevel13,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel13 class >> levelName [

	^ '13) KC84C - 4-Bit Counter With Clear'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel13 >> instructions [ 

	^ 'classic13.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel13 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'CLR'
			sequence: 1895284916636391486694615251391028819347674112152190112883759912446443782773146623.
		ChipDesignerClassicLevelPort 
			name: 'INC'
			sequence: 53540820094935750674654182917108369026011332277623774736368303420211200.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: 1852673426073305891243203682493828687965703538129880233794316398775712678412288.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: 1852673427797057481274147714366809613627764566865275677372517136095285662973952.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: 1569275433846670189597817888119400690211374685763928064000.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: 1569275433846670190958947355800678663986303480841109504000.	 
		}


]
