Class {
	#name : #ChDSimulation,
	#superclass : #Object,
	#instVars : [
		'area',
		'testingVCC',
		'time'
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

	(aRegion cells select: #via) do: [ :cell |
		aRegion layer isMetal 
			ifTrue: [ self addConnectedVCCRegionsOf: cell substrateRegion to: foundRegions ]
			ifFalse: [ self addConnectedVCCRegionsOf: cell metalRegion to: foundRegions ] ].

	aRegion layer isSubstrate ifTrue: [ 
		aRegion cells do: [ :cell |
			((cell connectedCellsInSubstrate select: #hasJunction) select: [ :junctionCell | junctionCell substrateRegion open ]) do: [ :j | 
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
ChDSimulation >> initialize [

	super initialize.
	
	testingVCC := false.
	time := 0.
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
	
	self stepWith: [ :aSimulation |
		testingVCC ifTrue: [ 
				| vcc |
				vcc := (aSimulation regions detect: [ :e | e cells anySatisfy: [ :c | (c x = 1) and: [ c y = 1 ] ] ]).
		"		vcc currentState: true."
				"vcc futureState: true."
				vcc hasVcc: true.  ].			
		
		 ]
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
"		each currentState: true."
		each futureState: true. ].
		
	time := time + 1.

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
				| input vcc outputRegions connectedRegionsInSubstrate output out |
				input := cell connectedRegionsInJunction anySatisfy: #currentState. 
				connectedRegionsInSubstrate := cell connectedRegionsInSubstrate.
				vcc := each vccRegion ifNil: [connectedRegionsInSubstrate select: #hasVcc].
				each vccRegion: vcc.
				"outputRegions := connectedRegionsInSubstrate reject: #hasVcc."
				outputRegions := connectedRegionsInSubstrate copyWithoutAll: vcc.
				output := input & vcc anyOne currentState & vcc anyOne futureState.
				(input not and: [vcc notEmpty and: [ vcc anyOne futureState ]]) ifTrue: [ 
					vcc anyOne currentState = 0 ifTrue: [ out := false ] ].
				(input and: [vcc notEmpty and: [ vcc anyOne futureState ]]) ifTrue: [ 
					vcc anyOne currentState = 1 ifTrue: [ out := true ] ifFalse: [ out := false ] ].
				(vcc isEmpty or: [ vcc anyOne futureState not ]) 
					ifTrue: [ out := false ]
					ifFalse: [ out := output ].
				
								
				outputRegions do: [ :e | 
					e futureState: out.
					connected := IdentitySet new.
					self addConnectedRegionsOf: e to: connected.
					connected do: [ :ee | ee futureState: out ]  ].		

				"self halt."
"				outputRegions do: [ :e | e futureState: output ]."
"				each hasVcc: vcc notEmpty."
"				outputRegions do: [ :e | e futureState: out ]."
				each open: out.
			"	each open: output."
				"vcc do: [ :e | e futureState: true ]."
				"(vcc isNotEmpty and: [ vcc anySatisfy: [ :e | e currentState ]])
					ifTrue: [ outputRegions do: [ :e | e futureState: (output or: e futureState). ] ] "
					] .
			(cell junctionType = #pnp) ifTrue: [
				| input vcc outputRegions connectedRegionsInSubstrate output out |
				input := cell connectedRegionsInJunction anySatisfy: #currentState. 
				connectedRegionsInSubstrate := cell connectedRegionsInSubstrate.
				vcc := each vccRegion ifNil: [connectedRegionsInSubstrate select: #hasVcc].
				each vccRegion: vcc.
				"outputRegions := connectedRegionsInSubstrate reject: #hasVcc."
				outputRegions := connectedRegionsInSubstrate copyWithoutAll: vcc.
				output := input not.
				(input not and: [vcc notEmpty and: [ vcc anyOne futureState ]]) ifTrue: [ 
					vcc anyOne currentState = 0 ifTrue: [ out := false ] ].
				(input and: [vcc notEmpty and: [ vcc anyOne futureState ]]) ifTrue: [ 
					vcc anyOne currentState = 0 ifTrue: [ out := true ] ].
				(vcc isEmpty or: [ vcc anyOne futureState not ]) 
					ifTrue: [ out := false ]
					ifFalse: [ out := output ].
				
								
				outputRegions do: [ :e | 
					e futureState: out.
					connected := IdentitySet new.
					self addConnectedRegionsOf: e to: connected.
					connected do: [ :ee | ee futureState: out ]  ].		

				"self halt."
"				outputRegions do: [ :e | e futureState: output ]."
"				each hasVcc: vcc notEmpty."
"				outputRegions do: [ :e | e futureState: out ]."
				each open: out.
			"	each open: output."
				"vcc do: [ :e | e futureState: true ]."
				"(vcc isNotEmpty and: [ vcc anySatisfy: [ :e | e currentState ]])
					ifTrue: [ outputRegions do: [ :e | e futureState: (output or: e futureState). ] ] "
					].
			
			 ]  ].
	
"	connected do: [ :currentRegions |
		| state |
		state := currentRegions anySatisfy: [ :each | each futureState ].
		currentRegions do: [ :each | each futureState: state ] ].
"	
	
	regions do: [ :aRegion | 
		aRegion currentState: aRegion futureState ].
		 
]

{ #category : #accessing }
ChDSimulation >> testingVCC [
	^ testingVCC
]

{ #category : #accessing }
ChDSimulation >> testingVCC: anObject [
	testingVCC := anObject
]
