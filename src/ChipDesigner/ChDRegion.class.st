Class {
	#name : #ChDRegion,
	#superclass : #Object,
	#instVars : [
		'currentState',
		'futureState',
		'cells',
		'layer',
		'hasVcc'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDRegion >> area [ 

	^ self layer area
]

{ #category : #accessing }
ChDRegion >> cells [
	^ cells
]

{ #category : #accessing }
ChDRegion >> cells: anObject [
	cells := anObject
]

{ #category : #accessing }
ChDRegion >> currentState [
	^ currentState
]

{ #category : #accessing }
ChDRegion >> currentState: anObject [

	currentState := anObject
]

{ #category : #accessing }
ChDRegion >> futureState [
	^ futureState
]

{ #category : #accessing }
ChDRegion >> futureState: anObject [

	futureState := anObject
]

{ #category : #accessing }
ChDRegion >> gtInspectorMorphIn: aComposite [
	<gtInspectorPresentationOrder: 0>
	
	| regionCells otherCells |
	
	regionCells := (self cells collect: [ :aCell | aCell x @ aCell y ]) asArray.
	otherCells := OrderedCollection new.
	1 to: self layer area width do: [ :x |
		1 to: self layer area height do: [ :y |
			| point |
			point := x@y.
			(regionCells includes: point) 
				ifFalse: [ otherCells add: point ]
			 ] ].
	
	aComposite morph 
		title: 'Morph';
		display: [(ChDAreaMorph for: self layer area)
			suppressedCells: otherCells ]

]

{ #category : #accessing }
ChDRegion >> hasVcc [
	^ hasVcc
]

{ #category : #accessing }
ChDRegion >> hasVcc: anObject [
	hasVcc := anObject
]

{ #category : #accessing }
ChDRegion >> hi [
	^ self hasVcc
]

{ #category : #accessing }
ChDRegion >> initialize [ 

	super initialize.
	
	currentState := false.
	futureState := false.
	hasVcc := false.
	
	cells := IdentitySet new.
	
]

{ #category : #accessing }
ChDRegion >> isCompact [

	^ false
]

{ #category : #accessing }
ChDRegion >> isJunction [

	^ false
]

{ #category : #accessing }
ChDRegion >> isSpecial [

	^ false
]

{ #category : #accessing }
ChDRegion >> layer [
	^ layer
]

{ #category : #accessing }
ChDRegion >> layer: anObject [
	layer := anObject
]

{ #category : #accessing }
ChDRegion >> low [
	^ self hasVcc not
]

{ #category : #accessing }
ChDRegion >> open [ 

	^ false
]

{ #category : #accessing }
ChDRegion >> printOn: aStream [

	super printOn: aStream.
	aStream 
		nextPutAll: '('.
	(layer ifNotNil: [ :aLayer | aLayer name ] ifNil: ['-']) printOn: aStream.
	aStream space.
	currentState printOn: aStream.
	aStream nextPutAll: '->'.
	futureState printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
ChDRegion >> splitted [

	| remainingCells newCells newCellRegions newRegions |
	remainingCells := cells copy.
	
	newCellRegions := OrderedCollection new.
	newRegions := OrderedCollection new.
	
	[ remainingCells isEmpty ] whileFalse: [ 
		newCells := IdentitySet new.
		layer addAllConnectedCellsOf: remainingCells anyOne to: newCells.
		newCellRegions add: newCells.
		remainingCells := remainingCells copyWithoutAll: newCells ].
	
	newCellRegions ifNotEmpty: [
		self cells: newCellRegions first asIdentitySet.
		newCellRegions first do: [ :each | layer setRegionOf: each to: self ].
		newRegions add: self.
		newCellRegions allButFirstDo: [ :aCellRegion |
			| newRegion |
			newRegion := ChDRegion new.
			newRegion layer: layer.
			newRegion cells: aCellRegion asIdentitySet.
			aCellRegion do: [ :each | layer setRegionOf: each to: newRegion ].
			newRegions add: newRegion ] ].
		
	^ newRegions

	
]
