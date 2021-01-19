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
		ChipDesignerClassicLevelPort 
			name: 'A'
			sequence: '0007C00FFFE007FE00001FFFFE00001FFFFE00001FFFFE00001FFFFE0000000000000000'.
		ChipDesignerClassicLevelPort 
			name: 'B'
			sequence: '00F801FFFFE007C000000000000003FFFFFFFFFC0000000003FFFFFFFFFC000000000000'.
		ChipDesignerClassicLevelPort 
			name: 'C'
			sequence: '00FFC00FFC00FFC0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 

		ChipDesignerClassicLevelPort 
			name: '/G2A'
			sequence: '00FFFFF003FF003FF0000000000000000000000000000000000000000000000000000000'.
		ChipDesignerClassicLevelPort 
			name: '/G2B'
			sequence: '00FFC00FFFFF003FF0000000000000000000000000000000000000000000000000000000'.
		ChipDesignerClassicLevelPort 
			name: 'G1'
			sequence: '00FFC00FFC0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 

		ChipDesignerClassicLevelPort 
			name: 'Y7'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: 'Y6'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: 'Y5'	
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFF'.	 

		ChipDesignerClassicLevelPort 
			name: 'Y4'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.							
		
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: '00FFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.
		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: '00FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'.	 

		}


]

{ #category : #'as yet unclassified' }
ChDGigatronLevel3 >> vccPoints [

	^ { 42@4 }
]