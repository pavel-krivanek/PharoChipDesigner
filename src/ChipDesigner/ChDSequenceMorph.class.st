Class {
	#name : #ChDSequenceMorph,
	#superclass : #Morph,
	#instVars : [
		'sequence',
		'tickLength',
		'lastSequenceIndexChanged',
		'isMouseDown'
	],
	#category : #ChipDesigner
}

{ #category : #running }
ChDSequenceMorph class >> on: aChDSequence [

	^ self new sequence: aChDSequence
]

{ #category : #initialization }
ChDSequenceMorph >> descriptionWidth [

	^ 50
]

{ #category : #initialization }
ChDSequenceMorph >> drawOn: aCanvas [

	| rect lastPoint newPoint offset |
		
	rect := Rectangle origin: (self bounds topLeft +(self descriptionWidth @0)) corner: self bounds bottomRight.
	
	offset := 7.
	
	aCanvas fillRectangle: self bounds color: (Color r: 1.0 g: 0.969 b: 0.887 alpha: 1.0).
	
	lastPoint := rect left@(rect bottom - offset).
	
	1 to: (sequence length // sequence signalLength ) do: [ :i |
		| x | 
		x := i * sequence signalLength * tickLength.
		aCanvas 
			line: (rect left + x)@rect top 
			to: (rect left + x)@rect bottom 
			width: 1
			color: (Color r: 0.875 g: 0.851 b: 0.788 alpha: 1.0) 
			dashLength: 2
			secondColor: Color transparent 
			secondDashLength: 2 
			startingOffset: 0 ].

	sequence expectedSequenceArray ifNotNil: [ 
	sequence expectedSequenceArray withIndexDo: [ :value :i |
		newPoint := (rect left + ((i-1)*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
		newPoint = lastPoint ifFalse: [ 
			aCanvas line: lastPoint to: newPoint color: (Color black alpha: 0.3) ].
		lastPoint := newPoint.
		newPoint := (rect left + (i*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
		aCanvas line: lastPoint to: newPoint color: (Color black alpha: 0.3).
		lastPoint := newPoint.	
	] ].

	lastPoint := rect left@(rect bottom - offset).	
		
	sequence sequenceArray withIndexDo: [ :value :i |
		newPoint := (rect left + ((i-1)*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
		newPoint = lastPoint ifFalse: [ 
			aCanvas line: lastPoint to: newPoint color: Color black ].
		lastPoint := newPoint.
		newPoint := (rect left + (i*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
		aCanvas line: lastPoint to: newPoint color: Color black.
		lastPoint := newPoint.	
	].




	sequence currentTime ifNotNil: [ 
		| x | 
		x := sequence currentTime * tickLength + tickLength - 1.
		aCanvas 
			line: (rect left + x)@rect top 
			to: (rect left + x)@rect bottom 
			width: 1
			color: (Color red alpha: 0.3) 
			dashLength: 2
			secondColor: Color transparent 
			secondDashLength: 2 
			startingOffset: 0.		
		
		x := sequence currentTime * tickLength.
		aCanvas 
			line: (rect left + x)@rect top 
			to: (rect left + x)@rect bottom 
			width: 1
			color: (Color red alpha: 0.3) 
			dashLength: 2
			secondColor: Color transparent 
			secondDashLength: 2 
			startingOffset: 0		
		 ].
	
	aCanvas drawString: sequence name at: self bounds topLeft.

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
ChDSequenceMorph >> initializeOn: aSequence [

	sequence := aSequence.
		
	tickLength := 2.
	
	self extent: (sequence length * tickLength + self descriptionWidth) @ 30.

	isMouseDown := false.
	lastSequenceIndexChanged := nil.
	
	sequence whenChangedDo: [ self changed ]
]

{ #category : #initialization }
ChDSequenceMorph >> mouseDown: anEvent [

	| sequenceIndex |
	
	isMouseDown := true.
	sequenceIndex := self sequenceIndexFor: anEvent cursorPoint - (self descriptionWidth @ 0).
	lastSequenceIndexChanged := sequenceIndex.

	self swap: sequenceIndex.
		
	
]

{ #category : #initialization }
ChDSequenceMorph >> mouseMove: anEvent [

	| sequenceIndex |
	
	sequenceIndex := self sequenceIndexFor: anEvent cursorPoint - (self descriptionWidth @ 0).
	lastSequenceIndexChanged = sequenceIndex
		ifFalse: [ 
			self swap: (self sequenceIndexFor: anEvent cursorPoint - (self descriptionWidth @ 0)).
			lastSequenceIndexChanged := sequenceIndex ].


]

{ #category : #initialization }
ChDSequenceMorph >> mouseUp: anEvent [

	isMouseDown := false.
	lastSequenceIndexChanged := nil.
]

{ #category : #accessing }
ChDSequenceMorph >> sequence [ 
	
	^ sequence 
]

{ #category : #accessing }
ChDSequenceMorph >> sequence: aChDSequence [
	
	sequence := aChDSequence.
	
	self initializeOn: aChDSequence
]

{ #category : #initialization }
ChDSequenceMorph >> sequenceIndexFor: aPoint [

	| signalIndex |
	
	signalIndex := ((aPoint x - self bounds left) // tickLength // sequence signalLength) + 1.
	^ (signalIndex-1) * sequence signalLength + 1.

]

{ #category : #initialization }
ChDSequenceMorph >> swap: sequenceIndex [
	
	sequence swap: sequenceIndex.
	
	isMouseDown := true.
	
	self changed.

]
