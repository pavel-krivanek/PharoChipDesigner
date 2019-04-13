Class {
	#name : #ChDTwoNPN,
	#superclass : #TestCase,
	#instVars : [
		'area',
		'vcc',
		'output',
		'via1',
		'via2',
		'control'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDTwoNPN >> setUp [ 

	super setUp.
	
	area := ChDArea decodeFrom: 
		'0000200005200C164109220A51500B200A10400B220251500B2004164103'.

	area simulation reset.
 
	vcc := (area atX: 1 y: 1) metalRegion.
	output := (area atX: 1 y: 5) metalRegion.
	via1 := (area atX: 1 y: 2).
	via2 := (area atX: 1 y: 4).
	control := (area atX: 2 y: 3) substrateRegion.

]

{ #category : #running }
ChDTwoNPN >> step [ 

	area simulation stepWith: [ :aSimulation |
		vcc hasVcc: true ].	

]

{ #category : #running }
ChDTwoNPN >> test00 [
		
	self deny: via1 hasVia.
	self deny: via2 hasVia.
	
	self step. 
	
	self deny: output currentState.
	self deny: control currentState.

	self step.

	self deny: output currentState.
	self deny: control currentState.

	self step.

	self deny: output currentState.
	self deny: control currentState.


]

{ #category : #running }
ChDTwoNPN >> test01 [
		
	via1 via: true.
		
	self step. 
	
	self deny: output currentState.
	self assert: control currentState.

	self step.

	self deny: output currentState.
	self assert: control currentState.

	self step.

	self deny: output currentState.
	self assert: control currentState.


]

{ #category : #running }
ChDTwoNPN >> test10 [
		
	via2 via: true.
		
	self step. 
	
	self deny: output currentState.
	self deny: control currentState.

	self step.

	self deny: output currentState.
	self deny: control currentState.

	self step.

	self deny: output currentState.
	self deny: control currentState.


]

{ #category : #running }
ChDTwoNPN >> test11 [
		
	via1 via: true.
	via2 via: true.
		
	self step. 
	
	self deny: output currentState.
	self assert: control currentState.

	self step.

	self assert: output currentState.
	self assert: control currentState.

	self step.

	self assert: output currentState.
	self assert: control currentState.


]

{ #category : #running }
ChDTwoNPN >> test11to01 [
		
	via1 via: true.
	via2 via: true.
		
	self step. 
	self step.
	self step.

	via1 via: false.
	
	self step.
	self halt.
	self step.

	self deny: output currentState.
	self deny: control currentState.


]

{ #category : #running }
ChDTwoNPN >> test11to10 [
		
	via1 via: true.
	via2 via: true.
		
	self step. 
	self step.
	self step.

	via2 via: false.

	self step.

	self deny: output currentState.
	self assert: control currentState.


]
