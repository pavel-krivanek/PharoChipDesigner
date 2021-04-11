Class {
	#name : #ChDGigatronLevel3,
	#superclass : #ChDDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDGigatronLevel3 class >> designName [

	 ^ '[03] 74HCT138 3-to-8 decoder'
]

{ #category : #accessing }
ChDGigatronLevel3 class >> priority [ 

	^ 3
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel3 >> createLabels [

	area descriptions add: ('+Vcc' -> (42@4)).
	area descriptions add: ('GND' -> (3@32)).
	
	1 to: 7 do: [ :i |
		area descriptions add: ((ports at: i) name -> (3@(4+((i-1)*4)))) ] .

	1 to: 7 do: [ :i |
		area descriptions add: ((ports at: i+7) name -> (42@(32-((i-1)*4)))) ].

	
]

{ #category : #initialization }
ChDGigatronLevel3 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAAOWNMQ7AIAwDv+S4FGUtEf//EkkGBjoyZjnJJ0sHgBZ4HIMETAhJqLhr+ndo7mbMxLd/h8tfj5ng/h3utfrd+t363dvu4AKGMbHuzwMAAA=='
]

{ #category : #initialization }
ChDGigatronLevel3 >> instructions [ 

	^ '74138.png'
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel3 >> portPoints [

	^ ((1 to: 7) collect: [ :i | 3@(4+((i-1)*4))]),
	((1 to: 7) collect: [ :i | 42@(32-((i-1)*4))])
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel3 >> portsDefinition [

	^ { 
		ChDClassicLevelPort 
			name: 'A'
			sequence: '0007C00FFFE007FE00000007FE007FE007FE007FE007FE007FE007FE007FE007FE000000'.
		ChDClassicLevelPort 
			name: 'B'
			sequence: '00F801FFFFE007C00000000001FFFFE00001FFFFE00001FFFFE00001FFFFE00001FFFC00'.
		ChDClassicLevelPort 
			name: 'C'
			sequence: '00FFC00FFC00FFC0000000000000001FFFFFFFFFE0000000001FFFFFFFFFE00000000000'.	 

		ChDClassicLevelPort 
			name: '/G2A'
			sequence: '00FFFFF003FF003FF0000000000000000000000000000000000000000000000000000000'.
		ChDClassicLevelPort 
			name: '/G2B'
			sequence: '00FFC00FFFFF003FF0000000000000000000000000000000000000000000000000000000'.
		ChDClassicLevelPort 
			name: 'G1'
			sequence: '00FFC00FFC0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 

		ChDClassicLevelPort 
			name: 'Y7'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFF'.
		ChDClassicLevelPort 
			name: 'Y6'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFF'.
		ChDClassicLevelPort 
			name: 'Y5'	
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFF'.	 

		ChDClassicLevelPort 
			name: 'Y4'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFFF'.
		ChDClassicLevelPort 
			name: 'Y3'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFF'.
		ChDClassicLevelPort 
			name: 'Y2'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE0003FF'.							
		
		ChDClassicLevelPort 
			name: 'Y1'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFF'.
		ChDClassicLevelPort 
			name: 'Y0'
			expectedSequence: '00FFFFFFFFFFFFFFF0000007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFC00'.	 

		}


]

{ #category : #'as yet unclassified' }
ChDGigatronLevel3 >> vccPoints [

	^ { 42@4 }
]
