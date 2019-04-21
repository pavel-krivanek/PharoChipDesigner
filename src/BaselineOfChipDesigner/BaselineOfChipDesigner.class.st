Class {
	#name : #BaselineOfChipDesigner,
	#superclass : #BaselineOf,
	#category : #BaselineOfChipDesigner
}

{ #category : #baselines }
BaselineOfChipDesigner >> baseline: spec [
	<baseline>

	spec for: #common do: [
		self spec: spec.
		spec 
			package: 'ChipDesigner' ]
]

{ #category : #baselines }
BaselineOfChipDesigner >> spec: spec [

	spec baseline: 'Spec' with: [ spec repository: 'github://pharo-spec/Spec/src' ]
]
