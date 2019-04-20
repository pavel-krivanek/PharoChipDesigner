Class {
	#name : #ChDSubstrateLayer,
	#superclass : #ChDLayer,
	#category : #ChipDesigner
}

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> connectedNeighboursOf: aCell [

	| result |
	
	result := OrderedCollection new.
	(((aCell substrateConnections bitAnd: 2r0001) > 0) and: [ aCell up hasJunction not ]) ifTrue: [ result add: aCell up ].
	(((aCell substrateConnections bitAnd: 2r0010) > 0) and: [ aCell right hasJunction not ]) ifTrue: [ result add: aCell right ].
	(((aCell substrateConnections bitAnd: 2r0100) > 0) and: [ aCell down hasJunction not ]) ifTrue: [ result add: aCell down ].
	(((aCell substrateConnections bitAnd: 2r1000) > 0) and: [ aCell left hasJunction not ]) ifTrue: [ result add: aCell left ].
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
	
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> fullClear: aCell [

	| oldConnections |
	
	oldConnections := aCell substrateConnections.
	aCell hasJunction ifTrue: [ 
		oldConnections := oldConnections bitOr: aCell junctionConnections ].

	aCell substrateType: nil.
	aCell substrateConnections: nil.
	aCell junctionType: nil.
	aCell junctionConnections: nil.
	aCell clearVia.
	aCell unsetAdjacentSubstrateCorners.
	
	self clear: aCell withOld: oldConnections
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
	
	aCell junctionType ifNotNil: [ ^ self ].
	
	left := self area leftX: aCell x y: aCell y.
	right := self area rightX: aCell x y: aCell y.
	top := self area topX: aCell x y: aCell y.
	down := self area downX: aCell x y: aCell y.

	((((left = aLastCell) and: [ left substrateType = #p ]) 
		and: [ aCell substrateType = #n ]) 
		and: [ aCell substrateConnections = 2r0101 ])
		ifTrue: [ | newRegions |
			aCell junctionType: #npn.
			aCell junctionConnections: 2r1000.
			self connectionsFor: aLastCell add: 2r0010. 
			self createJunctionRegionIn: aCell.			
			^ self ].		

	((((top = aLastCell) and: [ top substrateType = #p ]) 
		and: [ aCell substrateType = #n ]) 
		and: [ aCell substrateConnections = 2r1010 ])
		ifTrue: [
			aCell junctionType: #npn.
			aCell junctionConnections: 2r0001.
			self connectionsFor: aLastCell add: 2r0100. 
			self createJunctionRegionIn: aCell.			
			^ self ].	

	((((right = aLastCell) and: [ right substrateType = #p ]) 
		and: [ aCell substrateType = #n ]) 
		and: [ aCell substrateConnections = 2r0101 ])
		ifTrue: [
			aCell junctionType: #npn.
			aCell junctionConnections: 2r0010.
			self connectionsFor: aLastCell add: 2r1000. 
			self createJunctionRegionIn: aCell.			
			^ self ].	

	((((down = aLastCell) and: [ down substrateType = #p ]) 
		and: [ aCell substrateType = #n ]) 
		and: [ aCell substrateConnections = 2r1010 ])
		ifTrue: [
			aCell junctionType: #npn.
			aCell junctionConnections: 2r0100.
			self connectionsFor: aLastCell add: 2r0001. 
			self createJunctionRegionIn: aCell.			
			^ self ].	


	((((left = aLastCell) and: [ left substrateType = #n ]) 
		and: [ aCell substrateType = #p ]) 
		and: [ aCell substrateConnections = 2r0101 ])
		ifTrue: [
			aCell junctionType: #pnp.
			aCell junctionConnections: 2r1000.
			self connectionsFor: aLastCell add: 2r0010. 
			self createJunctionRegionIn: aCell.			
			^ self ].		

	((((top = aLastCell) and: [ top substrateType = #n ]) 
		and: [ aCell substrateType = #p ]) 
		and: [ aCell substrateConnections = 2r1010 ])
		ifTrue: [
			aCell junctionType: #pnp.
			aCell junctionConnections: 2r0001.
			self connectionsFor: aLastCell add: 2r0100. 
			self createJunctionRegionIn: aCell.			
			^ self ].	

	((((right = aLastCell) and: [ right substrateType = #n ]) 
		and: [ aCell substrateType = #p ]) 
		and: [ aCell substrateConnections = 2r0101 ])
		ifTrue: [
			aCell junctionType: #pnp.
			aCell junctionConnections: 2r0010.
			self connectionsFor: aLastCell add: 2r1000. 
			self createJunctionRegionIn: aCell.			
			^ self ].	

	((((down = aLastCell) and: [ down substrateType = #n ]) 
		and: [ aCell substrateType = #p ]) 
		and: [ aCell substrateConnections = 2r1010 ])
		ifTrue: [
			aCell junctionType: #pnp.
			aCell junctionConnections: 2r0100.
			self connectionsFor: aLastCell add: 2r0001. 
			self createJunctionRegionIn: aCell.			
			^ self ].	

	(aCell substrateType notNil and: [aCell substrateType ~~ mode]) ifTrue: [ ^ self ].

	super setFor: aCell with: aLastCell mode: mode.
	
	area updateCell: aCell mode: mode
]

{ #category : #'as yet unclassified' }
ChDSubstrateLayer >> setRegionOf: aCell to: aRegion [

	^ aCell substrateRegion: aRegion
]
