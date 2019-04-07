Class {
	#name : #ChDAreaTest,
	#superclass : #TestCase,
	#instVars : [
		'area'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDAreaTest >> setUp [
	
	area := ChDArea withDefaultExtent.
]

{ #category : #running }
ChDAreaTest >> testAddNewStandaloneRegion [

	| aCell |
	
	self assert: area regions isEmpty. 
	
	aCell := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	area updateCell: aCell mode: #metal.

	self assert: area regions size equals: 1. 
	self assertCollection: area regions anyOne cells hasSameElements: { aCell }. 	
]

{ #category : #running }
ChDAreaTest >> testAddNewStandaloneSubstrateRegion [

	| aCell |
	
	self assert: area regions isEmpty. 
	
	aCell := area addNAt: 5 y: 5 addConnections: 2r0000.
	area updateCell: aCell mode: #n.

	self assert: area regions size equals: 1. 
	self assertCollection: area regions anyOne cells hasSameElements: { aCell }. 	
]

{ #category : #running }
ChDAreaTest >> testMergeRegions [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addMetalAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: (area neighborMetalRegionsOf: cell1) isEmpty.
	self assert: (area neighborMetalRegionsOf: cell2) isEmpty.

	area metalLayer connectionsFor: cell1 add: 2r0001.
	area metalLayer connectionsFor: cell2 add: 2r0100.	

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: area regions size equals: 1. 
]

{ #category : #running }
ChDAreaTest >> testMergeSubstrateRegions [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addNAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addNAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: (area neighborSubstrateRegionsOf: cell1) isEmpty.
	self assert: (area neighborSubstrateRegionsOf: cell2) isEmpty.

	area substrateLayer connectionsFor: cell1 add: 2r0001.
	area substrateLayer connectionsFor: cell2 add: 2r0100.	

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: area regions size equals: 1. 
]

{ #category : #running }
ChDAreaTest >> testNeighborMetalRegionsOf [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addMetalAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: (area neighborMetalRegionsOf: cell1) isEmpty.
	self assert: (area neighborMetalRegionsOf: cell2) isEmpty.

	area metalLayer connectionsFor: cell1 add: 2r0001.
	area metalLayer connectionsFor: cell2 add: 2r0100.	

	self assertCollection: (area neighborMetalRegionsOf: cell1) hasSameElements: { cell2 metalRegion }.
	self assertCollection: (area neighborMetalRegionsOf: cell2) hasSameElements: { cell1 metalRegion }.

]

{ #category : #running }
ChDAreaTest >> testNeighbourSubstrateRegionsOf [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addNAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addNAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: (area neighborSubstrateRegionsOf: cell1) isEmpty.
	self assert: (area neighborSubstrateRegionsOf: cell2) isEmpty.

	area substrateLayer connectionsFor: cell1 add: 2r0001.
	area substrateLayer connectionsFor: cell2 add: 2r0100.	

	self assertCollection: (area neighborSubstrateRegionsOf: cell1) hasSameElements: { cell2 substrateRegion }.
	self assertCollection: (area neighborSubstrateRegionsOf: cell2) hasSameElements: { cell1 substrateRegion }.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteMiddleOneOfCross [

	| cell1 cell2 cell3 cell4 cell5 regionsArray |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addMetalAt: 6 y: 5 addConnections: 2r1111.
	cell3 := area addMetalAt: 7 y: 5 addConnections: 2r1000.
	cell4 := area addMetalAt: 6 y: 4 addConnections: 2r0100.
	cell5 := area addMetalAt: 6 y: 6 addConnections: 2r0001.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.
	area updateCell: cell3 mode: #metal.
	area updateCell: cell4 mode: #metal.
	area updateCell: cell5 mode: #metal.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 5.
	
	area metalLayer fullClear: cell2.
	
	self deny: cell2 hasMetal. 
	area updateCell: cell2 mode: #metal.
	
	regionsArray := area regions asArray.
	
	self assert: regionsArray size equals: 4.
	self assert: (regionsArray allSatisfy: [:each | each cells size = 1]).
	
]

{ #category : #running }
ChDAreaTest >> testTestDeleteMiddleOneOfCrossInSubstrate [

	| cell1 cell2 cell3 cell4 cell5 regionsArray |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addNAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addNAt: 6 y: 5 addConnections: 2r1111.
	cell3 := area addNAt: 7 y: 5 addConnections: 2r1000.
	cell4 := area addNAt: 6 y: 4 addConnections: 2r0100.
	cell5 := area addNAt: 6 y: 6 addConnections: 2r0001.

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.
	area updateCell: cell3 mode: #n.
	area updateCell: cell4 mode: #n.
	area updateCell: cell5 mode: #n.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 5.
	
	area substrateLayer fullClear: cell2.
	
	self deny: cell2 hasSubstrate. 
	area updateCell: cell2 mode: #n.
	
	regionsArray := area regions asArray.
	
	self assert: regionsArray size equals: 4.
	self assert: (regionsArray allSatisfy: [:each | each cells size = 1]).
	
]

{ #category : #running }
ChDAreaTest >> testTestDeleteMiddleOneOfThree [

	| cell1 cell2 cell3 regionsArray |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addMetalAt: 6 y: 5 addConnections: 2r1010.
	cell3 := area addMetalAt: 7 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.
	area updateCell: cell3 mode: #metal.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 3.
	
	area metalLayer fullClear: cell2.
	
	self deny: cell2 hasMetal. 
	area updateCell: cell2 mode: #metal.
	
	regionsArray := area regions asArray.
	
	self assert: regionsArray size equals: 2.
	self assert: regionsArray first cells size equals: 1.
	self assert: regionsArray second cells size equals: 1.
	self assert: (regionsArray first cells anyOne ~~ regionsArray second cells anyOne)

]

{ #category : #running }
ChDAreaTest >> testTestDeleteOneOfThree [

	| cell1 cell2 cell3 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addMetalAt: 6 y: 5 addConnections: 2r1010.
	cell3 := area addMetalAt: 7 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.
	area updateCell: cell3 mode: #metal.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 3.
	
	area metalLayer fullClear: cell3.
	
	self deny: cell3 hasMetal. 
	area updateCell: cell3 mode: #metal.
	
	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 2.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteOneOfTwo [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addMetalAt: 6 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 2.
	
	area metalLayer fullClear: cell2.
	
	self deny: cell2 hasMetal. 
	area updateCell: cell2 mode: #metal.
	
	self assert: area regions size equals: 1.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteOneOfTwoInSubstrate [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addNAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addNAt: 6 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 2.
	
	area substrateLayer fullClear: cell2.
	
	self deny: cell2 hasSubstrate. 
	area updateCell: cell2 mode: #n.
	
	self assert: area regions size equals: 1.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteSecondOfFour [

	| cell1 cell2 cell3 cell4 regionsArray |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addMetalAt: 6 y: 5 addConnections: 2r1010.
	cell3 := area addMetalAt: 7 y: 5 addConnections: 2r1010.
	cell4 := area addMetalAt: 8 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.
	area updateCell: cell3 mode: #metal.
	area updateCell: cell4 mode: #metal.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 4.
	
	self assert: (cell1 metalRegion == area regions anyOne).
	self assert: (cell2 metalRegion == area regions anyOne).
	self assert: (cell3 metalRegion == area regions anyOne).
	self assert: (cell4 metalRegion == area regions anyOne).
	
	area metalLayer fullClear: cell2.
	
	self deny: cell2 hasMetal. 
	self assert: cell1 metalConnections equals: 2r0000.
	self assert: cell3 metalConnections equals: 2r0010.
	self assert: cell4 metalConnections equals: 2r1000.
	
	area updateCell: cell2 mode: #metal.
	
	regionsArray := area regions asArray.
	
	self assert: regionsArray size equals: 2.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteSecondOfFourInSubstrate [

	| cell1 cell2 cell3 cell4 regionsArray |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addNAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addNAt: 6 y: 5 addConnections: 2r1010.
	cell3 := area addNAt: 7 y: 5 addConnections: 2r1010.
	cell4 := area addNAt: 8 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.
	area updateCell: cell3 mode: #n.
	area updateCell: cell4 mode: #n.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 4.

	self assert: (cell1 substrateRegion == area regions anyOne).
	self assert: (cell2 substrateRegion == area regions anyOne).
	self assert: (cell3 substrateRegion == area regions anyOne).
	self assert: (cell4 substrateRegion == area regions anyOne).
	
	area substrateLayer fullClear: cell2.
	
	self deny: cell2 hasSubstrate. 
	self assert: cell1 substrateConnections equals: 2r0000.
	self assert: cell3 substrateConnections equals: 2r0010.
	self assert: cell4 substrateConnections equals: 2r1000.
	
	area updateCell: cell2 mode: #n.
	
	regionsArray := area regions asArray.
	
	self assert: regionsArray size equals: 2.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteSecondOfFourVertical [

	| cell1 cell2 cell3 cell4 regionsArray |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0100.
	cell2 := area addMetalAt: 5 y: 6 addConnections: 2r0101.
	cell3 := area addMetalAt: 5 y: 7 addConnections: 2r0101.
	cell4 := area addMetalAt: 5 y: 8 addConnections: 2r0001.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.
	area updateCell: cell3 mode: #metal.
	area updateCell: cell4 mode: #metal.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 4.
	
	area metalLayer fullClear: cell2.
	
	self deny: cell2 hasMetal. 
	self assert: cell1 metalConnections equals: 2r0000.
	self assert: cell3 metalConnections equals: 2r0100.
	self assert: cell4 metalConnections equals: 2r0001.

	area updateCell: cell2 mode: #metal.
	
	regionsArray := area regions asArray.
	
	self assert: regionsArray size equals: 2.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteStandalone [

	| aCell |
	
	self assert: area regions isEmpty. 
	
	aCell := area addMetalAt: 5 y: 5 addConnections: 2r0000.

	area updateCell: aCell mode: #metal.

	self assert: area regions size equals: 1.
	
	area metalLayer fullClear: aCell.
	
	self deny: aCell hasMetal. 
	area updateCell: aCell mode: #metal.
	
	self assert: area regions size equals: 0.

]

{ #category : #running }
ChDAreaTest >> testTestDeleteStandaloneInSubstrate [

	| aCell |
	
	self assert: area regions isEmpty. 
	
	aCell := area addNAt: 5 y: 5 addConnections: 2r0000.

	area updateCell: aCell mode: #n.

	self assert: area regions size equals: 1.
	
	area substrateLayer fullClear: aCell.
	
	self deny: aCell hasMetal. 
	area updateCell: aCell mode: #n.
	
	self assert: area regions size equals: 0.

]

{ #category : #running }
ChDAreaTest >> testTwoStandaloneRegions [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addMetalAt: 5 y: 4 addConnections: 2r0000.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: area regions size equals: 2. 
]

{ #category : #running }
ChDAreaTest >> testTwoStandaloneRegionsInSubstrate [

	| cell1 cell2 |
	
	self assert: area regions isEmpty. 
	
	cell1 := area addNAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addNAt: 5 y: 4 addConnections: 2r0000.

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: area regions size equals: 2. 
]
