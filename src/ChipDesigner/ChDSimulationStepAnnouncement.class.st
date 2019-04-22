Class {
	#name : #ChDSimulationStepAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'simulation',
		'time'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDSimulationStepAnnouncement >> simulation [
	^ simulation
]

{ #category : #accessing }
ChDSimulationStepAnnouncement >> simulation: anObject [
	simulation := anObject
]

{ #category : #accessing }
ChDSimulationStepAnnouncement >> time [
	^ time
]

{ #category : #accessing }
ChDSimulationStepAnnouncement >> time: anObject [
	time := anObject
]
