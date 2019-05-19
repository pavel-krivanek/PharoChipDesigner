Class {
	#name : #ChDDirtyCellsAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'cells'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDDirtyCellsAnnouncement class >> cells: cells [

	^ self new 
		cells: cells;
		yourself.
]

{ #category : #accessing }
ChDDirtyCellsAnnouncement >> cells [
	^ cells
]

{ #category : #accessing }
ChDDirtyCellsAnnouncement >> cells: anObject [
	cells := anObject
]
