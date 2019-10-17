"
I am a morh for rendering of a data sequence
"
Class {
	#name : #ChDSequenceMorph,
	#superclass : #Morph,
	#instVars : [
		'sequence',
		'tickLength',
		'lastSequenceIndexChanged',
		'isMouseDown',
		'graphics'
	],
	#category : #ChipDesigner
}

{ #category : #running }
ChDSequenceMorph class >> on: aChDSequence [

	^ self new sequence: aChDSequence
]

{ #category : #running }
ChDSequenceMorph class >> on: aChDSequence graphics: graphicsProvider [

	^ self new sequence: aChDSequence; graphics: graphicsProvider 
]

{ #category : #initialization }
ChDSequenceMorph >> descriptionWidth [

	^ 50
]

{ #category : #initialization }
ChDSequenceMorph >> drawOn: aCanvas [

	| rect lastPoint newPoint offset fontHeight descriptionPadding |
		
	rect := Rectangle origin: (self bounds topLeft +(self descriptionWidth @0)) corner: self bounds bottomRight.
	
	offset := 7.
	descriptionPadding := 4.
	
	aCanvas fillRectangle: self bounds color: (Color r: 1.0 g: 0.969 b: 0.887 alpha: 1.0).
	
	lastPoint := rect left@(rect bottom - offset).
	
	0 to: (sequence length // sequence signalLength ) do: [ :i |
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
		value ifNotNil: [ 
		newPoint := (rect left + (i*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]) ].
		aCanvas line: lastPoint to: newPoint color: (Color black alpha: 0.3).
		lastPoint := newPoint.	
	] ].

	lastPoint := rect left@(rect bottom - offset).	
		
	sequence sequenceArray withIndexDo: [ :value :i |
		value ifNotNil: [ 
			newPoint := (rect left + ((i-1)*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
			newPoint = lastPoint ifFalse: [ 
				aCanvas line: lastPoint to: newPoint color: Color black ].
			lastPoint := newPoint.
			newPoint := (rect left + (i*tickLength)) @ (value ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).
			aCanvas line: lastPoint to: newPoint color: Color black.
			lastPoint := newPoint.
		] ifNil: [ 
		lastPoint := (rect left + (i*tickLength)) @ (false ifFalse: [rect bottom-offset] ifTrue: [rect top+offset]).] ].




	sequence currentTime ifNotNil: [ 
		| x | 
		x := (sequence currentTime-1) * (tickLength).
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
	
	fontHeight := graphics font height.
	
	aCanvas drawString: sequence name at: self bounds bottomLeft + (descriptionPadding@(fontHeight negated-offset)) font: graphics font color: Color black.
	
		aCanvas 
			line:  self bounds bottomLeft + (0@offset negated)
			to: self bounds bottomLeft + (self descriptionWidth@offset negated)
			color: Color black

]

{ #category : #accessing }
ChDSequenceMorph >> graphics [
	^ graphics
]

{ #category : #accessing }
ChDSequenceMorph >> graphics: anObject [
	graphics := anObject
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
	
	self sequence readOnly ifTrue: [ ^ self ].
	
	isMouseDown := true.
	sequenceIndex := self sequenceIndexFor: anEvent cursorPoint - (self descriptionWidth @ 0).
	lastSequenceIndexChanged := sequenceIndex.

	self swap: sequenceIndex.
		
	
]

{ #category : #initialization }
ChDSequenceMorph >> mouseMove: anEvent [

	| sequenceIndex |

	self sequence readOnly ifTrue: [ ^ self ].
	
	sequenceIndex := self sequenceIndexFor: anEvent cursorPoint - (self descriptionWidth @ 0).
	lastSequenceIndexChanged = sequenceIndex
		ifFalse: [ 
			self swap: (self sequenceIndexFor: anEvent cursorPoint - (self descriptionWidth @ 0)).
			lastSequenceIndexChanged := sequenceIndex ].


]

{ #category : #initialization }
ChDSequenceMorph >> mouseUp: anEvent [

	self sequence readOnly ifTrue: [ ^ self ].

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
