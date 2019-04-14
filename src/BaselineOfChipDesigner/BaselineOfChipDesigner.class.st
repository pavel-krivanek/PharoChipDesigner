Class {
	#name : #BaselineOfChipDesigner,
	#superclass : #BaselineOf,
	#category : #BaselineOfChipDesigner
}

{ #category : #baselines }
BaselineOfChipDesigner >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec 
			package: 'ChipDesigner' ]
]
