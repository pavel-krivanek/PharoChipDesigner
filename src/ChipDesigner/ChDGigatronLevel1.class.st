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

	area descriptions add: ('+Vcc' -> (3@7)).
	area descriptions add: ('GND' -> (19@11)).
	
	area descriptions add: ((ports at: 1) name -> (3@11)). 
	area descriptions add: ((ports at: 2) name -> (3@15)). 
	area descriptions add: ((ports at: 3) name -> (7@15)). 
	area descriptions add: ((ports at: 4) name -> (11@15)). 
	area descriptions add: ((ports at: 5) name -> (15@15)). 
	area descriptions add: ((ports at: 6) name -> (19@15)). 
	area descriptions add: ((ports at: 7) name -> (3@3)). 
	area descriptions add: ((ports at: 8) name -> (7@3)). 
	area descriptions add: ((ports at: 9) name -> (11@3)). 
	area descriptions add: ((ports at: 10) name -> (15@3)). 
	area descriptions add: ((ports at: 11) name -> (19@3)). 
	area descriptions add: ((ports at: 12) name -> (19@7)). 
	
]

{ #category : #initialization }
ChDGigatronLevel1 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAADMwMDA0BRGGQMLI2cjAwNnQyMAQTFiAxAyMqCxmAhRzBXHBhCNcHTXFQHaYgbhgwgiujopiRq6YfjN0JM6/YHVEuBmsbhDbO/LTBo604QwAJoHtalcDAAA='
]

{ #category : #initialization }
ChDGigatronLevel1 >> instructions [ 

	^ '7404-768x485.png'
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> portPoints [

	^ { 3@11. 3@15. 7@15. 11@15. 15@15. 19@15. 3@3. 7@3. 11@3. 15@3. 19@3. 19@7 }
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: '1A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort 
			name: '1Y'
			expectedSequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF'.	 

		ChDClassicLevelPort 
			name: '2A'
			sequence: '00FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC0000000'.
		ChDClassicLevelPort 
			name: '2Y'
			expectedSequence: '00003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFC00FFFFF003FFFFFFF'.	 

		ChDClassicLevelPort 
			name: '3A'
			sequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000'.
		ChDClassicLevelPort 
			name: '3Y'
			expectedSequence: '00003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF003FFFFFFF'.	 

		ChDClassicLevelPort 
			name: '6A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			
		ChDClassicLevelPort 
			name: '6Y'
			expectedSequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF'.	

		ChDClassicLevelPort 
			name: '5A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.			
		ChDClassicLevelPort 
			name: '5Y'
			expectedSequence: '00003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF003FF'.	 

		ChDClassicLevelPort  
			name: '4A'
			sequence: '00003FF00000FFC00FFC00003FF003FF00000FFC00FFC00003FF003FF00000FFC00FFC00'.			
		ChDClassicLevelPort 
			name: '4Y'
			expectedSequence: '00FFC00FFFFF003FF003FFFFC00FFC00FFFFF003FF003FFFFC00FFC00FFFFF003FF003FF'.	 

		}


]

{ #category : #'as yet unclassified' }
ChDGigatronLevel1 >> vccPoints [

	^ { 3@7 }
]
