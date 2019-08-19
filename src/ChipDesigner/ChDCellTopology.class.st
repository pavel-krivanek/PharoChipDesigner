"
I and a first-class object that keeps references to adjacent cells of a given cell.
"
Class {
	#name : #ChDCellTopology,
	#superclass : #Object,
	#instVars : [
		'cell',
		'left',
		'right',
		'up',
		'down',
		'leftUp',
		'rightUp',
		'leftDown',
		'rightDown'
	],
	#category : #ChipDesigner
}

{ #category : #'instance creation' }
ChDCellTopology class >> for: aCell [

	^ self new 
		cell: aCell;
		yourself
]

{ #category : #accessing }
ChDCellTopology >> cell [
	^ cell
]

{ #category : #accessing }
ChDCellTopology >> cell: anObject [
	cell := anObject
]

{ #category : #accessing }
ChDCellTopology >> down [
	^ down
]

{ #category : #accessing }
ChDCellTopology >> down: anObject [
	down := anObject
]

{ #category : #accessing }
ChDCellTopology >> left [
	^ left
]

{ #category : #accessing }
ChDCellTopology >> left: anObject [
	left := anObject
]

{ #category : #accessing }
ChDCellTopology >> leftDown [
	^ leftDown
]

{ #category : #accessing }
ChDCellTopology >> leftDown: anObject [
	leftDown := anObject
]

{ #category : #accessing }
ChDCellTopology >> leftUp [
	^ leftUp
]

{ #category : #accessing }
ChDCellTopology >> leftUp: anObject [
	leftUp := anObject
]

{ #category : #accessing }
ChDCellTopology >> right [
	^ right
]

{ #category : #accessing }
ChDCellTopology >> right: anObject [
	right := anObject
]

{ #category : #accessing }
ChDCellTopology >> rightDown [
	^ rightDown
]

{ #category : #accessing }
ChDCellTopology >> rightDown: anObject [
	rightDown := anObject
]

{ #category : #accessing }
ChDCellTopology >> rightUp [
	^ rightUp
]

{ #category : #accessing }
ChDCellTopology >> rightUp: anObject [
	rightUp := anObject
]

{ #category : #accessing }
ChDCellTopology >> up [
	^ up
]

{ #category : #accessing }
ChDCellTopology >> up: anObject [
	up := anObject
]
