Class {
	#name : #ChDSequence,
	#superclass : #Model,
	#instVars : [
		'sequenceArray',
		'signalLength',
		'region',
		'readOnly',
		'name',
		'currentTime',
		'type',
		'expectedSequenceArray',
		'position'
	],
	#category : #ChipDesigner
}

{ #category : #running }
ChDSequence class >> input [ 

	^ self new type: #input.
]

{ #category : #running }
ChDSequence class >> output [ 

	^ self new type: #output.
]

{ #category : #accessing }
ChDSequence >> currentTime [
	^ currentTime
]

{ #category : #accessing }
ChDSequence >> currentTime: anObject [
	currentTime := anObject
]

{ #category : #initialization }
ChDSequence >> decodedFrom: anInteger [

	sequenceArray := ((1 to: sequenceArray size) collect: [ :bitIndex | (anInteger bitAt: bitIndex) = 1 ]).

]

{ #category : #initialization }
ChDSequence >> encoded [
	
	| exponent |
	exponent := 0.
	^ self sequenceArray inject: 0 into: [ :num :each | 
		exponent := exponent + 1.
		num + (each ifTrue: [ 2 raisedTo: exponent-1 ] ifFalse: [ 0 ] ) ].
	
]

{ #category : #initialization }
ChDSequence >> expectedDecodedFrom: anInteger [

	expectedSequenceArray := ((1 to: sequenceArray size) collect: [ :bitIndex | (anInteger bitAt: bitIndex) = 1 ]).

]

{ #category : #initialization }
ChDSequence >> expectedSequenceArray [

	^ expectedSequenceArray
]

{ #category : #accessing }
ChDSequence >> forMetalAt: aPosition in: anArea [

	position := aPosition.
	self region: (anArea atX: aPosition x y: aPosition y) metalRegion

]

{ #category : #accessing }
ChDSequence >> forSubstrateAt: aPosition in: anArea [

	position := aPosition.
	self region: (anArea atX: aPosition x y: aPosition y) substrate

]

{ #category : #initialization }
ChDSequence >> initialize [

	super initialize.
	
	signalLength := 5.
	sequenceArray := (1 to: 56 * signalLength) collect: [ :each | false. ].
	expectedSequenceArray := nil.
	
	currentTime := nil.
	
	type := #output. 
	readOnly := true.

]

{ #category : #initialization }
ChDSequence >> length [

	^ sequenceArray size
]

{ #category : #initialization }
ChDSequence >> name [ 

	^ name
]

{ #category : #initialization }
ChDSequence >> name: aString [

	name := aString.
]

{ #category : #accessing }
ChDSequence >> position [
	^ position
]

{ #category : #accessing }
ChDSequence >> position: anObject [
	
	position := anObject.

]

{ #category : #accessing }
ChDSequence >> readOnly [
	^ readOnly
]

{ #category : #accessing }
ChDSequence >> readOnly: anObject [
	readOnly := anObject
]

{ #category : #accessing }
ChDSequence >> region [
	^ region
]

{ #category : #accessing }
ChDSequence >> region: aRegion [
	
	region ifNotNil: [ region area simulation announcer unsubscribe: self ].

	region := aRegion.
	
	region area simulation announcer when: ChDSimulationStepAnnouncement do: [ :announcement |
		currentTime := announcement time. 
		(currentTime > 0 and: [self storesOutput]) ifTrue: [ 
			sequenceArray at: currentTime put: region hasVcc ].
		self valueChanged ].
]

{ #category : #initialization }
ChDSequence >> resetRegion [

	| aCell newRegion |
	
	aCell := region area atX: position x y: position y.
	newRegion := (region layer isMetal
		ifTrue: [ aCell metalRegion ]
		ifFalse: [ aCell substrateRegion ]).

	newRegion == region 
		ifFalse: [ self region: newRegion ].
]

{ #category : #accessing }
ChDSequence >> sequenceArray [ 
	
	^ sequenceArray 
]

{ #category : #accessing }
ChDSequence >> sequenceArray: anArray [
	
	sequenceArray := anArray 
]

{ #category : #accessing }
ChDSequence >> signalLength [
	^ signalLength
]

{ #category : #accessing }
ChDSequence >> signalLength: anObject [
	signalLength := anObject
]

{ #category : #initialization }
ChDSequence >> storesOutput [
	
	^ self type = #output or: [ self type = #mixed ]
]

{ #category : #initialization }
ChDSequence >> swap: sequenceIndex [

	| newValue |
	
	(sequenceIndex > sequenceArray size or: [ sequenceIndex < 0 ]) ifTrue: [ ^ self ].
	newValue := (sequenceArray at: sequenceIndex) not.

	sequenceIndex to: sequenceIndex + signalLength - 1 do: [ :i |
		sequenceArray at: i put: newValue ].
]

{ #category : #accessing }
ChDSequence >> type [
	^ type
]

{ #category : #accessing }
ChDSequence >> type: anObject [
	type := anObject
]

{ #category : #accessing }
ChDSequence >> updateRegionAt: time [

	region hasVcc: (sequenceArray at: time).
]
