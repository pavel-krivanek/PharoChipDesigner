Class {
	#name : #ChipDesignerClassicLevel1,
	#superclass : #Object,
	#instVars : [
		'area',
		'a0',
		'a1',
		'a2',
		'a3',
		'y0',
		'y1',
		'y2',
		'y3'
	],
	#category : #ChipDesigner
}

{ #category : #'instance creation' }
ChipDesignerClassicLevel1 class >> on: area [

	^ self basicNew
		area: area;
		initialize
]

{ #category : #accessing }
ChipDesignerClassicLevel1 >> area [
	^ area
]

{ #category : #accessing }
ChipDesignerClassicLevel1 >> area: anObject [
	area := anObject
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel1 >> createLabels [

	area descriptions add: ('+Vcc' -> (3@4)).
	area descriptions add: ('A0' -> (3@8)).
	area descriptions add: ('A1' -> (3@12)).
	area descriptions add: ('A2' -> (3@16)).
	area descriptions add: ('A3' -> (3@20)).
	area descriptions add: ('+Vcc' -> (3@24)).

	area descriptions add: ('+Vcc' -> (42@4)).
	area descriptions add: ('Y0' -> (42@8)).
	area descriptions add: ('Y1' -> (42@12)).
	area descriptions add: ('Y2' -> (42@16)).
	area descriptions add: ('Y3' -> (42@20)).
	area descriptions add: ('+Vcc' -> (42@24)).
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel1 >> initialize [ 

	super initialize.
	
	self initializeArea.
	self initializeSimulation.
	
	self createLabels.
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel1 >> initializeArea [

	area decodeFrom: '0002C0001B000B2200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A10000420061201612012100048200612016120121000B2'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel1 >> initializeSimulation [

	a0 := ChDSequenceMorph input name: 'A0'.
	a0 decodedFrom: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.
	a0 region: (area atX: 3 y: 8) metalRegion.

	a1 := ChDSequenceMorph input name: 'A1'.
	a1 decodedFrom: 1807484548951638332871050064150417808546271801152871425639336334841190810623.
	a1 region: (area atX: 3 y: 12) metalRegion.

	a2 := ChDSequenceMorph input name: 'A2'.
	a2 decodedFrom: 1807484547269931066782991785428060059785466597904927945672633562124766938111.
	a2 region: (area atX: 3 y: 16) metalRegion.

	a3 := ChDSequenceMorph input name: 'A3'.
	a3 decodedFrom: 1940773605501608130481128960268819258320919206081157432763152912845935414990475363327.
	a3 region: (area atX: 3 y: 20) metalRegion.

	y0 := ChDSequenceMorph output name: 'Y0'.
	y0 region: (area atX: 42 y: 8) metalRegion.

	y1 := ChDSequenceMorph output name: 'Y1'.
	y1 region: (area atX: 42 y: 12) metalRegion.

	y2  := ChDSequenceMorph output name: 'Y2'.
	y2 region: (area atX: 42 y: 16) metalRegion.

	y3 := ChDSequenceMorph output name: 'Y3'.
	y3 region: (area atX: 42 y: 20) metalRegion.

	area simulation stepBlock: [ :aSimulation |
		
	(y0 region = (area atX: 42 y: 8) metalRegion)
		ifFalse: [ y0 region: (area atX: 42 y: 8) metalRegion ].
		
	(y1 region = (area atX: 42 y: 8) metalRegion)
		ifFalse: [ y1 region: (area atX: 42 y: 12) metalRegion ].
		
	(y2 region = (area atX: 42 y: 8) metalRegion)
		ifFalse: [ y2 region: (area atX: 42 y: 16) metalRegion ].
		
	(y3 region = (area atX: 42 y: 8) metalRegion)
		ifFalse: [ y3 region: (area atX: 42 y: 20) metalRegion ].
		
		(area atX: 3 y: 3) metalRegion hasVcc: true.
		(area atX: 3 y: 24) metalRegion hasVcc: true.
		(area atX: 42 y: 3) metalRegion hasVcc: true.
		(area atX: 42 y: 24) metalRegion hasVcc: true.
		
		(area atX: 3 y: 8) metalRegion hasVcc: (a0 sequence at: aSimulation time+1).
		(area atX: 3 y: 12) metalRegion hasVcc: (a1  sequence at: aSimulation time+1).
		(area atX: 3 y: 16) metalRegion hasVcc: (a2 sequence at: aSimulation time+1).
		(area atX: 3 y: 20) metalRegion hasVcc: (a3 sequence at: aSimulation time+1).
	]
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel1 >> scopes [ 

	^ { a0. a1. a2. a3. y0. y1. y2. y3 }
]
