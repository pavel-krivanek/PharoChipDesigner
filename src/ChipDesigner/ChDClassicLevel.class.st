"
s := ChDSequence input name: 'input'.
m := ChDSequenceMorph on: s.
m openInWindow.

s encoded
"
Class {
	#name : #ChDClassicLevel,
	#superclass : #ChDDesign,
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDClassicLevel class >> designName [

	 ^ self levelName
]

{ #category : #'as yet unclassified' }
ChDClassicLevel >> createLabels [

	area descriptions add: ('+Vcc' -> (3@4)).
	area descriptions add: ((ports at: 1) name -> (3@8)).
	area descriptions add: ((ports at: 2) name-> (3@12)).
	area descriptions add: ((ports at: 3) name-> (3@16)).
	area descriptions add: ((ports at: 4) name-> (3@20)).
	area descriptions add: ('+Vcc' -> (3@24)).

	area descriptions add: ('+Vcc' -> (42@4)).
	area descriptions add: ((ports at: 5) name-> (42@8)).
	area descriptions add: ((ports at: 6) name-> (42@12)).
	area descriptions add: ((ports at: 7) name -> (42@16)).
	area descriptions add: ((ports at: 8) name -> (42@20)).
	area descriptions add: ('+Vcc' -> (42@24)).
]

{ #category : #'as yet unclassified' }
ChDClassicLevel >> createScopes [

	sequences := ports with: self portPoints collect: [ :port :aPoint |
		| aSequence |
		port isInput 
			ifTrue: [ 
				aSequence := ChDSequence input name: port name.
				aSequence decodedFrom: port sequence.
				aSequence readOnly: false ]
			ifFalse: [ 
				aSequence := ChDSequence output name: port name.
				aSequence expectedDecodedFrom: port expectedSequence.  ].
			
		aSequence forMetalAt: aPoint in: area.
		aSequence ].
	
	scopes := sequences collect: [ :each | ChDSequenceMorph on: each graphics: self graphics ]
]

{ #category : #initialization }
ChDClassicLevel >> initializeArea [

	area decodeFrom: '0002C0001B000B2200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A100004200612016120121000482006120161201210005C200C1201C12018100048200C1201C12018100004200E1201E1201A100048200E1201E1201A10000420061201612012100048200612016120121000B2'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel >> instructions [

	^ nil
]

{ #category : #'as yet unclassified' }
ChDClassicLevel >> portPoints [

	^ { 3@8. 3@12. 3@16. 3@20. 
	    42@8. 42@12. 42@16. 42@20 }
]

{ #category : #'as yet unclassified' }
ChDClassicLevel >> portsDefinition [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ChDClassicLevel >> vccPoints [

	^ { 3@3. 3@24. 42@3. 42@24 }
]
