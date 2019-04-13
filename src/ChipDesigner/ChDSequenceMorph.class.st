Class {
	#name : #ChDSequenceMorph,
	#superclass : #Morph,
	#instVars : [
		'sequence',
		'signalLength',
		'tickLength',
		'editable'
	],
	#category : #ChipDesigner
}

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

]

{ #category : #initialization }
ChDSequenceMorph >> handlesMouseDown: anEvent [

	^ true
]

{ #category : #initialization }
ChDSequenceMorph >> initialize [

	super initialize.
	
	editable := true.
	signalLength := 5.
	tickLength := 2.
	sequence := (1 to: 56 * signalLength) collect: [ :each | false. { true. false } atRandom ].
	
	self extent: (sequence size * tickLength) @ 40.
	
]

{ #category : #initialization }
ChDSequenceMorph >> mouseDown: anEvent [

	| sequenceIndex signalIndex newValue |
	
	signalIndex := ((anEvent cursorPoint x - self bounds left) // tickLength // signalLength) + 1.
	sequenceIndex := (signalIndex-1) * signalLength + 1.
	(sequenceIndex > sequence size or: [ sequenceIndex < 0 ]) ifTrue: [ ^ self ].
	newValue := (sequence at: sequenceIndex) not.

	sequenceIndex to: sequenceIndex + signalLength - 1 do: [ :i |
		sequence at: i put: newValue ].
	
	self changed.

]
