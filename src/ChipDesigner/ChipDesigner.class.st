Class {
	#name : #ChipDesigner,
	#superclass : #ComposablePresenter,
	#instVars : [
		'list',
		'editor',
		'scopes',
		'area'
	],
	#category : #ChipDesigner
}

{ #category : #examples }
ChipDesigner class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecPanedLayout newHorizontal
				position: 200;
				add: #list;
				add: (SpecPanedLayout newVertical
					position: 400;
					add: #editor;
					add: #scopes;
					yourself));
		yourself
]

{ #category : #examples }
ChipDesigner class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #initialization }
ChipDesigner >> editorMorph [

	| editorMorph |
	
	editorMorph := ChipDesignerMorph newColumn.
	editorMorph color: (Color r: 0.506 g: 0.506 b: 0.506 alpha: 1.0).
	editorMorph addMorphBack: (ChDAreaMorph for: area).

	^ editorMorph
]

{ #category : #initialization }
ChipDesigner >> initialExtent [
	^ 800@600
]

{ #category : #initialization }
ChipDesigner >> initialize [ 

	area := ChDArea extent: 45@30.

	super initialize.
	
	
]

{ #category : #initialization }
ChipDesigner >> initializeWidgets [

	list := self newList.
	editor := self editorMorph asSpecAdapter.
	scopes := self sequenceMorph asSpecAdapter.
	
]

{ #category : #initialization }
ChipDesigner >> sequenceMorph [

	| sequenceMorph |
	
	sequenceMorph := ChDSequenceMorph input.
	sequenceMorph name: 'input'.
	
	^ sequenceMorph
]

{ #category : #initialization }
ChipDesigner >> title [
	
	^ 'Pharo Chip Designer'.
]
