Class {
	#name : #ChDTwoPNPTest,
	#superclass : #TestCase,
	#instVars : [
		'area'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDTwoPNPTest >> setUp [
	
	super setUp.
	
	area := ChDArea decodeFrom: 
		'0000200006200C162109240A50B00B200A162083200A162029240250B00B2004162103'.

	
]

{ #category : #running }
ChDTwoPNPTest >> test00 [

	| vcc via1 via2 output connection |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 6) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 5).
	connection := (area atX: 2 y: 3) metalRegion.
	
	self deny: via1 hasVia.
	self deny: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self deny: output currentState.
	self assert: connection currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self assert: output currentState.
	self assert: connection currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self assert: output currentState.
	self assert: connection currentState.


]

{ #category : #running }
ChDTwoPNPTest >> test01 [

	| vcc via1 via2 output connection |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 6) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 5).
	connection := (area atX: 2 y: 3) metalRegion.
	
	via2 via: true.
	
	self deny: via1 hasVia.
	self assert: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self deny: output currentState.
	self assert: connection currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.
	self assert: connection currentState.


]

{ #category : #running }
ChDTwoPNPTest >> test10 [

	| vcc via1 via2 output connection |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 6) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 5).
	connection := (area atX: 2 y: 3) metalRegion.
	
	via1 via: true.
	
	self assert: via1 hasVia.
	self deny: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self deny: output currentState.
	self deny: connection currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.
	self deny: connection currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.
	self deny: connection currentState.


]

{ #category : #running }
ChDTwoPNPTest >> test11 [

	| vcc via1 via2 output connection |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 6) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 5).
	connection := (area atX: 2 y: 3) metalRegion.
	
	via1 via: true.
	via2 via: true.
	
	self assert: via1 hasVia.
	self assert: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self deny: output currentState.
	self deny: connection currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.
	self deny: connection currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.
	self deny: connection currentState.


]
