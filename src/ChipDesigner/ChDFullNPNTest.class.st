Class {
	#name : #ChDFullNPNTest,
	#superclass : #TestCase,
	#instVars : [
		'area'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDFullNPNTest >> input1 [

	^ #(
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
	).
]

{ #category : #running }
ChDFullNPNTest >> input2 [

	^ #(
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
	).
]

{ #category : #running }
ChDFullNPNTest >> output [

	^ #(
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
 		0 0 0 0 0
 		0 0 0 0 0
		0 0 0 0 0
 		0 0 0 0 0
 		0 0 0 0 0
		0 0 0 0 0
 		0 0 0 0 0
 		0 0 0 0 0
		1 1 1 1 1
 		0 0 0 0 0
 		0 0 0 0 0
 		0 0 0 0 0
	).
]

{ #category : #running }
ChDFullNPNTest >> setUp [
	
	super setUp.
	
	area := ChDArea decodeFrom: 
		'000030000320041201416410920041621051500B200412014164103'.

	

]

{ #category : #tests }
ChDFullNPNTest >> testSequence [ 

	| i1 i2 o val oo |

	area simulation reset.

	i1 := (area atX: 1 y: 1) metalRegion.
	i2 := (area atX: 1 y: 2) metalRegion.
	o := (area atX: 1 y: 3) metalRegion.
	
	oo := OrderedCollection new.

	self output withIndexDo: [ :expected :time |
		area simulation stepWith: [ :aSimulation |
				val := (self input1 at: time) > 0.
				i1 hasVcc: val.
				
				val := (self input2 at: time) > 0.
				i2 hasVcc: val ].			
	
		self assert: (i1 currentState) equals: (self input1 at: time) > 0.
		self assert: (i2 currentState) equals: (self input2 at: time) > 0.
		self assert: (o currentState) equals: (expected > 0).
		
		oo add: o currentState.
		]. 

]
