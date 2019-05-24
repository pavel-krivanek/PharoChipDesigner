Class {
	#name : #ChDAreaControllerTest,
	#superclass : #TestCase,
	#instVars : [
		'area',
		'controller',
		'view'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDAreaControllerTest >> setUp [
	
	area := ChDArea withDefaultExtent.
	controller := ChDAreaController new.
	controller area: area.
	view := ChDAreaViewMock new.
	controller view: view.
]

{ #category : #running }
ChDAreaControllerTest >> testAddSingleMetalCell [

	| cell event |
	
	event := ChDMouseEventMock new.
	event red.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 0.
	
	self assert: view wasChanged.
	self deny: controller mouseDown.
	
	self assert: area regions size equals: 1.

]

{ #category : #running }
ChDAreaControllerTest >> testAddSingleNCell [

	| cell event |
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 1@1 event: event..
	controller onMouseUpAt: 1@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateConnections equals: 0.
	
	self assert: view wasChanged.
	self deny: controller mouseDown.
	
	self assert: area regions size equals: 1.

]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoConnectedMetalCells [

	| cell event |
	
	event := ChDMouseEventMock new.
	event red.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	
	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoConnectedMetalCellsAndDeleteThemByMovement [

	| cell event |
	
	event := ChDMouseEventMock new.
	event red.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.
	
	controller deleteMetalMode.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.

	
	cell := area atX: 1 y: 1.
	self deny: cell hasMetal.
	cell := area atX: 2 y: 1.
	self deny: cell hasMetal.
	
	self assert: area regions size equals: 0.

	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoConnectedNCells [

	| cell event |
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell substrateConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	
	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoConnectedNCellsAndDeleteThemByMovement [

	| cell event |
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.
	
	controller deleteMetalMode.
	event shift.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.

	cell := area atX: 1 y: 1.
	self deny: cell hasSubstrate.
	cell := area atX: 2 y: 1.
	self deny: cell hasSubstrate.
	
	self assert: area regions size equals: 0.

	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoDifferentSubstrateCellsAndTryToMergeThemByMovement [

	| cell event |
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.

	event shift.
	controller onMouseDownAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.

	controller onMouseDownAt: 2@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateType equals: #n.
	self assert: cell substrateConnections equals: 2r0000.
	cell := area atX: 2 y: 1.
	self assert: cell substrateType equals: #p.
	self assert: cell substrateConnections equals: 2r0000.
	
	self assert: area regions size equals: 2.

	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoMetalCells [

	| cell event |
	
	event := ChDMouseEventMock new.
	event red.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseDownAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 0.
	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 0.
	self assert: area regions size equals: 2.
	
	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoMetalCellsAndMergeThemByMovement [

	| cell event |
	
	event := ChDMouseEventMock new.
	event red.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseDownAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.

	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testAddTwoNCellsAndMergeThemByMovement [

	| cell event |
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseDownAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.

	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell substrateConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testDeleteMetalTwoTimes [

	| cell event |
	
	event := ChDMouseEventMock new.
	event red.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	
	controller deleteMetalMode.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	
	cell := area atX: 1 y: 1.
	self deny: cell hasMetal.
	self deny: cell hasSubstrate.
	self assert: area regions size equals: 0.
	
	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testDeleteSubstrateTwoTimes [

	| cell event |
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	
	controller deleteMetalMode.
	event := ChDMouseEventMock new.
	event red.
	event shift.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.

	controller onMouseDownAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	
	cell := area atX: 1 y: 1.
	self deny: cell hasMetal.
	self deny: cell hasSubstrate.
	self assert: area regions size equals: 0.
	
	self assert: view wasChanged.
]

{ #category : #running }
ChDAreaControllerTest >> testTryToExtendDifferentSubstrateTypeByMovement [

	| cell event |
	
	event := ChDMouseEventMock new.
	event yellow.
	
	controller onMouseDownAt: 2@1 event: event.
	controller onMouseUpAt: 2@1 event: event.

	event shift.

	controller onMouseDownAt: 2@1 event: event.
	controller onMouseMoveAt: 2@1 event: event.
	controller onMouseMoveAt: 1@1 event: event.
	controller onMouseUpAt: 1@1 event: event.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateType equals: #p.
	self assert: cell substrateConnections equals: 2r0000.
	cell := area atX: 2 y: 1.
	self assert: cell substrateType equals: #n.
	self assert: cell substrateConnections equals: 2r0000.
	
	self assert: area regions size equals: 2.

	self assert: view wasChanged.
]
