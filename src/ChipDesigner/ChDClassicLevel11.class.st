Class {
	#name : #ChDClassicLevel11,
	#superclass : #ChDClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDClassicLevel11 class >> levelName [

	^ '11) KC82F - Divide-By-Four Counter'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel11 >> instructions [ 

	^ 'classic11.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel11 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'IN'
			sequence: 56086793276610989282252936320970419174688769182438057460158017385379639884800.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OUT'
			expectedSequence: 1684995059758870729637914538306208266147618922229761704690370739200.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		}


]
