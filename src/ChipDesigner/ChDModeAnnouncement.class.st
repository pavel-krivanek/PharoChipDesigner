Class {
	#name : #ChDModeAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'controller',
		'inputMode',
		'viaMode',
		'deleteMode'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDModeAnnouncement >> controller [
	^ controller
]

{ #category : #accessing }
ChDModeAnnouncement >> controller: anObject [
	controller := anObject
]

{ #category : #accessing }
ChDModeAnnouncement >> deleteMode [
	^ deleteMode
]

{ #category : #accessing }
ChDModeAnnouncement >> deleteMode: anObject [
	deleteMode := anObject
]

{ #category : #accessing }
ChDModeAnnouncement >> inputMode [
	^ inputMode
]

{ #category : #accessing }
ChDModeAnnouncement >> inputMode: anObject [
	inputMode := anObject
]

{ #category : #accessing }
ChDModeAnnouncement >> viaMode [
	^ viaMode
]

{ #category : #accessing }
ChDModeAnnouncement >> viaMode: anObject [
	viaMode := anObject
]
