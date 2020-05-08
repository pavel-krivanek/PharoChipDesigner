"
I manage the changes of the state of particular cells of the array when the logical simulation is executed
"
Class {
	#name : #ChDSimulation,
	#superclass : #Object,
	#instVars : [
		'area',
		'testingVCC',
		'time',
		'announcer',
		'preStepBlock',
		'postStepBlock',
		'stepping',
		'sequences'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDSimulation >> addConnectedRegionsOf: aRegion to: foundRegions [

	(foundRegions includes: aRegion) ifTrue: [ ^ self ].
	
	foundRegions add: aRegion. 
	
	(aRegion cells select: #via) do: [ :cell |
		aRegion layer isMetal 
			ifTrue: [ self addConnectedRegionsOf: cell substrateRegion to: foundRegions ]
			ifFalse: [ self addConnectedRegionsOf: cell metalRegion to: foundRegions ] ].
			
]

{ #category : #accessing }
ChDSimulation >> addConnectedVCCRegionsOf: aRegion to: foundRegions [

	(foundRegions includes: aRegion) ifTrue: [ ^ self ].
	
	foundRegions add: aRegion. 
	
	(aRegion isJunction and: [ aRegion open ]) ifTrue: [ 
		aRegion cells anyOne connectedRegionsInSubstrate do: [ :connectedRegion | 
			self addConnectedVCCRegionsOf: connectedRegion to: foundRegions ] ].

	(aRegion cells select: #via) do: [ :cell |
		aRegion layer isMetal 
			ifTrue: [ self addConnectedVCCRegionsOf: cell substrateRegion to: foundRegions ]
			ifFalse: [ self addConnectedVCCRegionsOf: cell metalRegion to: foundRegions ] ].

	aRegion layer isSubstrate ifTrue: [ 
		aRegion cells do: [ :cell |
			((cell connectedCellsInSubstrateWithoutBaseConnections select: #hasJunction) select: [ :junctionCell | junctionCell substrateRegion open ]) do: [ :j | 
				 self addConnectedVCCRegionsOf: j substrateRegion to: foundRegions ]]].
	
"	(aRegion cells ) do: [ :cell |
		aRegion layer isMetal 
			ifTrue: [ self addConnectedVCCRegionsOf: cell substrateRegion to: foundRegions ]
			ifFalse: [ self addConnectedVCCRegionsOf: cell metalRegion to: foundRegions ] ]."
"		
	(aRegion isSpecial and: [ aRegion open ]) ifTrue: [ 
		aRegion cells anyOne connectedCellsInSubstrate do: [ :aCell | 
			self addConnectedVCCRegionsOf: aCell substrateRegion to: foundRegions ] ]
"			
]

{ #category : #accessing }
ChDSimulation >> announceStep [	
	
	announcer announce: (ChDSimulationStepAnnouncement new
		simulation: self;
		time: self time)
]

{ #category : #accessing }
ChDSimulation >> announcer [

	^ announcer
]

{ #category : #accessing }
ChDSimulation >> area [
	^ area
]

{ #category : #accessing }
ChDSimulation >> area: anObject [
	area := anObject
]

{ #category : #accessing }
ChDSimulation >> connectedRegionsFrom: regions [

	| result notProcessed |
	
	result := OrderedCollection new.
	notProcessed := self regions copy asIdentitySet.

	[ notProcessed isEmpty ] whileFalse: [ 
		| connected |
		connected := IdentitySet new.
		self addConnectedRegionsOf: notProcessed anyOne to: connected.
		result add: connected.
		notProcessed := notProcessed copyWithoutAll: connected.  		
	 ]. 	

	^ result.
]

{ #category : #accessing }
ChDSimulation >> connectedVCCRegionsFrom: regions [

	| result  withVcc |
	
	result := IdentitySet new.
	
	withVcc := regions select: #hasVcc.

	withVcc do: [ :each |
		self addConnectedVCCRegionsOf: each to: result ].	

	^ result.
]

{ #category : #accessing }
ChDSimulation >> defaultStepBlock [

	^ [ :aSimulation |
		testingVCC ifTrue: [ 
				| vcc |
				vcc := (aSimulation regions detect: [ :e | e cells anySatisfy: [ :c | (c x = 1) and: [ c y = 1 ] ] ]).
				vcc hasVcc: true.  ].				
		 ].
	
]

{ #category : #accessing }
ChDSimulation >> evaluate [ 

	announcer announce: (ChDSimulationEvaluationAnnouncement new
		simulation: self;
		passRatio: self passRatio)
]

{ #category : #accessing }
ChDSimulation >> initialize [

	super initialize.
	
	testingVCC := false.
	time := 0.
	announcer := Announcer new.
	preStepBlock := self defaultStepBlock.
	stepping := false.
	sequences := OrderedCollection new.
]

{ #category : #accessing }
ChDSimulation >> passRatio [

	| interestingSequences all passing |
	
	interestingSequences := self sequences select: [ :each | each hasExpectedSequence ].
	
	all := interestingSequences sum: [ :each | each length ].
	passing := interestingSequences sum: [ :each | each matchingSteps ].
	
	all = 0 ifTrue: [ ^ 0 ].
	
	^ passing / (all / 100.0)
]

{ #category : #accessing }
ChDSimulation >> postStepBlock [
	^ postStepBlock
]

{ #category : #accessing }
ChDSimulation >> postStepBlock: anObject [
	postStepBlock := anObject
]

{ #category : #accessing }
ChDSimulation >> preStepBlock [
	^ preStepBlock
]

{ #category : #accessing }
ChDSimulation >> preStepBlock: anObject [
	preStepBlock := anObject
]

{ #category : #accessing }
ChDSimulation >> regions [

	^ self area regions
]

{ #category : #accessing }
ChDSimulation >> reset [ 
		
	self regions do: [ :each |
		each currentState: false.
		each futureState: false.
		each isSpecial ifTrue: [ each open: false ] ].
	
	self resetTime.
	
]

{ #category : #accessing }
ChDSimulation >> resetTime [

	time := 0.
	self announceStep
]

{ #category : #accessing }
ChDSimulation >> resetVcc [
	
	| regions |
	
	regions := self regions.
	regions do: [ :each | 
		each hasVcc: false. ].



]

{ #category : #accessing }
ChDSimulation >> sequences [
	^ sequences
]

{ #category : #accessing }
ChDSimulation >> sequences: anObject [
	sequences := anObject
]

{ #category : #accessing }
ChDSimulation >> step [ 
	
	self stepWith: preStepBlock.
	
	postStepBlock ifNotNil: [ 
		postStepBlock value: self ].	
	
	self announceStep
]

{ #category : #accessing }
ChDSimulation >> stepWith: aBlock [
	| regions special normal connected vccConnected shortestSequenceLength |
	regions := self regions.

	"connected := self connectedRegionsFrom: normal."

	regions do: [ :aRegion | aRegion futureState: false ].

	self resetVcc.

	aBlock value: self.

	shortestSequenceLength := self sequences ifEmpty: [ 5 * 56 ] ifNotEmpty: [ (self sequences collect: #length) min ].

	time >= shortestSequenceLength ifTrue: [ ^ self ].

	vccConnected := self connectedVCCRegionsFrom: regions.
	vccConnected do: [ :each | each hasVcc: true ].
	vccConnected
		do: [ :each | 
			each hasVcc: true.
			each currentState: true.
			each futureState: true ].

	time := time + 1.

	normal := regions reject: #isSpecial.
	special := regions select: #isSpecial.

	special
		do: [ :each | 
			each isJunction
				ifTrue: [ | cell |
					cell := each cells anyOne.
					cell junctionType = #npn
						ifTrue: [ | input vcc outputRegions connectedRegionsInSubstrate output out vccCurentState vccFutureState |
							input := cell connectedRegionsInJunction anySatisfy: #hasVcc.
							connectedRegionsInSubstrate := cell connectedRegionsInSubstrate.
							vcc := each vccRegion isEmptyOrNil
								ifTrue: [ connectedRegionsInSubstrate select: #hasVcc ]
								ifFalse: [ each vccRegion ].
							each vccRegion: vcc.
							"outputRegions := connectedRegionsInSubstrate reject: #hasVcc."
							outputRegions := connectedRegionsInSubstrate copyWithoutAll: vcc.
							vccCurentState := vcc ifEmpty: [ false ] ifNotEmpty: [ vcc anyOne currentState ].
							vccFutureState := vcc ifEmpty: [ false ] ifNotEmpty: [ vcc anyOne futureState ].
							output := input & vccCurentState & vccFutureState.
							out := output.

							outputRegions
								do: [ :e | 
									e futureState: (out or: [ e futureState ]).
									connected := IdentitySet new.
									self addConnectedRegionsOf: e to: connected.
									connected do: [ :ee | ee futureState: (out or: [ ee futureState ]) ] ].

							each open: input	"& vccCurentState"
							"each open: out." ].
					cell junctionType = #pnp
						ifTrue: [ | input vcc outputRegions connectedRegionsInSubstrate output out vccFutureState |
							input := cell connectedRegionsInJunction anySatisfy: #hasVcc.
							connectedRegionsInSubstrate := cell connectedRegionsInSubstrate.
							vcc := each vccRegion isEmptyOrNil
								ifTrue: [ connectedRegionsInSubstrate select: #hasVcc ]
								ifFalse: [ each vccRegion ].
							each vccRegion: vcc.
							"outputRegions := connectedRegionsInSubstrate reject: #hasVcc."
							outputRegions := connectedRegionsInSubstrate copyWithoutAll: vcc.
							output := input not.
							vccFutureState := vcc ifEmpty: [ false ] ifNotEmpty: [ vcc anyOne futureState ].
							out := input not and: [ vcc isNotEmpty and: [ vccFutureState ] ].

							outputRegions
								do: [ :e | 
									e futureState: (out or: [ e futureState ]).
									connected := IdentitySet new.
									self addConnectedRegionsOf: e to: connected.
									connected do: [ :ee | ee futureState: (out or: [ ee futureState ]) ] ].

							each open: input not
							"each open: out." ] ] ].

	"	connected do: [ :currentRegions |
		| state |
		state := currentRegions anySatisfy: [ :each | each futureState ].
		currentRegions do: [ :each | each futureState: state ] ].
"

	self resetVcc.

	aBlock value: self.

	vccConnected := self connectedVCCRegionsFrom: regions.
	vccConnected do: [ :each | each hasVcc: true ].
	vccConnected
		do: [ :each | 
			each hasVcc: true.
			each currentState: true.
			each futureState: true ].

	regions do: [ :aRegion | aRegion currentState: aRegion hasVcc ]
]

{ #category : #accessing }
ChDSimulation >> stepping [
	^ stepping
]

{ #category : #accessing }
ChDSimulation >> stepping: anObject [
	stepping := anObject
]

{ #category : #accessing }
ChDSimulation >> stop [

	stepping := false.
	
	announcer announce: (ChDSimulationRunAnnouncement new
		simulation: self;
		running: false)	
]

{ #category : #accessing }
ChDSimulation >> testingVCC [
	^ testingVCC
]

{ #category : #accessing }
ChDSimulation >> testingVCC: anObject [
	testingVCC := anObject
]

{ #category : #accessing }
ChDSimulation >> time [ 

	^ time
]

{ #category : #accessing }
ChDSimulation >> toggleStepping [

	stepping := stepping not.
	
	announcer announce: (ChDSimulationRunAnnouncement new
		simulation: self;
		running: stepping)	
]
