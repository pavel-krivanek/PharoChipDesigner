Class {
	#name : #ChDGigatronLevel2,
	#superclass : #ChDDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDGigatronLevel2 class >> designName [

	 ^ '[02] 74HCT32 Quad 2-input OR gate'
]

{ #category : #accessing }
ChDGigatronLevel2 class >> priority [ 

	^ 2
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel2 >> createLabels [

	area descriptions add: ('+Vcc' -> (3@7)).
	area descriptions add: ('GND' -> (19@11)).
	
	area descriptions add: ((ports at: 1) name -> (3@11)). 
	area descriptions add: ((ports at: 2) name -> (3@15)). 
	area descriptions add: ((ports at: 3) name -> (7@15)). 
	area descriptions add: ((ports at: 4) name -> (11@15)). 
	area descriptions add: ((ports at: 5) name -> (15@15)). 
	area descriptions add: ((ports at: 6) name -> (19@15)). 
	area descriptions add: ((ports at: 7) name -> (19@3)). 
	area descriptions add: ((ports at: 8) name -> (15@3)). 
	area descriptions add: ((ports at: 9) name -> (19@7)). 
	area descriptions add: ((ports at: 10) name -> (7@3)). 
	area descriptions add: ((ports at: 11) name -> (3@3)). 
	area descriptions add: ((ports at: 12) name -> (11@3)). 
	
]

{ #category : #initialization }
ChDGigatronLevel2 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAADMwMDA0BRGGQMLI2cjAwNnQyMAQTFiAxAyMqCxmAhRzBXHBhCNcHTXFQHaYgbhgwgiujopiRq6YfjN0JM6/YHVEuBmsbhDbO/LTBo604QwAJoHtalcDAAA='
]

{ #category : #initialization }
ChDGigatronLevel2 >> instructions [ 

	^ '7432-768x514.png'
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel2 >> portPoints [

	^ { 3@11. 3@15. 7@15. 11@15. 15@15. 19@15. 19@3. 15@3. 19@7. 7@3. 3@3. 11@3. }
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel2 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: '1A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort 
			name: '1B'
			sequence: '00FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC00003FF00000FFC0000000'.
		ChDClassicLevelPort 
			name: '1Y'
			expectedSequence: '00FFC00FFFFFFFC00FFC00FFFFFFFC00FFC00FFFFFFFC00FFC00FFFFFFFC00FFC00FFC00'.	 

		ChDClassicLevelPort 
			name: '2A'
			sequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000FFC0000000'.
		ChDClassicLevelPort 
			name: '2B'
			sequence: '00003FF00000FFC00FFC00003FF003FF00000FFC00FFC00003FF003FF00000FFC00FFC00'.
		ChDClassicLevelPort 
			name: '2Y'
			expectedSequence: '00FFFFF00000FFC00FFC00FFFFF003FFFFC00FFC00FFC00003FFFFFFF00000FFC00FFC00'.	 

		ChDClassicLevelPort 
			name: '3A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00FFC00'.
		ChDClassicLevelPort 
			name: '3B'
			sequence: '00FFC00F83E0003FFFFC1FF801F00000003FF07C1FFFC00003E0F800000000FFC00FFC00'.
		ChDClassicLevelPort 
			name: '3Y'	
			expectedSequence: '00FFC00FFFE0FFFFFFFC1FFFC1FFFC00FFFFFFFC1FFFC00FFFE0FFC00FFC00FFC00FFC00'.	 

		ChDClassicLevelPort 
			name: '4A'
			sequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFFC00003FF00000FFC00003FF8000FFC0000000'.
		ChDClassicLevelPort 
			name: '4B'
			sequence: '00FFC0000000FFC0000000FFC0000000FFC0000000FFC000000007FE007FE00000FF801F'.
		ChDClassicLevelPort 
			name: '4Y'
			expectedSequence: '00FFC00FFC00FFC00FFC00FFC00FFC00FFFE00001FFFC0007FE007FFFFFFE0FFC1FF801F'.	 

		}


]

{ #category : #'as yet unclassified' }
ChDGigatronLevel2 >> vccPoints [

	^ { 3@7 }
]
