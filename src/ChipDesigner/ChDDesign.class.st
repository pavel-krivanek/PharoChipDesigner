Class {
	#name : #ChDDesign,
	#superclass : #ChDGenericDesign,
	#instVars : [
		'area',
		'ports',
		'sequences',
		'scopes',
		'graphics'
	],
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDDesign class >> designName [

	 self subclassResponsibility 
]

{ #category : #'instance creation' }
ChDDesign class >> levelName [

	 ^ self subclassResponsibility
]

{ #category : #'instance creation' }
ChDDesign class >> levels [

	^ Array new
]

{ #category : #'instance creation' }
ChDDesign class >> on: area [

	^ self basicNew
		area: area;
		initialize
]

{ #category : #'instance creation' }
ChDDesign class >> on: area graphics: graphicsProvider [

	^ self basicNew
		area: area;
		graphics: graphicsProvider;
		initialize
]

{ #category : #accessing }
ChDDesign class >> priority [ 

	^ 300
]

{ #category : #'as yet unclassified' }
ChDDesign class >> selectable [

	^ true
]

{ #category : #accessing }
ChDDesign >> area [
	^ area
]

{ #category : #accessing }
ChDDesign >> area: anObject [
	area := anObject
]

{ #category : #accessing }
ChDDesign >> createLabels [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ChDDesign >> createScopes [

	sequences := ports with: self portPoints collect: [ :port :aPoint |
		| aSequence |
		port isInput 
			ifTrue: [ 
				aSequence := ChDSequence input name: port name.
				aSequence decodedFrom: port sequence.
				aSequence readOnly: self readOnlyScopes ]
			ifFalse: [ 
				aSequence := ChDSequence output name: port name.
				aSequence expectedDecodedFrom: port expectedSequence ].
			
		aSequence forMetalAt: aPoint in: area.
		aSequence ].
	
	scopes := sequences collect: [ :each | ChDSequenceMorph on: each graphics: self graphics ]
]

{ #category : #accessing }
ChDDesign >> graphics [
	^ graphics
]

{ #category : #accessing }
ChDDesign >> graphics: anObject [
	graphics := anObject
]

{ #category : #initialization }
ChDDesign >> initialize [ 

	super initialize.
		
	self initializeArea.

	ports := self portsDefinition.
	ports do: [ :each | each isInput: (each expectedSequence = 0) ].

	self createScopes.

	self initializeSimulation.
	
	self createLabels.
]

{ #category : #initialization }
ChDDesign >> initializeSimulation [

	area simulation preStepBlock: [ :aSimulation |
		
		aSimulation sequences: sequences.
	
		sequences do: [ :aSequence | aSequence resetRegion ].	
				
		aSimulation time > 0 ifTrue: [
			sequences with: ports do: [ :sequence :port | 
				port isInput ifTrue: [ 
					sequence updateRegionAt: aSimulation time ] ] ].

		"set Vcc after inputs so they can  overwrite them"
		aSimulation time > 0 ifTrue: [
			self vccPoints do: [ :aPoint |
				(area atX: aPoint x y: aPoint y) withMetalRegionDo: [ :region | region hasVcc: true ] ] ]
	].
	
]

{ #category : #definition }
ChDDesign >> portPoints [

	^ self subclassResponsibility 
]

{ #category : #definition }
ChDDesign >> readOnlyScopes [

	^ true
]

{ #category : #operations }
ChDDesign >> reinitialize [ 

	self initializeSimulation.
	
	self createLabels.
]

{ #category : #accessing }
ChDDesign >> scopes [ 

	^ scopes
]

{ #category : #definition }
ChDDesign >> vccPoints [ 

	self subclassResponsibility 
]
