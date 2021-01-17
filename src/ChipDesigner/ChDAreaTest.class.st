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
	super setUp.

	area := ChDArea withDefaultExtent
]

{ #category : #tests }
ChDAreaTest >> testAddNewStandaloneRegion [
	| aCell |
	self assertEmpty: area regions.

	aCell := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	area updateCell: aCell mode: #metal.

	self assert: area regions size equals: 1.
	self assertCollection: area regions anyOne cells hasSameElements: {aCell}
]

{ #category : #tests }
ChDAreaTest >> testAddNewStandaloneSubstrateRegion [
	| aCell |
	self assertEmpty: area regions.

	aCell := area addNAt: 5 y: 5 addConnections: 2r0000.
	area updateCell: aCell mode: #n.

	self assert: area regions size equals: 1.
	self assertCollection: area regions anyOne cells hasSameElements: {aCell}
]

{ #category : #tests }
ChDAreaTest >> testMergeRegions [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addMetalAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assertEmpty: (area neighborMetalRegionsOf: cell1).
	self assertEmpty: (area neighborMetalRegionsOf: cell2).

	area metalLayer connectionsFor: cell1 add: 2r0001.
	area metalLayer connectionsFor: cell2 add: 2r0100.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: area regions size equals: 1
]

{ #category : #tests }
ChDAreaTest >> testMergeSubstrateRegions [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addNAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addNAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assertEmpty: (area neighborSubstrateRegionsOf: cell1).
	self assertEmpty: (area neighborSubstrateRegionsOf: cell2).

	area substrateLayer connectionsFor: cell1 add: 2r0001.
	area substrateLayer connectionsFor: cell2 add: 2r0100.

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: area regions size equals: 1
]

{ #category : #tests }
ChDAreaTest >> testNeighborMetalRegionsOf [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addMetalAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assertEmpty: (area neighborMetalRegionsOf: cell1).
	self assertEmpty: (area neighborMetalRegionsOf: cell2).

	area metalLayer connectionsFor: cell1 add: 2r0001.
	area metalLayer connectionsFor: cell2 add: 2r0100.

	self assertCollection: (area neighborMetalRegionsOf: cell1) hasSameElements: {cell2 metalRegion}.
	self assertCollection: (area neighborMetalRegionsOf: cell2) hasSameElements: {cell1 metalRegion}
]

{ #category : #tests }
ChDAreaTest >> testNeighbourSubstrateRegionsOf [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addNAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addNAt: 5 y: 4 addConnections: 2r0000.
	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assertEmpty: (area neighborSubstrateRegionsOf: cell1).
	self assertEmpty: (area neighborSubstrateRegionsOf: cell2).

	area substrateLayer connectionsFor: cell1 add: 2r0001.
	area substrateLayer connectionsFor: cell2 add: 2r0100.

	self assertCollection: (area neighborSubstrateRegionsOf: cell1) hasSameElements: {cell2 substrateRegion}.
	self assertCollection: (area neighborSubstrateRegionsOf: cell2) hasSameElements: {cell1 substrateRegion}
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteMiddleOneOfCross [
	| cell1 cell2 cell3 cell4 cell5 regionsArray |
	self assertEmpty: area regions.

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
	self assert: (regionsArray allSatisfy: [ :each | each cells size = 1 ])
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteMiddleOneOfCrossInSubstrate [
	| cell1 cell2 cell3 cell4 cell5 regionsArray |
	self assertEmpty: area regions.

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
	self assert: (regionsArray allSatisfy: [ :each | each cells size = 1 ])
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteMiddleOneOfThree [
	| cell1 cell2 cell3 regionsArray |
	self assertEmpty: area regions.

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
	self assert: regionsArray first cells anyOne ~~ regionsArray second cells anyOne
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteOneOfThree [
	| cell1 cell2 cell3 |
	self assertEmpty: area regions.

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
	self assert: area regions anyOne cells size equals: 2
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteOneOfTwo [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addMetalAt: 6 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 2.

	area metalLayer fullClear: cell2.

	self deny: cell2 hasMetal.
	area updateCell: cell2 mode: #metal.

	self assert: area regions size equals: 1
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteOneOfTwoInSubstrate [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addNAt: 5 y: 5 addConnections: 2r0010.
	cell2 := area addNAt: 6 y: 5 addConnections: 2r1000.

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: area regions size equals: 1.
	self assert: area regions anyOne cells size equals: 2.

	area substrateLayer fullClear: cell2.

	self deny: cell2 hasSubstrate.
	area updateCell: cell2 mode: #n.

	self assert: area regions size equals: 1
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteSecondOfFour [
	| cell1 cell2 cell3 cell4 regionsArray |
	self assertEmpty: area regions.

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

	self assert: cell1 metalRegion identicalTo: area regions anyOne.
	self assert: cell2 metalRegion identicalTo: area regions anyOne.
	self assert: cell3 metalRegion identicalTo: area regions anyOne.
	self assert: cell4 metalRegion identicalTo: area regions anyOne.

	area metalLayer fullClear: cell2.

	self deny: cell2 hasMetal.
	self assert: cell1 metalConnections equals: 2r0000.
	self assert: cell3 metalConnections equals: 2r0010.
	self assert: cell4 metalConnections equals: 2r1000.

	area updateCell: cell2 mode: #metal.

	regionsArray := area regions asArray.

	self assert: regionsArray size equals: 2
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteSecondOfFourInSubstrate [
	| cell1 cell2 cell3 cell4 regionsArray |
	self assertEmpty: area regions.

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

	self assert: cell1 substrateRegion identicalTo: area regions anyOne.
	self assert: cell2 substrateRegion identicalTo: area regions anyOne.
	self assert: cell3 substrateRegion identicalTo: area regions anyOne.
	self assert: cell4 substrateRegion identicalTo: area regions anyOne.

	area substrateLayer fullClear: cell2.

	self deny: cell2 hasSubstrate.
	self assert: cell1 substrateConnections equals: 2r0000.
	self assert: cell3 substrateConnections equals: 2r0010.
	self assert: cell4 substrateConnections equals: 2r1000.

	area updateCell: cell2 mode: #n.

	regionsArray := area regions asArray.

	self assert: regionsArray size equals: 2
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteSecondOfFourVertical [
	| cell1 cell2 cell3 cell4 regionsArray |
	self assertEmpty: area regions.

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

	self assert: regionsArray size equals: 2
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteStandalone [
	| aCell |
	self assertEmpty: area regions.

	aCell := area addMetalAt: 5 y: 5 addConnections: 2r0000.

	area updateCell: aCell mode: #metal.

	self assert: area regions size equals: 1.

	area metalLayer fullClear: aCell.

	self deny: aCell hasMetal.
	area updateCell: aCell mode: #metal.

	self assert: area regions size equals: 0
]

{ #category : #tests }
ChDAreaTest >> testTestDeleteStandaloneInSubstrate [
	| aCell |
	self assertEmpty: area regions.

	aCell := area addNAt: 5 y: 5 addConnections: 2r0000.

	area updateCell: aCell mode: #n.

	self assert: area regions size equals: 1.

	area substrateLayer fullClear: aCell.

	self deny: aCell hasMetal.
	area updateCell: aCell mode: #n.

	self assert: area regions size equals: 0
]

{ #category : #tests }
ChDAreaTest >> testTwoStandaloneRegions [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addMetalAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addMetalAt: 5 y: 4 addConnections: 2r0000.

	area updateCell: cell1 mode: #metal.
	area updateCell: cell2 mode: #metal.

	self assert: area regions size equals: 2
]

{ #category : #tests }
ChDAreaTest >> testTwoStandaloneRegionsInSubstrate [
	| cell1 cell2 |
	self assertEmpty: area regions.

	cell1 := area addNAt: 5 y: 5 addConnections: 2r0000.
	cell2 := area addNAt: 5 y: 4 addConnections: 2r0000.

	area updateCell: cell1 mode: #n.
	area updateCell: cell2 mode: #n.

	self assert: area regions size equals: 2
]
