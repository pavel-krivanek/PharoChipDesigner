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

{ #category : #tests }
ChDAreaControllerTest >> testAddSingleMetalCell [

	| cell |
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 0.
	
	self assert: view wasChanged.
	self deny: controller mouseDown.
	
	self assert: area regions size equals: 1.

]

{ #category : #tests }
ChDAreaControllerTest >> testAddSingleNCell [

	| cell |

	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateConnections equals: 0.
	
	self assert: view wasChanged.
	self deny: controller mouseDown.
	
	self assert: area regions size equals: 1.

]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoConnectedMetalCells [

	| cell |

	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	
	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoConnectedMetalCellsAndDeleteThemByMovement [

	| cell |
	
	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	controller deleteMetalMode.

	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	cell := area atX: 1 y: 1.
	self deny: cell hasMetal.
	cell := area atX: 2 y: 1.
	self deny: cell hasMetal.
	
	self assert: area regions size equals: 0.

	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoConnectedNCells [

	| cell |
	
	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell substrateConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	
	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoConnectedNCellsAndDeleteThemByMovement [

	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	controller deleteSubstrateMode.

	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.

	cell := area atX: 1 y: 1.
	self deny: cell hasSubstrate.
	cell := area atX: 2 y: 1.
	self deny: cell hasSubstrate.
	
	self assert: area regions size equals: 0.

	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoDifferentSubstrateCellsAndTryToMergeThemByMovement [

	| cell |
	
	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.

	controller insertPSubstrateMode.
	controller onMouseDownAt: 2@1.
	controller onMouseUpAt: 2@1.

	controller onMouseDownAt: 2@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateType equals: #n.
	self assert: cell substrateConnections equals: 2r0000.
	cell := area atX: 2 y: 1.
	self assert: cell substrateType equals: #p.
	self assert: cell substrateConnections equals: 2r0000.
	
	self assert: area regions size equals: 2.

	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoMetalCells [

	| cell |
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseDownAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 0.
	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 0.
	self assert: area regions size equals: 2.
	
	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoMetalCellsAndMergeThemByMovement [

	| cell |
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseDownAt: 2@1.
	controller onMouseUpAt: 2@1.

	controller onMouseMoveAt: 2@1.
	controller onMouseMoveAt: 1@1.

	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testAddTwoNCellsAndMergeThemByMovement [

	| cell |
	
	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseDownAt: 2@1.
	controller onMouseUpAt: 2@1.

	controller onMouseMoveAt: 2@1.
	controller onMouseMoveAt: 1@1.

	controller onMouseDownAt: 1@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateConnections equals: 2r0010.
	cell := area atX: 2 y: 1.
	self assert: cell substrateConnections equals: 2r1000.
	
	self assert: area regions size equals: 1.

	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testDeleteMetalTwoTimes [

	| cell |
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	controller deleteMetalMode.

	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.

	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	cell := area atX: 1 y: 1.
	self deny: cell hasMetal.
	self deny: cell hasSubstrate.
	self assert: area regions size equals: 0.
	
	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testDeleteSubstrateTwoTimes [

	| cell |
	
	controller insertPSubstrateMode.
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	controller deleteSubstrateMode.
	
	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.

	controller onMouseDownAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	cell := area atX: 1 y: 1.
	self deny: cell hasMetal.
	self deny: cell hasSubstrate.
	self assert: area regions size equals: 0.
	
	self assert: view wasChanged.
]

{ #category : #tests }
ChDAreaControllerTest >> testTryToExtendDifferentSubstrateTypeByMovement [

	| cell |
	
	controller insertNSubstrateMode.
	
	controller onMouseDownAt: 2@1.
	controller onMouseUpAt: 2@1.

	controller insertPSubstrateMode.

	controller onMouseDownAt: 2@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell substrateType equals: #p.
	self assert: cell substrateConnections equals: 2r0000.
	cell := area atX: 2 y: 1.
	self assert: cell substrateType equals: #n.
	self assert: cell substrateConnections equals: 2r0000.
	
	self assert: area regions size equals: 2.

	self assert: view wasChanged.
]
