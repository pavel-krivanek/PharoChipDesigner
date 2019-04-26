Class {
	#name : #ChipDesignerClassicLevel7,
	#superclass : #ChipDesignerClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChipDesignerClassicLevel7 class >> levelName [

	^ '7) KL2T1 - Dual Toggle Latch'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel7 >> instructions [ 

	^ 'classic07.png'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel7 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'T0'
			sequence: 56086793224325032158292242257491180798651090387357478951435572711106916940800.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Q0'
			expectedSequence: 1809251394333065553493295144183071933364084496555499427287387029111807409152.			

		ChipDesignerClassicLevelPort 
			name: 'T1'
			sequence: 57432931034020075956673030011133892710634697442982077865447739811833513717530624.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'Q1'
			expectedSequence: 1852671660951679345059503091828672469782946080473364738826495370471075711287296.	 
		}


]
