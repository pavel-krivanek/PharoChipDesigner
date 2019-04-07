Class {
	#name : #ChDLayer,
	#superclass : #Object,
	#instVars : [
		'area'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDLayer >> addAllConnectedCellsOf: aCell to: aCollection [

	(aCollection includes: aCell) ifTrue: [ ^ self ].
	
	aCollection add: aCell.
	
	(self connectedNeighboursOf: aCell) do: [ :each |
		self addAllConnectedCellsOf: each to: aCollection ]
]

{ #category : #accessing }
ChDLayer >> area [
	^ area
]

{ #category : #accessing }
ChDLayer >> area: anObject [
	area := anObject
]

{ #category : #accessing }
ChDLayer >> clear: aCell withOld: oldConnections [

	"self setFor: aCell mode: nil."

	oldConnections ifNil: [ ^ self ].
	(oldConnections bitAnd: 2r0001) > 0 ifTrue: [ 
		self connectionsFor: aCell up delete: 2r0100 ].
	(oldConnections bitAnd: 2r0010) > 0 ifTrue: [ 
		self connectionsFor: aCell right delete: 2r1000 ].
	(oldConnections bitAnd: 2r0100) > 0 ifTrue: [ 
		self connectionsFor: aCell down delete: 2r0001 ].
	(oldConnections bitAnd: 2r1000) > 0 ifTrue: [ 
		self connectionsFor: aCell left delete: 2r0010 ].
	
"
	area updateCell: aCell mode: mode.. 

"	
]

{ #category : #accessing }
ChDLayer >> connectedNeighboursOf: aCell [

	self subclassResponsibility
]

{ #category : #accessing }
ChDLayer >> isMetal [

	^ false
]

{ #category : #accessing }
ChDLayer >> isSubstrate [

	^ false
]

{ #category : #accessing }
ChDLayer >> setFor: aCell with: aLastCell mode: mode [

	| left right top down |
	self setFor: aCell mode: mode.
	
	left := self area leftX: aCell x y: aCell y.
	right := self area rightX: aCell x y: aCell y.
	top := self area topX: aCell x y: aCell y.
	down := self area downX: aCell x y: aCell y.

	aLastCell ifNotNil: [ 
		(top = aLastCell) 
			ifTrue: [ 
				(self mode: mode compatibleWith: aLastCell) ifTrue: [ 
					self connectionsFor: aCell add: 2r0001.
					self connectionsFor: aLastCell add: 2r0100 ] ].
		(right = aLastCell) 
			ifTrue: [ 
				(self mode: mode compatibleWith: aLastCell) ifTrue: [ 
					self connectionsFor: aCell add: 2r0010.
					self connectionsFor: aLastCell add: 2r1000 ] ].
		(down = aLastCell) 
			ifTrue: [ 
				(self mode: mode compatibleWith: aLastCell) ifTrue: [ 
					self connectionsFor: aCell add: 2r0100.
					self connectionsFor: aLastCell add: 2r0001 ] ].
		(left = aLastCell) 
			ifTrue: [ 
				(self mode: mode compatibleWith: aLastCell) ifTrue: [ 
					self connectionsFor: aCell add: 2r1000.
					self connectionsFor: aLastCell add: 2r0010 ] ].
	].

	area updateCell: aCell mode: mode.. 

	
]
