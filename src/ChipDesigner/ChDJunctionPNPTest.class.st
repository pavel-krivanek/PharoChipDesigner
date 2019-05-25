Class {
	#name : #ChDJunctionPNPTest,
	#superclass : #TestCase,
	#instVars : [
		'area',
		'controller',
		'view'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDJunctionPNPTest >> setUp [
		
	area := ChDArea withDefaultExtent.
	controller := ChDAreaController new.
	controller area: area.
	view := ChDAreaViewMock new.
	controller view: view.
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 2@1.
	controller onMouseMoveAt: 2@2.
	controller onMouseMoveAt: 2@3.
	controller onMouseUpAt: 2@3.

]

{ #category : #running }
ChDJunctionPNPTest >> testCreateAndDeletePNP [
	
	| cell |
	
	controller insertNSubstrateMode.
	
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
	self assert: cell substrateType equals: #p.
	
	cell := area atX: 2 y: 3.	
	self assert: cell substrateConnections equals: 2r0000.
	self assert: cell substrateType equals: #p.

	cell := area atX: 1 y: 2.	
	self assert: cell substrateConnections equals: 2r0000.
	self assert: cell substrateType equals: #n.

	self assert: area regions size equals: 3.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]

{ #category : #running }
ChDJunctionPNPTest >> testCreatePNP [
	
	| event cell |
	
	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 1@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.
	
	cell := area atX: 2 y: 2.	
	self assert: cell hasJunction.
	self assert: cell junctionType equals: #pnp.
	self assert: cell junctionConnections equals: 2r1000.
	self deny: cell hasMetal.
	self assert: cell substrateRegion isJunction.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0001.

	cell := area atX: 1 y: 2.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r0010.
	
	self assert: area regions size equals: 4.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]

{ #category : #running }
ChDJunctionPNPTest >> testCreatePNPFromRight [
	
	| cell |
	
	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 3@2.
	controller onMouseMoveAt: 2@2.
	controller onMouseUpAt: 2@2.
	
	cell := area atX: 2 y: 2.	
	self assert: cell hasJunction.
	self assert: cell junctionType equals: #pnp.
	self assert: cell junctionConnections equals: 2r0010.
	self deny: cell hasMetal.
	self assert: cell substrateRegion isJunction.
	
	cell := area atX: 2 y: 1.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0100.

	cell := area atX: 2 y: 3.	
	self assert: cell substrateType equals: #p.
	self deny: cell hasJunction. 
	self deny: cell hasMetal. 
	self assert: cell substrateConnections equals: 2r0001.

	cell := area atX: 3 y: 2.	
	self assert: cell substrateType equals: #n.
	self deny: cell hasJunction. 
	self deny: cell hasMetal.
	self assert: cell substrateConnections equals: 2r1000.
	
	self assert: area regions size equals: 4.
	self assert: (area regions allSatisfy: [:each | each cells size = 1])

]
