Class {
	#name : #ChDTwoPNPCompactTest,
	#superclass : #TestCase,
	#instVars : [
		'area'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDTwoPNPCompactTest >> setUp [
	
	super setUp.
	
	area := ChDArea decodeFrom: 
		'0000200004200C162109240A50B00B240250B00B2004162103'.

	
]

{ #category : #tests }
ChDTwoPNPCompactTest >> test00 [

	| vcc via1 via2 output |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 4) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 3).
		
	self deny: via1 hasVia.
	self deny: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self assert: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self assert: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self assert: output currentState.


]

{ #category : #tests }
ChDTwoPNPCompactTest >> test01 [

	| vcc via1 via2 output |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 4) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 3).
	
	via2 via: true.
	
	self deny: via1 hasVia.
	self assert: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self deny: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.


]

{ #category : #tests }
ChDTwoPNPCompactTest >> test10 [

	| vcc via1 via2 output |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 4) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 3).
	
	via1 via: true.
	
	self assert: via1 hasVia.
	self deny: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self deny: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.


]

{ #category : #tests }
ChDTwoPNPCompactTest >> test11 [

	| vcc via1 via2 output |

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 4) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 3).
	
	via1 via: true.
	via2 via: true.
	
	self assert: via1 hasVia.
	self assert: via2 hasVia.
	
	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	
	self deny: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

	self deny: output currentState.


]
