Class {
	#name : #ChDCell,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'substrateType',
		'substrateConnections',
		'metalConnections',
		'via',
		'junctionType',
		'junctionConnections',
		'metalRegion',
		'substrateRegion',
		'left',
		'right',
		'up',
		'down'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDCell >> clearVia [

	via := false.
]

{ #category : #accessing }
ChDCell >> connectedCellsInJunction [

	| result |
	
	result := IdentitySet new.
	self junctionType ifNil: [ ^ result ].
	((junctionConnections bitAnd: 2r0001) > 0) ifTrue: [ result add: self up ].
	((junctionConnections bitAnd: 2r0010) > 0) ifTrue: [ result add: self right ].
	((junctionConnections bitAnd: 2r0100) > 0) ifTrue: [ result add: self down ].
	((junctionConnections bitAnd: 2r1000) > 0) ifTrue: [ result add: self left ].
	^ result.
]

{ #category : #accessing }
ChDCell >> connectedCellsInSubstrate [

	| result |
	
	result := IdentitySet new.
	self substrateType ifNil: [ ^ result ].
	((substrateConnections bitAnd: 2r0001) > 0) ifTrue: [ result add: self up ].
	((substrateConnections bitAnd: 2r0010) > 0) ifTrue: [ result add: self right ].
	((substrateConnections bitAnd: 2r0100) > 0) ifTrue: [ result add: self down ].
	((substrateConnections bitAnd: 2r1000) > 0) ifTrue: [ result add: self left ].
	^ result.
]

{ #category : #accessing }
ChDCell >> connectedRegionsInJunction [

	^ self connectedCellsInJunction collect: [ :each | each substrateRegion ] as: IdentitySet.
]

{ #category : #accessing }
ChDCell >> connectedRegionsInSubstrate [

	^ self connectedCellsInSubstrate collect: [ :each | each substrateRegion ] as: IdentitySet.
]

{ #category : #accessing }
ChDCell >> decodeFrom: aString [

	| int hasMetal index |

	int := ('16r', aString) asNumber.
	
	self via: ((int bitShiftMagnitude: -18) bitAnd: 2r1) > 0.
	hasMetal := ((int bitShiftMagnitude: -17) bitAnd: 2r1) > 0.
	 metalConnections := hasMetal
		ifTrue: [ (int bitShiftMagnitude: -5) bitAnd: 2r1111 ]
		ifFalse: [ nil ].
	index := ((int bitShiftMagnitude: -15) bitAnd: 2r11) + 1.
	junctionType := #(nil #pnp #npn) at: index.
	index := ((int bitShiftMagnitude: -13) bitAnd: 2r11) + 1.
	substrateType := #(nil #p #n) at: index.
	junctionConnections := (int bitShiftMagnitude: -9) bitAnd: 2r1111.
	substrateConnections := (int bitShiftMagnitude: -1) bitAnd: 2r1111. 
	
 	^ self
]

{ #category : #accessing }
ChDCell >> down [
	^ down
]

{ #category : #accessing }
ChDCell >> down: anObject [
	down := anObject
]

{ #category : #accessing }
ChDCell >> encoded [

	| int |
	
	int := 1. "not empty"
	int := int bitOr: ((substrateConnections ifNil: [ 0 ]) bitShift: 1).
	int := int bitOr: ((metalConnections ifNil: [ 0 ]) bitShift: 5).
	int := int bitOr: ((junctionConnections ifNil: [ 0 ]) bitShift: 9).
	int := int bitOr: ((#(nil #p #n) indexOf: substrateType)-1 bitShift: 13).
	int := int bitOr: ((#(nil #pnp #npn) indexOf: junctionType)-1 bitShift: 15).
	int := int bitOr: ((self hasMetal ifTrue: [ 1 ] ifFalse: [ 0 ]) bitShift: 17).
	int := int bitOr: ((via ifTrue: [ 1 ] ifFalse: [ 0 ]) bitShift: 18).
		
	^ int printPaddedWith: $0 to: 5 base: 16

]

{ #category : #accessing }
ChDCell >> hasJunction [

	^ junctionType notNil
]

{ #category : #accessing }
ChDCell >> hasMetal [

	^ self metalConnections notNil
]

{ #category : #accessing }
ChDCell >> hasSubstrate [

	^ self substrateType notNil
]

{ #category : #accessing }
ChDCell >> hasVia [

	via isNil ifTrue: [ ^ false ].
	^ via 
]

{ #category : #accessing }
ChDCell >> initialize [

	super initialize.
	
	via := false.
	substrateConnections := 0.
	
	metalRegion := nil.
	substrateRegion := nil.
]

{ #category : #accessing }
ChDCell >> isEmpty [ 
	
	^ (self hasMetal | self hasSubstrate | self hasJunction) not

]

{ #category : #accessing }
ChDCell >> isHi [

	^ (self metalRegion notNil and: [self metalRegion currentState])
		or: [ self substrateRegion notNil and: [self substrateRegion currentState] ]
]

{ #category : #accessing }
ChDCell >> junctionConnections [
	^ junctionConnections
]

{ #category : #accessing }
ChDCell >> junctionConnections: anObject [
	junctionConnections := anObject
]

{ #category : #accessing }
ChDCell >> junctionType [
	^ junctionType
]

{ #category : #accessing }
ChDCell >> junctionType: anObject [
	junctionType := anObject
]

{ #category : #accessing }
ChDCell >> left [ 

	^ left
]

{ #category : #accessing }
ChDCell >> left: aCell [

	left := aCell
]

{ #category : #accessing }
ChDCell >> metalConnections [
	^ metalConnections
]

{ #category : #accessing }
ChDCell >> metalConnections: anObject [
	metalConnections := anObject
]

{ #category : #accessing }
ChDCell >> metalRegion [
	^ metalRegion
]

{ #category : #accessing }
ChDCell >> metalRegion: anObject [
	metalRegion := anObject
]

{ #category : #accessing }
ChDCell >> printOn: aStream [

	aStream 
		nextPutAll: self class name;
		nextPutAll: '('.
	x printOn: aStream.
	aStream nextPutAll: ', '.
	y printOn: aStream.
	aStream nextPutAll: ')'.
		
]

{ #category : #accessing }
ChDCell >> right [

	^ right
]

{ #category : #accessing }
ChDCell >> right: aCell [

	right := aCell
]

{ #category : #accessing }
ChDCell >> substrateConnections [
	^ substrateConnections
]

{ #category : #accessing }
ChDCell >> substrateConnections: anObject [
	substrateConnections := anObject
]

{ #category : #accessing }
ChDCell >> substrateRegion [
	^ substrateRegion
]

{ #category : #accessing }
ChDCell >> substrateRegion: anObject [
	substrateRegion := anObject
]

{ #category : #accessing }
ChDCell >> substrateType [
	^ substrateType
]

{ #category : #accessing }
ChDCell >> substrateType: anObject [
	substrateType := anObject
]

{ #category : #accessing }
ChDCell >> toggleVia [

	via ifTrue: [ 
		via := false. 
		^ self ].
	
	((self hasJunction not and: [ self hasSubstrate ]) and: [ self hasMetal ])
		ifTrue: [ via := true ].
	
]

{ #category : #accessing }
ChDCell >> up [
	^ up
]

{ #category : #accessing }
ChDCell >> up: anObject [
	up := anObject
]

{ #category : #accessing }
ChDCell >> via [
	^ via
]

{ #category : #accessing }
ChDCell >> via: anObject [
	via := anObject
]

{ #category : #accessing }
ChDCell >> x [
	^ x
]

{ #category : #accessing }
ChDCell >> x: anObject [
	x := anObject
]

{ #category : #accessing }
ChDCell >> y [
	^ y
]

{ #category : #accessing }
ChDCell >> y: anObject [
	y := anObject
]
