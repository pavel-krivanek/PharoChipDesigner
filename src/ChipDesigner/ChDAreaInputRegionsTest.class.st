Class {
	#name : #ChDAreaInputRegionsTest,
	#superclass : #TestCase,
	#instVars : [
		'area',
		'controller',
		'view'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDAreaInputRegionsTest >> setUp [
	super setUp.

	area := ChDArea withDefaultExtent.
	controller := ChDAreaController new.
	controller area: area.
	view := ChDAreaViewMock new.
	controller view: view.

	area addInputAt: 1 @ 1
]

{ #category : #tests }
ChDAreaInputRegionsTest >> testConnectedCell [

	| cell |
		
	controller onMouseDownAt: 2@1.
	controller onMouseUpAt: 2@1.

	controller onMouseDownAt: 2@1.
	controller onMouseMoveAt: 2@1.
	controller onMouseMoveAt: 1@1.
	controller onMouseUpAt: 1@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 2r0010.
	self assert: cell metalRegion isSpecial.
	self assert: cell metalRegion cells size equals: 1.

	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 2r1000.
	self deny: cell metalRegion isSpecial.
	self assert: cell metalRegion cells size equals: 1.

	self assert: area regions size equals: 2.
]

{ #category : #tests }
ChDAreaInputRegionsTest >> testConnectedCellFromInput [
	| cell |
	controller onMouseDownAt: 2 @ 1.
	controller onMouseUpAt: 2 @ 1.

	controller onMouseDownAt: 1 @ 1.
	controller onMouseMoveAt: 1 @ 1.
	controller onMouseMoveAt: 2 @ 1.
	controller onMouseUpAt: 2 @ 1.

	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 2r0010.
	self assert: cell metalRegion isSpecial.
	self assert: cell metalRegion cells size equals: 1.

	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 2r1000.
	self deny: cell metalRegion isSpecial.
	self assert: cell metalRegion cells size equals: 1.

	self assert: area regions size equals: 2
]

{ #category : #tests }
ChDAreaInputRegionsTest >> testNotConnectedCell [

	| cell |
	
	controller onMouseDownAt: 2@1.
	controller onMouseUpAt: 2@1.
	
	cell := area atX: 1 y: 1.
	self assert: cell metalConnections equals: 0.

	cell := area atX: 2 y: 1.
	self assert: cell metalConnections equals: 0.

	self assert: area regions size equals: 2.
]
