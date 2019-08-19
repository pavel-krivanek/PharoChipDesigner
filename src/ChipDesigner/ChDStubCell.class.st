"
I am a ""virtual"" cell that lies outside of the area. I am not supposed to store real state and I am created as a new for every access. I simplify operations at edges of the area.
"
Class {
	#name : #ChDStubCell,
	#superclass : #ChDCell,
	#category : #ChipDesigner
}

{ #category : #testing }
ChDStubCell >> isStub [

	^ true
]
