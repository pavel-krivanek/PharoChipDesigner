Class {
	#name : #ChDSimulation,
	#superclass : #Object,
	#instVars : [
		'area',
		'testingVCC',
		'time',
		'announcer',
		'stepBlock'
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
ChDSimulation >> initialize [

	super initialize.
	
	testingVCC := false.
	time := 0.
	announcer := Announcer new.
	stepBlock := self defaultStepBlock.
]

{ #category : #accessing }
ChDSimulation >> regions [

	^ self area regions
]

{ #category : #accessing }
ChDSimulation >> reset [ 
	
	| vccConnected |
	
	self regions do: [ :each |
		each currentState: false.
		each futureState: false.
		each isSpecial ifTrue: [ each open: false ] ].
	
"	self resetVcc."
	
"	self step."

"	self regions do: [ :each |
		each isSpecial ifTrue: [ 
					each open: each hasVcc ] ]"
]

{ #category : #accessing }
ChDSimulation >> resetVcc [
	
	| regions |
	
	regions := self regions.
	regions do: [ :each | 
		each hasVcc: false. ].



]

{ #category : #accessing }
ChDSimulation >> step [ 
	
	self stepWith: stepBlock.
	
	announcer announce: (ChDStepAnnouncement new
		simulation: self;
		time: self time)
]

{ #category : #accessing }
ChDSimulation >> stepBlock [
	^ stepBlock
]

{ #category : #accessing }
ChDSimulation >> stepBlock: anObject [
	stepBlock := anObject
]

{ #category : #accessing }
ChDSimulation >> stepOld [
	
	| regions special normal connected vccConnected |
	
	self resetVcc.

	connected := self connectedRegionsFrom: normal.
	
	regions do: [ :aRegion | 
		aRegion futureState: false. ].

	vccConnected := self connectedVCCRegionsFrom: regions.
	vccConnected do: [ :each | each hasVcc: true ].
	vccConnected do: [ :each | 
		each hasVcc: true.
		each currentState: true.
		each futureState: true. ].


	normal := regions reject: #isSpecial.
	special := regions select: #isSpecial.
	
"	connected do: [ :currentRegions |
		| state |
		state := currentRegions anySatisfy: [ :each | each currentState ].
		currentRegions do: [ :each | each currentState: state ] ].
"	
	special do: [ :each | each isJunction ifTrue: [ 
			| cell | 
		cell := each cells anyOne.
			(cell junctionType = #npn) ifTrue: [ 
				((cell connectedRegionsInJunction anySatisfy: #currentState) 
					and: [ cell connectedRegionsInSubstrate anySatisfy: #currentState ])
					ifTrue: [ cell connectedRegionsInSubstrate do: [ :aRegion | aRegion futureState: true ] ] ] .
			(cell junctionType = #pnp) ifTrue: [
				| input vcc outputRegions connectedRegionsInSubstrate output |
				input := cell connectedRegionsInJunction anySatisfy: #currentState. 
				connectedRegionsInSubstrate := cell connectedRegionsInSubstrate.
				vcc := connectedRegionsInSubstrate select: #hasVcc.
				outputRegions := connectedRegionsInSubstrate reject: #hasVcc.
				output := input not.
				each hasVcc: vcc notEmpty.
				each open: (vcc 
					ifEmpty: [ false ]
					ifNotEmpty: [ output ]).
			"	each open: output."
				"vcc do: [ :e | e futureState: true ]."
				"(vcc isNotEmpty and: [ vcc anySatisfy: [ :e | e currentState ]])
					ifTrue: [ outputRegions do: [ :e | e futureState: (output or: e futureState). ] ] "
					].
			
			 ] ].
	
"	connected do: [ :currentRegions |
		| state |
		state := currentRegions anySatisfy: [ :each | each futureState ].
		currentRegions do: [ :each | each futureState: state ] ].
"	
	
	regions do: [ :aRegion | 
		aRegion currentState: aRegion futureState ].
		 
]

{ #category : #accessing }
ChDSimulation >> stepWith: aBlock [ 
	
	| regions special normal connected vccConnected |
	
	regions := self regions.

	"connected := self connectedRegionsFrom: normal."
	
	regions do: [ :aRegion | 
		aRegion futureState: false. ].


	
	self resetVcc.

	aBlock value: self.	

	vccConnected := self connectedVCCRegionsFrom: regions.
	vccConnected do: [ :each | each hasVcc: true ].
	vccConnected do: [ :each | 
		each hasVcc: true.
		each currentState: true.
		each futureState: true. ].
	time := time + 1.

	normal := regions reject: #isSpecial.
	special := regions select: #isSpecial.
	
	special do: [ :each | each isJunction ifTrue: [ 
			| cell | 
		cell := each cells anyOne.
			(cell junctionType = #npn) ifTrue: [
				| input vcc outputRegions connectedRegionsInSubstrate output out vccCurentState vccFutureState |
				input := cell connectedRegionsInJunction anySatisfy: #hasVcc. 
				connectedRegionsInSubstrate := cell connectedRegionsInSubstrate.
				vcc := each vccRegion isEmptyOrNil ifTrue: [connectedRegionsInSubstrate select: #hasVcc] ifFalse: [each vccRegion].
				each vccRegion: vcc.
				"outputRegions := connectedRegionsInSubstrate reject: #hasVcc."
				outputRegions := connectedRegionsInSubstrate copyWithoutAll: vcc.
				vccCurentState := vcc ifEmpty: [ false ] ifNotEmpty: [ vcc anyOne currentState ].
				vccFutureState := vcc ifEmpty: [ false ] ifNotEmpty: [ vcc anyOne futureState ].
				output := input & vccCurentState & vccFutureState.
				out := output.
								
				outputRegions do: [ :e | 
					e futureState: (out or: [ e futureState ]).
					connected := IdentitySet new.
					self addConnectedRegionsOf: e to: connected.
					connected do: [ :ee | ee futureState: (out or: [ee futureState])]  ].		

				each open: out.

					] .
			(cell junctionType = #pnp) ifTrue: [
				| input vcc outputRegions connectedRegionsInSubstrate output out vccFutureState |

				input := cell connectedRegionsInJunction anySatisfy: #hasVcc. 
				connectedRegionsInSubstrate := cell connectedRegionsInSubstrate.
				vcc := each vccRegion isEmptyOrNil ifTrue: [connectedRegionsInSubstrate select: #hasVcc] ifFalse: [each vccRegion].
				each vccRegion: vcc.
				"outputRegions := connectedRegionsInSubstrate reject: #hasVcc."
				outputRegions := connectedRegionsInSubstrate copyWithoutAll: vcc.
				output := input not.
				vccFutureState := vcc ifEmpty: [ false ] ifNotEmpty: [ vcc anyOne futureState ].
				out := input not and: [vcc notEmpty and: [ vccFutureState ]].
												
				outputRegions do: [ :e | 
					e futureState: (out or: [ e futureState ]).
					connected := IdentitySet new.
					self addConnectedRegionsOf: e to: connected.
					connected do: [ :ee | ee futureState: (out or: [ee futureState])]  ].		

				each open: out.
					].
			
			 ]  ].
	
"	connected do: [ :currentRegions |
		| state |
		state := currentRegions anySatisfy: [ :each | each futureState ].
		currentRegions do: [ :each | each futureState: state ] ].
"	
	
	self resetVcc.

	aBlock value: self.	

	vccConnected := self connectedVCCRegionsFrom: regions.
	vccConnected do: [ :each | each hasVcc: true ].
	vccConnected do: [ :each | 
		each hasVcc: true.
		each currentState: true.
		each futureState: true. ].	
	
	regions do: [ :aRegion | 
		aRegion currentState: aRegion hasVcc ].
		 
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
