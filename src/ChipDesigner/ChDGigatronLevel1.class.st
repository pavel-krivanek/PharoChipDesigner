Class {
	#name : #ChDGigatronLevel1,
	#superclass : #ChDDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDGigatronLevel1 class >> designName [

	 ^ '[01] 74HCT04 Hex inverter'
]

{ #category : #accessing }
ChDGigatronLevel1 class >> priority [ 

	^ 1
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> createLabels [

	area descriptions add: ('+Vcc' -> (42@4)).
	area descriptions add: ('GND' -> (3@28)).
	
	1 to: 6 do: [ :i |
		area descriptions add: ((ports at: i) name -> (3@(4+((i-1)*4)))) ] .

	1 to: 6 do: [ :i |
		area descriptions add: ((ports at: i+6) name -> (42@(8+((i-1)*4)))) ].
]

{ #category : #initialization }
ChDGigatronLevel1 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAAOWSMQ7AIAhFrwTUGlcl7f2PVPyN2NDFqUuXF3n5AiYSkaiBT0MTIVIWYqCwuVTejpK5o5dA9VxwyOVeAuK54Hb9/9z/z/1mLvU/nu7SThManWW3vLYkXOWxAU4T2XPot/AYOPF1xbs83egX7ja5AOFrWrrUAwAA'
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> instructions [ 

	^ 'intro.png'
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> portPoints [

	^ ((1 to: 6) collect: [ :i | 3@(4+((i-1)*4))]),
	((1 to: 6) collect: [ :i | 42@(8+((i-1)*4))])

]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: '1A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChipDesignerClassicLevelPort 
			name: '1Y'
			expectedSequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF'.	 

		ChipDesignerClassicLevelPort 
			name: '2A'
			sequence: '00FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC0000000'.
		ChipDesignerClassicLevelPort 
			name: '2Y'
			expectedSequence: '00003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFFFF'.	 

		ChipDesignerClassicLevelPort 
			name: '3A'
			sequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000'.
		ChipDesignerClassicLevelPort 
			name: '3Y'
			expectedSequence: '00003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF'.	 

		ChipDesignerClassicLevelPort 
			name: '6A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			
		ChipDesignerClassicLevelPort 
			name: '6Y'
			expectedSequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF'.	

		ChipDesignerClassicLevelPort 
			name: '5A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			
		ChipDesignerClassicLevelPort 
			name: '5Y'
			expectedSequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF'.	 

		ChipDesignerClassicLevelPort  
			name: '4A'
			sequence: '00003FF00000FFC00FFC00003FF003FF00000FFC00FFC00003FF003FF00000FFC00FFC00'.			
		ChipDesignerClassicLevelPort 
			name: '4Y'
			expectedSequence: '00FFC00FFFFF003FF003FFFFC00FFC00FFFFF003FF003FFFFC00FFC00FFFFF003FF003FF'.	 

		}


]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> vccPoints [

	^ { 42@3 }
]
