Class {
	#name : #ChDSimulationRunAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'simulation',
		'running'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDSimulationRunAnnouncement >> running [
	^ running
]

{ #category : #accessing }
ChDSimulationRunAnnouncement >> running: anObject [
	running := anObject
]

{ #category : #accessing }
ChDSimulationRunAnnouncement >> simulation [
	^ simulation
]

{ #category : #accessing }
ChDSimulationRunAnnouncement >> simulation: anObject [
	simulation := anObject
]
