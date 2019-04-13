Class {
	#name : #ChDSequenceMorph,
	#superclass : #Morph,
	#instVars : [
		'sequence',
		'signalLength',
		'tickLength',
		'editable',
		'lastSequenceIndexChanged',
		'isMouseDown',
		'region',
		'type',
		'name',
		'currentTime'
	],
	#category : #ChipDesigner
}

{ #category : #running }
ChDSequenceMorph class >> input [ 

	^ self new type: #input.
]

{ #category : #running }
ChDSequenceMorph class >> output [ 

	^ self new type: #output.
]

{ #category : #initialization }
ChDSequenceMorph >> drawOn: aCanvas [

	| rect lastPoint newPoint offset |
		
	rect := self bounds.
	
	offset := 8.
	
	aCanvas fillRectangle: rect color: (Color r: 1.0 g: 0.969 b: 0.887 alpha: 1.0).
	
	lastPoint := rect left@(rect bottom - offset).
	
	1 to: (sequence size // signalLength ) do: [ :i |
		| x | 
		x := i * signalLength * tickLength.
		aCanvas 
			line: (rect left + x)@rect top 
			to: (rect left + x)@rect bottom 
			width: 1
			color: (Color r: 0.875 g: 0.851 b: 0.788 alpha: 1.0) 
			dashLength: 2
			secondColor: Color transparent 
			secondDashLength: 2 
			startingOffset: 0 ].
		
	sequence withIndexDo: [ :value :i |
		newPoint := (rect left + ((i-1)*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
		newPoint = lastPoint ifFalse: [ 
			aCanvas line: lastPoint to: newPoint color: Color black ].
		lastPoint := newPoint.
		newPoint := (rect left + (i*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
		aCanvas line: lastPoint to: newPoint color: Color black.
		lastPoint := newPoint.	
	].

	currentTime ifNotNil: [ 
		| x | 
		x := currentTime * tickLength + tickLength - 1.
		aCanvas 
			line: (rect left + x)@rect top 
			to: (rect left + x)@rect bottom 
			width: 1
			color: (Color red alpha: 0.3) 
			dashLength: 2
			secondColor: Color transparent 
			secondDashLength: 2 
			startingOffset: 0.		
		
		x := currentTime * tickLength.
		aCanvas 
			line: (rect left + x)@rect top 
			to: (rect left + x)@rect bottom 
			width: 1
			color: (Color red alpha: 0.3) 
			dashLength: 2
			secondColor: Color transparent 
			secondDashLength: 2 
			startingOffset: 0		
		 ]

]

{ #category : #initialization }
ChDSequenceMorph >> handlesMouseDown: anEvent [

	^ true
]

{ #category : #initialization }
ChDSequenceMorph >> handlesMouseMove: evt [
	^ isMouseDown
]

{ #category : #initialization }
ChDSequenceMorph >> initialize [

	super initialize.
	
	editable := true.
	signalLength := 5.
	tickLength := 2.
	sequence := (1 to: 56 * signalLength) collect: [ :each | false. ].
	
	self extent: (sequence size * tickLength) @ 40.
	isMouseDown := false.
	
	lastSequenceIndexChanged := nil.
	currentTime := nil.
]

{ #category : #initialization }
ChDSequenceMorph >> mouseDown: anEvent [

	| sequenceIndex |
	
	isMouseDown := true.
	sequenceIndex := self sequenceIndexFor: anEvent cursorPoint.
	lastSequenceIndexChanged := sequenceIndex.

	self swap: sequenceIndex.
		
	
]

{ #category : #initialization }
ChDSequenceMorph >> mouseMove: anEvent [

	| sequenceIndex |
	
	sequenceIndex := self sequenceIndexFor: anEvent cursorPoint.
	lastSequenceIndexChanged = sequenceIndex
		ifFalse: [ 
			self swap: (self sequenceIndexFor: anEvent cursorPoint).
			lastSequenceIndexChanged := sequenceIndex ].


]

{ #category : #initialization }
ChDSequenceMorph >> mouseUp: anEvent [

	isMouseDown := false.
	lastSequenceIndexChanged := nil.
]

{ #category : #initialization }
ChDSequenceMorph >> name [ 

	^ name
]

{ #category : #initialization }
ChDSequenceMorph >> name: aString [

	name := aString.
]

{ #category : #initialization }
ChDSequenceMorph >> printOn: aStream [

	name printOn: aStream
]

{ #category : #accessing }
ChDSequenceMorph >> region [
	^ region
]

{ #category : #accessing }
ChDSequenceMorph >> region: aRegion [
	
	region ifNotNil: [ region area simulation announcer unsubscribe: self ].

	region := aRegion.
	
	region area simulation announcer when: ChDStepAnnouncement do: [ :announcement |
		type = #output ifTrue: [ 
			sequence at: announcement time put: region hasVcc ].
		currentTime := announcement time. 
		self changed ].
]

{ #category : #accessing }
ChDSequenceMorph >> sequence [ 
	
	^ sequence 
]

{ #category : #initialization }
ChDSequenceMorph >> sequenceIndexFor: aPoint [

	| signalIndex |
	
	signalIndex := ((aPoint x - self bounds left) // tickLength // signalLength) + 1.
	^ (signalIndex-1) * signalLength + 1.

]

{ #category : #initialization }
ChDSequenceMorph >> swap: sequenceIndex [

	| newValue |
	
	(sequenceIndex > sequence size or: [ sequenceIndex < 0 ]) ifTrue: [ ^ self ].
	newValue := (sequence at: sequenceIndex) not.

	sequenceIndex to: sequenceIndex + signalLength - 1 do: [ :i |
		sequence at: i put: newValue ].
	
	isMouseDown := true.
	
	self changed.

]

{ #category : #accessing }
ChDSequenceMorph >> type [
	^ type
]

{ #category : #accessing }
ChDSequenceMorph >> type: anObject [
	type := anObject
]
