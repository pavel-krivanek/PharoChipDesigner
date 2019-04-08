Class {
	#name : #ChDFullPNPTest,
	#superclass : #TestCase,
	#instVars : [
		'area'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDFullPNPTest >> input1 [

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
ChDFullPNPTest >> input2 [

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
ChDFullPNPTest >> output [

	^ #(
		1 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		0 1 1 1 1
		0 0 0 0 0
		0 0 0 0 0
		1 0 0 0 0
		0 0 0 0 0
		0 0 0 0 0
		1 1 1 1 1
 		0 0 0 0 0
 		0 0 0 0 0
		1 1 1 1 1
 		0 0 0 0 0
 		0 0 0 0 0
		0 1 1 1 1
 		0 0 0 0 0
 		0 0 0 0 0
		1 0 0 0 0
 		0 0 0 0 0
 		0 0 0 0 0
 		0 0 0 0 0
	).
]

{ #category : #running }
ChDFullPNPTest >> setUp [
	
	super setUp.
	
	area := ChDArea decodeFrom: 
		'000030000320041201416210920041641050B00B200412014162103'.

	

]

{ #category : #running }
ChDFullPNPTest >> testSequence [ 

	| i1 i2 o val |

	area simulation reset.

	i1 := (area atX: 1 y: 1) metalRegion.
	i2 := (area atX: 1 y: 2) metalRegion.
	o := (area atX: 1 y: 3) metalRegion.

	self output withIndexDo: [ :expected :time |
	
		area simulation stepWith: [ :aSimulation |
				val := (self input1 at: time) > 0.
				i1 hasVcc: val.
				
				val := (self input2 at: time) > 0.
				i2 hasVcc: val. 
		"time = 21 ifTrue: [ self halt. ]."

				].			
	
		self assert: (i1 currentState) equals: (self input1 at: time) > 0.
		self assert: (i2 currentState) equals: (self input2 at: time) > 0.
		self assert: (o currentState) equals: (expected > 0).
		].
]
