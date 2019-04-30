Class {
	#name : #ChDPlayground100x100,
	#superclass : #ChDDesign,
	#instVars : [
		'area',
		'ports',
		'sequences',
		'scopes'
	],
	#category : #'ChipDesigner-Levels'
}

{ #category : #'instance creation' }
ChDPlayground100x100 class >> designName [

	 ^ 'Playground 100x100'
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 class >> isRoot [ 

	^ true
]

{ #category : #'instance creation' }
ChDPlayground100x100 class >> levelName [

	 ^ self subclassResponsibility
]

{ #category : #'instance creation' }
ChDPlayground100x100 class >> levels [

	^ Array new
]

{ #category : #'instance creation' }
ChDPlayground100x100 class >> on: area [

	^ self basicNew
		area: area;
		initialize
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 class >> priority [ 

	^ 300
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 class >> selectable [

	^ true
]

{ #category : #accessing }
ChDPlayground100x100 >> area [
	^ area
]

{ #category : #accessing }
ChDPlayground100x100 >> area: anObject [
	area := anObject
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> createLabels [

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
ChDPlayground100x100 >> createScopes [

	sequences := ports with: self portPoints collect: [ :port :aPoint |
		| aSequence |
		port isInput 
			ifTrue: [ 
				aSequence := ChDSequence input name: port name.
				aSequence decodedFrom: port sequence ]
			ifFalse: [ 
				aSequence := ChDSequence output name: port name.
				aSequence expectedDecodedFrom: port expectedSequence ].
			
		aSequence forMetalAt: aPoint in: area.
		aSequence ].
	
	scopes := sequences collect: [ :each | ChDSequenceMorph on: each ]
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> initialize [ 

	super initialize.
		
	self initializeArea.

	ports := self portsDefinition.
	ports do: [ :each | each isInput: (each expectedSequence = 0) ].

	self createScopes.

	self initializeSimulation.
	
	self createLabels.
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> initializeArea [

	area decodedFromZipString: 'H4sIAAAAAAAAADMwMDAzgRFurkDC0sTIwMDZ0MjAEExYGALFTCwwxcxB6lxBXDDhCFeHJgZWZwbiggkjuDo0MbDlxq4j3/KRbzkdLR/5BCHCwgAAvy0eDiQEAAA='
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> initializeSimulation [

	area simulation preStepBlock: [ :aSimulation |
	
		sequences do: [ :aSequence | aSequence resetRegion ].	
				
		aSimulation time > 0 ifTrue: [
			sequences with: ports do: [ :sequence :port | 
				port isInput ifTrue: [ 
					sequence updateRegionAt: aSimulation time ] ] ].

		"set Vcc after inputs so they can  overwrite them"
		aSimulation time > 0 ifTrue: [ 
			(area atX: 3 y: 3) metalRegion hasVcc: true.
			(area atX: 3 y: 24) metalRegion hasVcc: true.
			(area atX: 42 y: 3) metalRegion hasVcc: true.
			(area atX: 42 y: 24) metalRegion hasVcc: true. ]
	].
	
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> instructions [

	^ 'intro.png'
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> portPoints [

	^ { 3@8. 3@12. 3@16. 3@20. 
	    42@8. 42@12. 42@16. 42@20 }
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: 1895286724122662508214109177388798933309665208831355630489573082672101741663618047.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: 1807484548951638332871050064150417808546271801152871425639336334841190810623.
		ChipDesignerClassicLevelPort 
			name: 'A2'
			sequence: 1807484547269931066782991785428060059785466597904927945672633562124766938111.
		ChipDesignerClassicLevelPort 
			name: 'A3'
			sequence: 1895286724120940438332946554699648321487632970982088488659496892968870214733134848.			

		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: 1940773605501606408411247797646130107709097173843308165621322836656232183463544880128.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: 1942668890418244521967823573952468842491989030505867720098940984099567950364017687552.	 
		ChipDesignerClassicLevelPort 
			name: 'Y2'
			expectedSequence: 1942668890418244523649530840040527121214346779266672923346884464066270723080441560064.	 
		ChipDesignerClassicLevelPort 
			name: 'Y3'
			expectedSequence: 1940773605501608130481128960268819258320919206081157432763152912845935414990475363327.	 
		}


]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> reinitialize [ 

	self initializeSimulation.
	
	self createLabels.
]

{ #category : #'as yet unclassified' }
ChDPlayground100x100 >> scopes [ 

	^ scopes
]
