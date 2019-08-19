"
I am a region with a PNP or NPN junction
"
Class {
	#name : #ChDJunctionRegion,
	#superclass : #ChDRegion,
	#instVars : [
		'open',
		'vccRegion',
		'compactUp',
		'compactDown',
		'compactLeft',
		'compactRight'
	],
	#category : #ChipDesigner
}

{ #category : #'as yet unclassified' }
ChDJunctionRegion >> cell [

	^ cells anyOne
]

{ #category : #accessing }
ChDJunctionRegion >> compactDown [
	^ compactDown
]

{ #category : #accessing }
ChDJunctionRegion >> compactDown: anObject [
	^ compactDown := anObject
]

{ #category : #accessing }
ChDJunctionRegion >> compactLeft [
	^ compactLeft
]

{ #category : #accessing }
ChDJunctionRegion >> compactLeft: anObject [
	^ compactLeft := anObject
]

{ #category : #accessing }
ChDJunctionRegion >> compactRight [
	^ compactRight
]

{ #category : #accessing }
ChDJunctionRegion >> compactRight: anObject [
	^ compactRight := anObject
]

{ #category : #accessing }
ChDJunctionRegion >> compactUp [
	^ compactUp
]

{ #category : #accessing }
ChDJunctionRegion >> compactUp: anObject [
	compactUp := anObject
]

{ #category : #accessing }
ChDJunctionRegion >> initialize [

	super initialize.
	
	open := false.
	
	compactUp := compactDown := compactLeft := compactRight := nil.
]

{ #category : #accessing }
ChDJunctionRegion >> isJunction [

	^ true
]

{ #category : #accessing }
ChDJunctionRegion >> isSpecial [

	^ true
]

{ #category : #accessing }
ChDJunctionRegion >> open [
	^ open
]

{ #category : #accessing }
ChDJunctionRegion >> open: anObject [
	open := anObject
]

{ #category : #'as yet unclassified' }
ChDJunctionRegion >> updateCompactRegions [

	| aCell |
	
	aCell := self cell.
	
	aCell isVertical
		ifTrue: [ "vertical"
			aCell connectedInSubstrateUpOrNil ifNotNil: [ :up |
				up hasJunction ifTrue: [ 
					up substrateRegion compactDown ifNil: [ 
						compactUp := self area newCompactRegion.
						up substrateRegion compactDown: compactUp. ]
					ifNotNil: [ :aRegion | 
						compactUp := aRegion ] ] ].
			aCell connectedInSubstrateDownOrNil ifNotNil: [ :down |
				down hasJunction ifTrue: [ 
					down substrateRegion compactUp ifNil: [ 
						compactDown := self area newCompactRegion.
						down substrateRegion compactUp: compactUp. ]
					ifNotNil: [ :aRegion | 
						compactDown := aRegion ] ] ] ]
		ifFalse: [ "horizontal" 
			aCell connectedInSubstrateRightOrNil ifNotNil: [ :right |
				right hasJunction ifTrue: [ 
					right substrateRegion compactRight ifNil: [ 
						compactRight := self area newCompactRegion.
						right substrateRegion compactLeft: compactUp. ]
					ifNotNil: [ :aRegion | 
						compactRight := aRegion ] ] ].
			aCell connectedInSubstrateLeftOrNil ifNotNil: [ :left |
				left hasJunction ifTrue: [ 
					left substrateRegion compactLeft ifNil: [ 
						compactLeft := self area newCompactRegion.
						left substrateRegion compactRight: compactUp. ]
					ifNotNil: [ :aRegion | 
						compactLeft := aRegion ] ] ] ]
]

{ #category : #accessing }
ChDJunctionRegion >> vccRegion [
	^ vccRegion
]

{ #category : #accessing }
ChDJunctionRegion >> vccRegion: anObject [
	vccRegion := anObject
]
