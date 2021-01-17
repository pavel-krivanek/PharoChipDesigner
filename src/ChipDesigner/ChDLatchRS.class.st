Class {
	#name : #ChDLatchRS,
	#superclass : #TestCase,
	#instVars : [
		'area',
		'vcc',
		's',
		'r',
		'q'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDLatchRS >> setUp [ 

	super setUp.
	
	area := ChDArea decodeFrom: 		'0000700007200412014120141201412014120181000022004120141201816204920181200A1000022004120181640250B00B200A120061201810000264029000020A40B240B564091200A1620850A2150A81502017220B5220B5620312006120181640432014120121200A10000220041201612014120141201412012100002'.

	area simulation reset.
 
	vcc := (area atX: 1 y: 1) metalRegion.
	q := (area atX: 1 y: 7) metalRegion.

]

{ #category : #running }
ChDLatchRS >> step [ 

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true.
		
		(area atX: 1 y: 2) metalRegion hasVcc: s.
		(area atX: 1 y: 3) metalRegion hasVcc: r. ].	

]

{ #category : #tests }
ChDLatchRS >> testOscilations [

	r := false.
	s := false.
	
	self step.
	self assert: q hi . 
	self step.
	self assert: q low. 
	self step.
	self assert: q hi. 
	self step.
	self assert: q low. 
	self step.
	self assert: q hi. 
	self step.
	self assert: q low. 
	self step.
	self assert: q hi. 
	
]

{ #category : #tests }
ChDLatchRS >> testSet [

	r := true.
	s := false.
	
	self step. self assert: q low. 
	self step. self assert: q low. 

	r := false.

	self step. self assert: q low. 
	self step. self assert: q low. 

	s := true.	

	self step. self assert: q low. 
	self step. self assert: q hi. 
	self step. self assert: q hi. 
	
	s := false.	

	self step. self assert: q hi. 
	self step. self assert: q hi. 
	self step. self assert: q hi. 

	r := true.	

	self step. self assert: q low. 
	self step. self assert: q low. 
  	self step. self assert: q low. 

]
