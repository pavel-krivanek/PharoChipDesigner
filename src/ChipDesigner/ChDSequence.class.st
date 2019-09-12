"
I represent a data signal of a given length
"
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
ChDSequence >> decodedFrom: aString [

	sequenceArray := self decodedSequenceFrom: aString
]

{ #category : #initialization }
ChDSequence >> decodedSequenceFrom: aString [

	| byteArray header length i result |
	
	byteArray := OrderedCollection new.
	aString readStreamDo: [ :aStream |
		[ aStream atEnd ] whileFalse: [ 
			byteArray add: ('16r', (aStream next: 2)) asNumber ] ]. 
	byteArray := byteArray asByteArray.

	header := byteArray first.
	length := (byteArray size - 1) * 8 + header.
	result := Array ofSize: length.
	byteArray := byteArray allButFirst.
	
	i := 1.
	1 to: length do: [ :index |
		result at: index put: (((byteArray at: (index-1 // 8)+1) bitAt: ((8-(index-1 \\ 8))))>0)].
	
	^ result

]

{ #category : #initialization }
ChDSequence >> defaultLength [

	^ 56
]

{ #category : #initialization }
ChDSequence >> defaultSignalLength [

	^ 5
]

{ #category : #initialization }
ChDSequence >> encoded [
	
	| length stream header byteArray byte|
	length := sequenceArray size.
	stream := sequenceArray readStream.

	header := { length \\ 8 }.	

	byteArray := (header, ((1 to: (length/8) ceiling) collect: [ :index |
		| exponent |
		byte := stream next: 8.
		exponent := 8.
		byte inject: 0 into: [ :num :each | 
			exponent := exponent - 1.
			num + (each ifTrue: [ 2 raisedTo: exponent ] ifFalse: [ 0 ] ) ] ])) asByteArray.

	^ String streamContents: [ :aStream |
		byteArray do: [:e | e printOn: aStream base: 16 length: 2 padded: true] ]
 
]

{ #category : #initialization }
ChDSequence >> expectedDecodedFrom: aString [

	expectedSequenceArray := self decodedSequenceFrom: aString
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

{ #category : #testing }
ChDSequence >> hasExpectedSequence [

	^ expectedSequenceArray notNil
]

{ #category : #initialization }
ChDSequence >> initialize [

	super initialize.
	
	signalLength := self defaultSignalLength.
	sequenceArray := (1 to: self defaultLength * signalLength) collect: [ :each | nil. ].
	expectedSequenceArray := nil.
	
	currentTime := nil.
	
	type := #output. 
	readOnly := true.

]

{ #category : #initialization }
ChDSequence >> length [

	^ sequenceArray size
]

{ #category : #accessing }
ChDSequence >> matchingSteps [

	expectedSequenceArray ifNil: [ ^ 0 ].
	
	^(sequenceArray withIndexSelect: [ :each :index |
		(expectedSequenceArray at: index) = each ]) size
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
	
	region ifNil: [ 
		"there is not an active region to track"
		^ self ].
	
	region area simulation announcer when: ChDSimulationStepAnnouncement do: [ :announcement |
		currentTime := announcement time. 
		(currentTime > 0 and: [self storesOutput]) ifTrue: [ 
			sequenceArray at: currentTime put: region hasVcc ].
		self valueChanged ].
]

{ #category : #initialization }
ChDSequence >> resetRegion [

	| aCell newRegion |
	
	region ifNil: [ ^ self ].
	
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
	newValue := ((sequenceArray at: sequenceIndex) ifNil: [ false ]) not.

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

	region ifNil: [ ^ self ].
	region hasVcc: (sequenceArray at: time).
]
