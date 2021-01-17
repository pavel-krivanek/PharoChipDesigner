Class {
	#name : #ChDPlaygroundDIL14,
	#superclass : #ChDDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDPlaygroundDIL14 class >> designName [

	 ^ 'Playground DIL14'
]

{ #category : #testing }
ChDPlaygroundDIL14 class >> isRoot [ 

	^ true
]

{ #category : #accessing }
ChDPlaygroundDIL14 class >> priority [ 

	^ 340
]

{ #category : #'as yet unclassified' }
ChDPlaygroundDIL14 >> createLabels [

	area descriptions add: ('+Vcc' -> (42@4)).
	area descriptions add: ('GND' -> (3@28)).
	
	1 to: 6 do: [ :i |
		area descriptions add: ((ports at: i) name -> (3@(4+((i-1)*4)))) ] .

	1 to: 6 do: [ :i |
		area descriptions add: ((ports at: i+6) name -> (42@(8+((i-1)*4)))) ].
]

{ #category : #initialization }
ChDPlaygroundDIL14 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAAOWSMQ7AIAhFrwTUGlcl7f2PVPyN2NDFqUuXF3n5AiYSkaiBT0MTIVIWYqCwuVTejpK5o5dA9VxwyOVeAuK54Hb9/9z/z/1mLvU/nu7SThManWW3vLYkXOWxAU4T2XPot/AYOPF1xbs83egX7ja5AOFrWrrUAwAA'
]

{ #category : #'as yet unclassified' }
ChDPlaygroundDIL14 >> instructions [ 

	^ 'intro.png'
]

{ #category : #'as yet unclassified' }
ChDPlaygroundDIL14 >> portPoints [

	^ ((1 to: 6) collect: [ :i | 3@(4+((i-1)*4))]),
	((1 to: 6) collect: [ :i | 42@(8+((i-1)*4))])

]

{ #category : #'as yet unclassified' }
ChDPlaygroundDIL14 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: '00FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC0000000'.
		ChipDesignerClassicLevelPort 
			name: 'A2'
			sequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000'.
		ChipDesignerClassicLevelPort 
			name: 'A3'
			sequence: '00003FF00000FFC00FFC00003FF003FF00000FFC00FFC00003FF003FF00000FFC00FFC00'.			
		ChipDesignerClassicLevelPort 
			name: 'A4'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			
		ChipDesignerClassicLevelPort 
			name: 'A5'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			


		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y4'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChipDesignerClassicLevelPort 
			name: 'Y5'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	
		}


]

{ #category : #'as yet unclassified' }
ChDPlaygroundDIL14 >> vccPoints [

	^ { 42@3 }
]
