Class {
	#name : #ChDCPlayground44x23,
	#superclass : #ChDClassicLevel1,
	#category : #'ChipDesigner-Levels'
}

{ #category : #'as yet unclassified' }
ChDCPlayground44x23 class >> designName [

	 ^ 'Playground 44x23 (classic)'
]

{ #category : #'as yet unclassified' }
ChDCPlayground44x23 class >> isRoot [ 

	^ true
]

{ #category : #'as yet unclassified' }
ChDCPlayground44x23 class >> priority [ 

	^ 300
]

{ #category : #'as yet unclassified' }
ChDCPlayground44x23 >> instructions [ 

	^ 'intro.png'
]

{ #category : #'as yet unclassified' }
ChDCPlayground44x23 >> portsDefinition [

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
		}


]
