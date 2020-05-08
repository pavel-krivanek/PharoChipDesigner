Class {
	#name : #ChDBasicGatesTest,
	#superclass : #TestCase,
	#instVars : [
		'area'
	],
	#category : #'ChipDesigner-Tests'
}

{ #category : #running }
ChDBasicGatesTest >> expect: anArray [

	area simulation reset.
	self assert: self output equals: anArray first > 0..

	anArray allButFirstDo: [ :each |
		area simulation step.
		self assert: self output equals: each > 0. ].
]

{ #category : #running }
ChDBasicGatesTest >> output [

	^ (area atX: 2 y: 3) metalRegion currentState.
]

{ #category : #tests }
ChDBasicGatesTest >> testNot00 [

	"Vcc: 0, base: 0"

	area := ChDArea decodeFrom: 
		'0000200003200C122109240250B00B0000262003'.
	area withTestingVCC.
	self expect: #(0 0 0 0 0)
]

{ #category : #tests }
ChDBasicGatesTest >> testNot01 [

	"Vcc: 0, base: 1"

	area := ChDArea decodeFrom: 
		'0000200003200C122109640250B00B0000262003'.
	area withTestingVCC.
	self expect: #(0 0 0 0 0)	

]

{ #category : #tests }
ChDBasicGatesTest >> testNot10 [

	"Vcc: 1, base: 0"

	area := ChDArea decodeFrom: 
		'0000200003200C162109240250B00B0000262003'.
	area withTestingVCC.
	self expect: #(0 1 1 1 1)
]

{ #category : #tests }
ChDBasicGatesTest >> testNot11 [

	"Vcc: 1, base: 1"

	area := ChDArea decodeFrom: 
		'0000200003200C162109640250B00B0000262003'.
	area withTestingVCC.
	self expect: #(0 0 0 0 0)
]
