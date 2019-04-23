Class {
	#name : #ChDContextMenuAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'controller'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDContextMenuAnnouncement >> controller [
	^ controller
]

{ #category : #accessing }
ChDContextMenuAnnouncement >> controller: anObject [
	controller := anObject
]
