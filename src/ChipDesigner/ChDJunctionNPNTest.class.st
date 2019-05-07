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
	
	| event |
	
	area := ChDArea withDefaultExtent.
	controller := ChDAreaController new.
	controller area: area.
	view := ChDAreaViewMock new.
	controller view: view.
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 2@1 event: event.
	controller onMouseMoveAt: 2@2 event: event.
	controller onMouseMoveAt: 2@3 event: event.
	controller onMouseUpAt: 2@3 event: event.

]

{ #category : #running }
ChDJunctionNPNTest >> testCreateAndDeleteNPN [
	
	| event cell |
	
	event := ChDMouseEventMock new.
	event red.
	event shift.
	
	controller onMouseDownAt: 1@2 event: event.
	controller onMouseMoveAt: 2@2 event: event.
	controller onMouseUpAt: 2@2 event: event.
	
	controller inputMode: ChDDeleteMode new.
	
	controller onMouseDownAt: 2@2 event: event.
	controller onMouseUpAt: 2@2 event: event.

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
	
	| event cell |
	
	event := ChDMouseEventMock new.
	event red.
	event shift.
	
	controller onMouseDownAt: 1@2 event: event.
	controller onMouseMoveAt: 2@2 event: event.
	controller onMouseUpAt: 2@2 event: event.
	
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
