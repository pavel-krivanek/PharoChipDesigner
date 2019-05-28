Class {
	#name : #ChDSubstrateLayer,
	#superclass : #ChDLayer,
	#category : #ChipDesigner
}

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> clearJunctionIn: aCell whenDelete: deletedCell [

	| newJunctionConnections newSubstrateConnections substrateConnectionsMask oldJunctionConnections |
	
	aCell hasJunction ifFalse: [ ^self ].
	
	newJunctionConnections := aCell junctionConnections.
	oldJunctionConnections := aCell junctionConnections.
	newSubstrateConnections := aCell substrateConnections.
	substrateConnectionsMask := 2r1111.

	newJunctionConnections ifNotNil: [

		aCell topology up = deletedCell
			ifTrue: [ 
				newJunctionConnections := newJunctionConnections bitAnd: 2r1110.
				newSubstrateConnections := newSubstrateConnections bitAnd: 2r1110.
				substrateConnectionsMask := 2r1110 ].
		aCell topology right = deletedCell
			ifTrue: [ 
				newJunctionConnections := newJunctionConnections bitAnd: 2r1101.
				newSubstrateConnections := newSubstrateConnections bitAnd: 2r1101.
				substrateConnectionsMask := 2r1101 ].
		aCell topology down = deletedCell
			ifTrue: [ 
				newJunctionConnections := newJunctionConnections bitAnd: 2r1011.
				newSubstrateConnections := newSubstrateConnections bitAnd: 2r1011.
				substrateConnectionsMask := 2r1011 ].
		aCell topology left = deletedCell
			ifTrue: [ 
				newJunctionConnections := newJunctionConnections bitAnd: 2r0111.
				newSubstrateConnections := newSubstrateConnections bitAnd: 2r0111.
				substrateConnectionsMask := 2r0111 ] ].
	
	(newJunctionConnections = 0 or: [ (newSubstrateConnections = 2r0101 or: [ newSubstrateConnections = 2r1010 ]) not ])
		ifTrue: [ 
			aCell junctionType: nil.
			newJunctionConnections := nil.
			newSubstrateConnections := newSubstrateConnections bitAnd: substrateConnectionsMask.
			self clear: aCell withOld: oldJunctionConnections. ].
		
	aCell junctionConnections: newJunctionConnections.
	aCell substrateConnections: newSubstrateConnections.
	
	area updateCell: aCell mode: aCell substrateType.

]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> connectedNeighboursOf: aCell [

	| result |
	
	result := OrderedCollection new.
	(((aCell substrateConnections bitAnd: 2r0001) > 0) and: [ aCell topology up hasJunction not ]) ifTrue: [ result add: aCell topology up ].
	(((aCell substrateConnections bitAnd: 2r0010) > 0) and: [ aCell topology right hasJunction not ]) ifTrue: [ result add: aCell topology right ].
	(((aCell substrateConnections bitAnd: 2r0100) > 0) and: [ aCell topology down hasJunction not ]) ifTrue: [ result add: aCell topology down ].
	(((aCell substrateConnections bitAnd: 2r1000) > 0) and: [ aCell topology left hasJunction not ]) ifTrue: [ result add: aCell topology left ].
	^ result
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> connectionsFor: aCell [

	^ aCell substrateConnections
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> connectionsFor: aCell add: anInteger [

	^ aCell substrateConnections: ((aCell substrateConnections ifNil: [ 0 ]) bitOr: anInteger)
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> connectionsFor: aCell delete: anInteger [

	aCell substrateType ifNil: [ ^ self ].

	^ aCell substrateConnections: ((aCell substrateConnections ifNil: [ 0 ]) bitAnd: anInteger bitInvert)
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> cornersFor: aCell [

	^ aCell substrateCorners
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> createJunctionRegionIn: aCell [

	| newRegions junctionRegion |
	
	aCell substrateRegion cells remove: aCell.
	newRegions := aCell substrateRegion splitted.
	area regions remove: aCell substrateRegion.
	area regions addAll: newRegions.			

	junctionRegion :=  area newJunctionRegion.
	aCell substrateRegion: junctionRegion.
	junctionRegion cells add: aCell.
	
	junctionRegion updateCompactRegions.
	
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> deleteAdjacentJunctionsFor: aCell [

	aCell connectedCellsInSubstrate do: [ :adjacentCell |
		self clearJunctionIn: adjacentCell whenDelete: aCell  ]
	
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> direction: adjacentCell of: aCell last: aLastCell toType: toType connections: connections [

	| fromType | 
	
	fromType := toType = #p ifTrue: [ #n ] ifFalse: [ #p ].
	
	^ (((adjacentCell = aLastCell) and: [ adjacentCell substrateType = toType ]) 
		and: [ aCell substrateType = fromType ]) 
		and: [ aCell substrateConnections = connections ]

]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> fullClear: aCell [

	| oldConnections |
	
	oldConnections := aCell substrateConnections.
	aCell hasJunction ifTrue: [ 
		oldConnections := oldConnections bitOr: aCell junctionConnections ].

	self deleteAdjacentJunctionsFor: aCell.

	aCell substrateType: nil.
	aCell substrateConnections: nil.
	aCell junctionType: nil.
	aCell junctionConnections: nil.
	aCell clearVia.
	aCell unsetAdjacentSubstrateCorners.
	
	self clear: aCell withOld: oldConnections.
	

]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> isSetFor: aCell [

	^ aCell substrateType notNil
]

{ #category : #accessing }
ChDSubstrateLayer >> isSubstrate [

	^ true
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> junctionFrom: adjacentCell to: aCell ofType: toType if: ifConnections andLastIs: aLastCell thenDefineJunction: junctionConnections orIfExists: junctionConnectionIfExists addConnection: lastCellConnection mode: mode [

	| junctionType |
	junctionType := (toType = #p) ifTrue: [ #npn ] ifFalse: [ #pnp ].

	(self direction: adjacentCell of: aCell last: aLastCell toType: toType connections: ifConnections)
		ifTrue: [
			(aCell junctionType = junctionType) ifFalse: [ 
				aCell junctionType: junctionType.
				aCell junctionConnections: junctionConnections.
				self connectionsFor: aLastCell add: lastCellConnection. 
				self createJunctionRegionIn: aCell.]
			ifTrue: [ 
				aCell junctionConnections: junctionConnectionIfExists.
				super setFor: aCell with: aLastCell mode: mode.
				area updateCell: aCell mode: mode ].	
			^ true ].		

	^ false
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> mode: mode compatibleWith: lastCell [

	^ mode = lastCell substrateType
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> name [

	^ #substrate
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> regionOf: aCell [

	^ aCell substrateRegion 
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> removeRegionFrom: aCell [

	| newRegions |
	
	aCell substrateRegion cells remove: aCell.
	newRegions := aCell substrateRegion splitted.
	area regions remove: aCell substrateRegion.
	aCell substrateRegion: nil.
	area regions addAll: newRegions.			
	
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> setFor: aCell mode: aMode [

	aCell substrateRegion ifNotNil: [ ^ self ].
	aCell substrateType ifNil: [ aCell substrateConnections: 0 ].
	aCell substrateType: aMode.
	
	aCell substrateRegion: self area newSubstrateRegion.
	aCell substrateRegion cells add: aCell. 

]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> setFor: aCell with: aLastCell mode: mode [

	| left right top down |
	
	"aCell junctionType ifNotNil: [ ^ self ]."
	
	left := self area leftX: aCell x y: aCell y.
	right := self area rightX: aCell x y: aCell y.
	top := self area topX: aCell x y: aCell y.
	down := self area downX: aCell x y: aCell y.

	(self junctionFrom: left to: aCell ofType: #p if: 2r0101 andLastIs: aLastCell thenDefineJunction: 2r1000 orIfExists: 2r1010 addConnection: 2r0010 mode: mode)
		ifTrue: [ ^ self ].	

	(self junctionFrom: top to: aCell ofType: #p if: 2r1010 andLastIs: aLastCell thenDefineJunction: 2r0001 orIfExists: 2r0101 addConnection: 2r0100 mode: mode)
		ifTrue: [ ^ self ].	

	(self junctionFrom: right to: aCell ofType: #p if: 2r0101 andLastIs: aLastCell thenDefineJunction: 2r0010 orIfExists: 2r1010 addConnection: 2r1000 mode: mode)
		ifTrue: [ ^ self ].	

	(self junctionFrom: down to: aCell ofType: #p if: 2r1010 andLastIs: aLastCell thenDefineJunction: 2r0100 orIfExists: 2r0101 addConnection: 2r0001 mode: mode)
		ifTrue: [ ^ self ].


	(self junctionFrom: left to: aCell ofType: #n if: 2r0101 andLastIs: aLastCell thenDefineJunction: 2r1000 orIfExists: 2r1010 addConnection: 2r0010 mode: mode)
		ifTrue: [ ^ self ].	

	(self junctionFrom: top to: aCell ofType: #n if: 2r1010 andLastIs: aLastCell thenDefineJunction: 2r0001 orIfExists: 2r0101 addConnection: 2r0100 mode: mode)
		ifTrue: [ ^ self ].	

	(self junctionFrom: right to: aCell ofType: #n if: 2r0101 andLastIs: aLastCell thenDefineJunction: 2r0010 orIfExists: 2r1010 addConnection: 2r1000 mode: mode)
		ifTrue: [ ^ self ].	

	(self junctionFrom: down to: aCell ofType: #n if: 2r1010 andLastIs: aLastCell thenDefineJunction: 2r0100 orIfExists: 2r0101 addConnection: 2r0001 mode: mode)
		ifTrue: [ ^ self ].

	aCell hasJunction ifTrue: [ ^ self ].

	(aCell substrateType notNil and: [aCell substrateType ~~ mode]) ifTrue: [ ^ self ].

	super setFor: aCell with: aLastCell mode: mode.
	
	area updateCell: aCell mode: mode
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> setRegionOf: aCell to: aRegion [

	^ aCell substrateRegion: aRegion
]
