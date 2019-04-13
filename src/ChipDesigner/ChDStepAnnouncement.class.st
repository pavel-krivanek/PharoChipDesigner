Class {
	#name : #ChDStepAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'simulation',
		'time'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDStepAnnouncement >> simulation [
	^ simulation
]

{ #category : #accessing }
ChDStepAnnouncement >> simulation: anObject [
	simulation := anObject
]

{ #category : #accessing }
ChDStepAnnouncement >> time [
	^ time
]

{ #category : #accessing }
ChDStepAnnouncement >> time: anObject [
	time := anObject
]
