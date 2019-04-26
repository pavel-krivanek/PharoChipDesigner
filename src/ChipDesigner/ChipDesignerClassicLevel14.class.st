Class {
	#name : #ChipDesignerClassicLevel14,
	#superclass : #ChipDesignerClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChipDesignerClassicLevel14 class >> levelName [

	^ '14) KC84S - 4-Bit Shift Register (S-To-P)'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel14 >> instructions [ 

	^ 'classic14.png'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel14 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'D'
			sequence: 1897135780814517965989769024907779061262005173512476213894914957360328163061661696.
		ChipDesignerClassicLevelPort 
			name: 'CLK'
			sequence: 53540820094935750674654182917108369026011332277623774736368303420211200.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort 
			name: 'Q0'
			expectedSequence: 1723753235535501353076102931851965864238067187862727306041017943195648.	 
		ChipDesignerClassicLevelPort 
			name: 'Q1'
			expectedSequence: 1942668892225727347166226371322165829079401991243322708223594189150347229189323620352.	 
		ChipDesignerClassicLevelPort 
			name: 'Q2'
			expectedSequence: 1723751590030944031872983778762287410943001417736275696245935177728000.	 
		ChipDesignerClassicLevelPort 
			name: 'Q3'
			expectedSequence: 1942668892225727345484520713739893253995594845183086780738412771485559968814333952000.	 
		}


]
