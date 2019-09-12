Class {
	#name : #ChDSimulationEvaluationAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'simulation',
		'passRatio'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDSimulationEvaluationAnnouncement >> passRatio [
	^ passRatio
]

{ #category : #accessing }
ChDSimulationEvaluationAnnouncement >> passRatio: anObject [
	passRatio := anObject
]

{ #category : #accessing }
ChDSimulationEvaluationAnnouncement >> simulation [
	^ simulation
]

{ #category : #accessing }
ChDSimulationEvaluationAnnouncement >> simulation: anObject [
	simulation := anObject
]
