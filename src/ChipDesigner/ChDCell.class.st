"
I am a single cell of a surface area with a given coordinates.

I encode information about my connections to other cells in vertical and horizontal direction:
  0001 - up
  0010 - right
  0100 - down
  1000 - left

...and about cells in corners because this information is required for the cells rendering:
  0001 - right down
  0010 - right up
  0100 - left down
  1000 - left up

I keep references to adjacent cells in a topology object.
"
Class {
	#name : #ChDCell,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'substrateType',
		'substrateConnections',
		'metalConnections',
		'substrateCorners',
		'metalCorners',
		'via',
		'junctionType',
		'junctionConnections',
		'metalRegion',
		'substrateRegion',
		'topology'
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
	((junctionConnections bitAnd: 2r0001) > 0) ifTrue: [ result add: self topology up ].
	((junctionConnections bitAnd: 2r0010) > 0) ifTrue: [ result add: self topology right ].
	((junctionConnections bitAnd: 2r0100) > 0) ifTrue: [ result add: self topology down ].
	((junctionConnections bitAnd: 2r1000) > 0) ifTrue: [ result add: self topology left ].
	^ result.
]

{ #category : #accessing }
ChDCell >> connectedCellsInSubstrate [

	| result |
	
	result := IdentitySet new.
	self substrateType ifNil: [ ^ result ].
	((substrateConnections bitAnd: 2r0001) > 0) ifTrue: [ result add: self topology up ].
	((substrateConnections bitAnd: 2r0010) > 0) ifTrue: [ result add: self topology right ].
	((substrateConnections bitAnd: 2r0100) > 0) ifTrue: [ result add: self topology down ].
	((substrateConnections bitAnd: 2r1000) > 0) ifTrue: [ result add: self topology left ].
	^ result.
]

{ #category : #accessing }
ChDCell >> connectedCellsInSubstrateWithoutBaseConnections [

	| result |
	
	result := IdentitySet new.
	self substrateType ifNil: [ ^ result ].
	(((substrateConnections bitAnd: 2r0001) > 0) and: [ (((self topology up junctionConnections ifNil: [ 0 ]) bitAnd: 2r0100) > 0 ) not]) 
		ifTrue: [ result add: self topology up ].
	(((substrateConnections bitAnd: 2r0010) > 0) and: [ (((self topology right junctionConnections ifNil: [ 0 ]) bitAnd: 2r1000) > 0 ) not]) 
		ifTrue: [ result add: self topology right ].
	(((substrateConnections bitAnd: 2r0100) > 0) and: [ (((self topology down junctionConnections ifNil: [ 0 ]) bitAnd: 2r0001) > 0 ) not]) 
		ifTrue: [ result add: self topology down ].
	(((substrateConnections bitAnd: 2r1000) > 0) and: [ (((self topology left junctionConnections ifNil: [ 0 ]) bitAnd: 2r0010) > 0 ) not]) 
		ifTrue: [ result add: self topology left ].
	^ result.
]

{ #category : #accessing }
ChDCell >> connectedInSubstrateDownOrNil [

	self substrateType ifNil: [ ^ nil ].
	^ ((substrateConnections bitAnd: 2r0100) > 0) 
		ifTrue: [ self topology down ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
ChDCell >> connectedInSubstrateLeftOrNil [

	self substrateType ifNil: [ ^ nil ].
	^ ((substrateConnections bitAnd: 2r1000) > 0) 
		ifTrue: [ self topology left ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
ChDCell >> connectedInSubstrateRightOrNil [

	self substrateType ifNil: [ ^ nil ].
	^ ((substrateConnections bitAnd: 2r0010) > 0) 
		ifTrue: [ self topology right ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
ChDCell >> connectedInSubstrateUpOrNil [

	self substrateType ifNil: [ ^ nil ].
	^ ((substrateConnections bitAnd: 2r0001) > 0) 
		ifTrue: [ self topology up ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
ChDCell >> connectedRegionsInJunction [

	^ self connectedCellsInJunction collect: [ :each | each substrateRegion ] as: IdentitySet.
]

{ #category : #accessing }
ChDCell >> connectedRegionsInSubstrate [

	| result |
	
	self hasJunction ifFalse: [ 
		^ self connectedCellsInSubstrate collect: [ :each | each substrateRegion ] as: IdentitySet ].
	
	result := IdentitySet new.
		
	self isVertical 
		ifTrue: [ 
			result add: (self substrateRegion compactUp 
				ifNotNil: [ :aRegion | aRegion ]
				ifNil: [ self topology up substrateRegion ]).
			result add: (self substrateRegion compactDown
				ifNotNil: [ :aRegion | aRegion ]
				ifNil: [ self topology down substrateRegion ]) ]
		ifFalse: [ 
			result add: (self substrateRegion compactRight 
				ifNotNil: [ :aRegion | aRegion ]
				ifNil: [ self topology right substrateRegion ]).
			result add: (self substrateRegion compactLeft
				ifNotNil: [ :aRegion | aRegion ]
				ifNil: [ self topology left substrateRegion ]) ].
			
		^ result

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
ChDCell >> disconnect: aMask [

	self metalConnections ifNotNil: [ 
		self metalConnections: (self safeMetalConnections bitAnd: aMask bitInvert32) ].
	
	self substrateConnections ifNotNil: [ 
		self substrateConnections: (self safeSubstrateConnections bitAnd: aMask bitInvert32) ].
	
	(self substrateRegion notNil and: [self substrateRegion isJunction]) ifTrue: [ 
		| adjacentCell |
		adjacentCell := nil.
		aMask = 2r0001 ifTrue: [ adjacentCell := self topology up ].
		aMask = 2r0010 ifTrue: [ adjacentCell := self topology right ].
		aMask = 2r0100 ifTrue: [ adjacentCell := self topology down ].
		aMask = 2r1000 ifTrue: [ adjacentCell := self topology left ].
		adjacentCell ifNotNil: [ 
			self substrateRegion layer clearJunctionIn: self whenDelete: adjacentCell ]]

	
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
	
	topology := ChDCellTopology for: self.
	
	via := false.
	substrateConnections := 0.
	
	substrateCorners := 0.
	metalCorners := 0.
	
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
ChDCell >> isHorizontal [

	^ (self junctionConnections bitAnd: 2r0101) > 0 
]

{ #category : #testing }
ChDCell >> isStub [

	^ false
]

{ #category : #accessing }
ChDCell >> isVertical [

	^ (self junctionConnections bitAnd: 2r1010) > 0 
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
ChDCell >> metalConnections [
	^ metalConnections
]

{ #category : #accessing }
ChDCell >> metalConnections: anObject [
	
	metalConnections := anObject.
	
	self updateMetalCorners
]

{ #category : #accessing }
ChDCell >> metalCorners [
	^ metalCorners
]

{ #category : #accessing }
ChDCell >> metalCorners: anObject [
	metalCorners := anObject
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
ChDCell >> safeMetalConnections [
	^ metalConnections ifNil: [ 0 ]
]

{ #category : #accessing }
ChDCell >> safeSubstrateConnections [
	^ substrateConnections ifNil: [ 0 ]
]

{ #category : #accessing }
ChDCell >> substrateConnections [
	^ substrateConnections
]

{ #category : #accessing }
ChDCell >> substrateConnections: anObject [

	substrateConnections := anObject.
	
	self updateSubstrateCorners.
]

{ #category : #accessing }
ChDCell >> substrateCorners [
	^ substrateCorners
]

{ #category : #accessing }
ChDCell >> substrateCorners: anObject [
	substrateCorners := anObject
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
ChDCell >> topology [
	^ topology
]

{ #category : #accessing }
ChDCell >> topology: anObject [
	topology := anObject
]

{ #category : #accessing }
ChDCell >> unsetAdjacentMetalCorners [

	self topology leftUp unsetMetalCorners: 2r1000.
	self topology rightUp unsetMetalCorners: 2r0100.
	self topology leftDown unsetMetalCorners: 2r0010.
	self topology rightDown unsetMetalCorners: 2r0001.
	
]

{ #category : #accessing }
ChDCell >> unsetAdjacentSubstrateCorners [

	self topology leftUp unsetSubstrateCorners: 2r1000.
	self topology rightUp unsetSubstrateCorners: 2r0100.
	self topology leftDown unsetSubstrateCorners: 2r0010.
	self topology rightDown unsetSubstrateCorners: 2r0001.
	
]

{ #category : #accessing }
ChDCell >> unsetMetalCorners: cornersMap [

	metalCorners := cornersMap bitInvert32 bitAnd: metalCorners
]

{ #category : #accessing }
ChDCell >> unsetSubstrateCorners: cornersMap [

	substrateCorners := cornersMap bitInvert32 bitAnd: substrateCorners
]

{ #category : #accessing }
ChDCell >> updateMetalCorners [

	metalCorners := 0.	
	self hasMetal ifFalse: [ ^ self ].
	
	self topology leftUp hasMetal ifTrue: [ 
	(((self topology leftUp metalConnections bitAnd: 2r0110) = 2r0110) 
		and: [ (metalConnections bitAnd: 2r1001) = 2r1001]) 
			ifTrue: [ 
				metalCorners := metalCorners bitOr: 2r0001.
				self topology leftUp updateMetalCorners: 2r1000 ] ].

	self topology rightUp hasMetal ifTrue: [ 
	(((self topology rightUp metalConnections bitAnd: 2r1100) = 2r1100) 
		and: [ (metalConnections bitAnd: 2r0011) = 2r0011]) 
			ifTrue: [ 
				metalCorners := metalCorners bitOr: 2r0010.
				self topology rightUp updateMetalCorners: 2r0100  ]].

	self topology leftDown hasMetal ifTrue: [ 
	(((self topology leftDown metalConnections bitAnd: 2r0011) = 2r0011) 
		and: [ (metalConnections bitAnd: 2r1100) = 2r1100]) 
			ifTrue: [ 
				metalCorners := metalCorners bitOr: 2r0100.
				self topology leftDown updateMetalCorners: 2r0010  ]].

	self topology rightDown hasMetal ifTrue: [ 
	(((self topology rightDown metalConnections bitAnd: 2r1001) = 2r1001) 
		and: [ (metalConnections bitAnd: 2r0110) = 2r0110]) 
			ifTrue: [ 
				metalCorners := metalCorners bitOr: 2r1000.
				self topology rightDown updateMetalCorners: 2r0001  ]].
	
]

{ #category : #accessing }
ChDCell >> updateMetalCorners: cornersMap [

	metalCorners := metalCorners bitOr: cornersMap.
]

{ #category : #accessing }
ChDCell >> updateSubstrateCorners [
	
	substrateCorners := 0.	
	self hasSubstrate ifFalse: [ ^ self ].
	
	self topology leftUp hasSubstrate ifTrue: [ 
	(((self topology leftUp substrateConnections bitAnd: 2r0110) = 2r0110) 
		and: [ (substrateConnections bitAnd: 2r1001) = 2r1001]) 
			ifTrue: [ 
				substrateCorners := substrateCorners bitOr: 2r0001.
				self topology leftUp updateSubstrateCorners: 2r1000 ] ].

	self topology rightUp hasSubstrate ifTrue: [ 
	(((self topology rightUp substrateConnections bitAnd: 2r1100) = 2r1100) 
		and: [ (substrateConnections bitAnd: 2r0011) = 2r0011]) 
			ifTrue: [ 
				substrateCorners := substrateCorners bitOr: 2r0010.
				self topology rightUp updateSubstrateCorners: 2r0100  ]].

	self topology leftDown hasSubstrate ifTrue: [ 
	(((self topology leftDown substrateConnections bitAnd: 2r0011) = 2r0011) 
		and: [ (substrateConnections bitAnd: 2r1100) = 2r1100]) 
			ifTrue: [ 
				substrateCorners := substrateCorners bitOr: 2r0100.
				self topology leftDown updateSubstrateCorners: 2r0010  ]].

	self topology rightDown hasSubstrate ifTrue: [ 
	(((self topology rightDown substrateConnections bitAnd: 2r1001) = 2r1001) 
		and: [ (substrateConnections bitAnd: 2r0110) = 2r0110]) 
			ifTrue: [ 
				substrateCorners := substrateCorners bitOr: 2r1000.
				self topology rightDown updateSubstrateCorners: 2r0001  ]].
]

{ #category : #accessing }
ChDCell >> updateSubstrateCorners: cornersMap [

	substrateCorners := substrateCorners bitOr: cornersMap.
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
ChDCell >> withAdjacentCells [

	^ { self. 
	self topology up.
	self topology rightUp.
	self topology right.
	self topology rightDown.
	self topology down.
	self topology leftDown.
	self topology left.
	self topology leftUp.
 } reject: #isStub

]

{ #category : #accessing }
ChDCell >> withMetalRegionDo: aBlock [

	metalRegion ifNil: [ ^ self ].
	
	aBlock cull: metalRegion.
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
