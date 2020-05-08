Class {
	#name : #ChDThreePNPCompactTest,
	#superclass : #TestCase,
	#instVars : [
		'area',
		'vcc',
		'output',
		'via1',
		'via2',
		'via3'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDThreePNPCompactTest >> expect: value [

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	
	self assert: output currentState equals: value


]

{ #category : #running }
ChDThreePNPCompactTest >> prepareSimulation [

	area simulation reset.

	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 5) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 3).
	via3 := (area atX: 1 y: 4).


	
]

{ #category : #running }
ChDThreePNPCompactTest >> setUp [
	
	super setUp.
	
	area := ChDArea decodeFrom: 
		'0000200005200C162109240A50B00B240A50B00B240250B00B2004162103'.
		


	
]

{ #category : #running }
ChDThreePNPCompactTest >> testValues [
	0 to: 2r111 do: [ :i | 
		self prepareSimulation.

		via1 via: (i bitAt: 1) > 0.
		via2 via: (i bitAt: 2) > 0.
		via3 via: (i bitAt: 3) > 0.
		self expect: i <= 0 ]
]
