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

	^ 640
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

	area decodedFromZipString: 'H4sIAAAAAAAAAOWNwQkAIAwDV0qDil9bdP+RrH340A30c5AjcABoDhkOJQETQgJV3KV6OyR3fc1A27/Dxa+sGeD+HS7b/93/u+90lRMtwLCcVwMAAA=='
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
		ChDClassicLevelPort 
			name: 'A0'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort 
			name: 'A1'
			sequence: '00FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC0000000'.
		ChDClassicLevelPort 
			name: 'A2'
			sequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000'.
		ChDClassicLevelPort 
			name: 'A3'
			sequence: '00003FF00000FFC00FFC00003FF003FF00000FFC00FFC00003FF003FF00000FFC00FFC00'.			
		ChDClassicLevelPort 
			name: 'A4'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			
		ChDClassicLevelPort 
			name: 'A5'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			


		ChDClassicLevelPort 
			name: 'Y0'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChDClassicLevelPort 
			name: 'Y1'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChDClassicLevelPort 
			name: 'Y2'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChDClassicLevelPort 
			name: 'Y3'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChDClassicLevelPort 
			name: 'Y4'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	 
		ChDClassicLevelPort 
			name: 'Y5'
			expectedSequence: '000000000000000000000000000000000000000000000000000000000000000000000000'.	
		}


]

{ #category : #'as yet unclassified' }
ChDPlaygroundDIL14 >> vccPoints [

	^ { 42@3 }
]
