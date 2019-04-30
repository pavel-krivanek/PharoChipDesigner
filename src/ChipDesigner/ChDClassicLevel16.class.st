Class {
	#name : #ChDClassicLevel16,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel16 class >> levelName [

	^ '[16] KA181 - 2-Bit Logical Function Unit'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel16 >> instructions [ 

	^ 'classic16.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel16 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: 1942667039552302997613570663619836412813718874707073699872800135595835906349648051200.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: 1940771756443149429643573186589657853235214586984575545837366479000378231163453440000.
		ChipDesignerClassicLevelPort 
			name: 'B0'
			sequence: 1940771754637430004003477704113051444939972022052437810828791748961446688380131737600.
		ChipDesignerClassicLevelPort 
			name: 'B1'
			sequence: 1942668892223962223856329027051255318606143656670856054182946572107358390934568960000.

		ChipDesignerClassicLevelPort 
			name: 'F0'
			sequence: 1942668892225729070917816402266197700600253263666157078910776018675071125147042709504.	
		ChipDesignerClassicLevelPort 
			name: 'F1'
			sequence: 1942668892225729070919461906823518906642405445255564613087866063756512244682614374400.	 
		ChipDesignerClassicLevelPort 
			name: 'C0'
			expectedSequence: 1852673426073305892847003177383161949680769834051557827535540961809942659989504.	 
		ChipDesignerClassicLevelPort 
			name: 'C1'
			expectedSequence: 1897135782579641275888720233859556829518411454997379024229502985325307938107031552.	 
		}


]
