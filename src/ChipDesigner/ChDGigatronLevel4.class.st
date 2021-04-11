Class {
	#name : #ChDGigatronLevel4,
	#superclass : #ChDDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDGigatronLevel4 class >> designName [

	 ^ '[04] 74HCT139 Dual 2-to-4 decoder'
]

{ #category : #accessing }
ChDGigatronLevel4 class >> priority [ 

	^ 4
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel4 >> createLabels [

	area descriptions add: ('+Vcc' -> (42@4)).
	area descriptions add: ('GND' -> (3@32)).
	
	1 to: 7 do: [ :i |
		area descriptions add: ((ports at: i) name -> (3@(4+((i-1)*4)))) ] .

	1 to: 7 do: [ :i |
		area descriptions add: ((ports at: i+7) name -> (42@(32-((i-1)*4)))) ].

	
]

{ #category : #initialization }
ChDGigatronLevel4 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAAOWNMQ7AIAwDv+S4FGUtEf//EkkGBjoyZjnJJ0sHgBZ4HIMETAhJqLhr+ndo7mbMxLd/h8tfj5ng/h3utfrd+t363dvu4AKGMbHuzwMAAA=='
]

{ #category : #initialization }
ChDGigatronLevel4 >> instructions [ 

	^ '74139.png'
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel4 >> portPoints [

	^ ((1 to: 7) collect: [ :i | 3@(4+((i-1)*4))]),
	((1 to: 7) collect: [ :i | 42@(32-((i-1)*4))])
]

{ #category : #'as yet unclassified' }
ChDGigatronLevel4 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: '/1G'
			sequence: '0007C00FFFE007FE00000007FE007FE007FE007FE007FE007FE007FE007FE007FE000000'.
		ChipDesignerClassicLevelPort 
			name: '1A'
			sequence: '00F801FFFFE007C00000000001FFFFE00001FFFFE00001FFFFE00001FFFFE00001FFFC00'.
		ChipDesignerClassicLevelPort 
			name: '1B'
			sequence: '00FFC00FFC00FFC0000000000000001FFFFFFFFFE0000000001FFFFFFFFFE00000000000'.	 

		ChipDesignerClassicLevelPort 
			name: '1Y0'
			sequence: '00FFFFF003FF003FF0000000000000000000000000000000000000000000000000000000'.
		ChipDesignerClassicLevelPort 
			name: '1Y1'
			sequence: '00FFC00FFFFF003FF0000000000000000000000000000000000000000000000000000000'.
		ChipDesignerClassicLevelPort 
			name: '1Y2'
			sequence: '00FFC00FFC0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 

		ChipDesignerClassicLevelPort 
			name: '1Y3'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: '1Y3'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: '2Y2'	
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFF'.	 

		ChipDesignerClassicLevelPort 
			name: '2Y1'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: '2Y0'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: '2B'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE0003FF'.							
		
		ChipDesignerClassicLevelPort 
			name: '2A'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFF801FFFFFF'.
		ChipDesignerClassicLevelPort 
			name: '/2G'
			expectedSequence: '00FFFFFFFFFFFFFFF0000007FFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFE007FFFFFC00'.	 

		}


]

{ #category : #'as yet unclassified' }
ChDGigatronLevel4 >> vccPoints [

	^ { 42@4 }
]
