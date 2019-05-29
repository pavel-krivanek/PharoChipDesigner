Class {
	#name : #ChDJunctionNPNTest,
	#superclass : #TestCase,
	#instVars : [
		'area',
		'controller',
		'view'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDJunctionNPNTest >> setUp [
		
	area := ChDArea withDefaultExtent.
	controller := ChDAreaController new.
	controller area: area.
	view := ChDAreaViewMock new.
	controller view: view.
	
	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 2@1.
	controller onMouseMoveAt: 2@2.
	controller onMouseMoveAt: 2@3.
	controller onMouseUpAt: 2@3.

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateAndDeleteNPN [
	
	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.
	
	controller deleteSubstrateMode.
	
	controller onMouseDownAt: 2@2.
	controller onMouseUpAt: 2@2.

	cell := area atX: 2 y: 2.	
	self deny: cell hasJunction.
	self deny: cell hasMetal.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateConnections equals: 2r0000.
	self assert: cell substrateType equals: #n.
	
	cell := area atX: 2 y: 3.	
	self assert: cell substrateConnections equals: 2r0000.
	self assert: cell substrateType equals: #n.

	cell := area atX: 1 y: 2.	
	self assert: cell substrateConnections equals: 2r0000.
	self assert: cell substrateType equals: #p.

	self assert: area regions size equals: 3.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateNPN [
	
	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.
	
	cell := area atX: 2 y: 2.	
	self assert: cell hasJunction.
	self assert: cell junctionType equals: #npn.
	self assert: cell junctionConnections equals: 2r1000.
	self deny: cell hasMetal.
	self assert: cell substrateRegion isJunction.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0001.

	cell := area atX: 1 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0010.
	
	self assert: area regions size equals: 4.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateNPNAndDeleteSubstrateConnection [
	
	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	controller deleteSubstrateMode.
	controller onMouseDownAt: 2@3.
	controller onMouseUpAt: 2@3.

	cell := area atX: 2 y: 2.	
	self deny: cell hasJunction.
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0001.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self deny: cell hasSubstrate.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 

	cell := area atX: 1 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0000.
	
	self assert: area regions size equals: 2.

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateNPNAndTryIncompatibleOtherSide [
	
	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 3@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	
	cell := area atX: 2 y: 2.	
	self assert: cell hasJunction.
	self assert: cell junctionType equals: #npn.
	self assert: cell junctionConnections equals: 2r1000.
	self deny: cell hasMetal.
	self assert: cell substrateRegion isJunction.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0001.

	cell := area atX: 1 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0010.

	cell := area atX: 3 y: 2.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0000.
	
	self assert: area regions size equals: 5.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateNPNDoubleSided [
	
	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	controller onMouseDownAt: 3@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.
	
	cell := area atX: 2 y: 2.	
	self assert: cell hasJunction.
	self assert: cell junctionType equals: #npn.
	self assert: cell junctionConnections equals: 2r1010.
	self assert: cell substrateConnections equals: 2r0101.
	self deny: cell hasMetal.
	self assert: cell substrateRegion isJunction.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0001.

	cell := area atX: 1 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0010.

	cell := area atX: 3 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r1000.
	
	self assert: area regions size equals: 5.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateNPNDoubleSidedAndDeleteOneSide [
	
	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	controller onMouseDownAt: 3@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	controller deleteSubstrateMode.
	controller onMouseDownAt: 3@2.
	controller onMouseUpAt: 3@2.

	cell := area atX: 2 y: 2.	
	self assert: cell hasJunction.
	self assert: cell junctionType equals: #npn.
	self assert: cell junctionConnections equals: 2r1000.
	self deny: cell hasMetal.
	self assert: cell substrateRegion isJunction.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0001.

	cell := area atX: 1 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0010.

	cell := area atX: 3 y: 2.	
	self deny: cell hasSubstrate.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	
	self assert: area regions size equals: 4.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateNPNDoubleSidedAndDeleteSubstrateConnection [
	
	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	controller onMouseDownAt: 3@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.

	controller deleteSubstrateMode.
	controller onMouseDownAt: 2@3.
	controller onMouseUpAt: 2@3.

	cell := area atX: 2 y: 2.	
	self deny: cell hasJunction.
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0001.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self deny: cell hasSubstrate.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 

	cell := area atX: 1 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0000.
	
	cell := area atX: 3 y: 2.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0000.

	self assert: area regions size equals: 3.

]
