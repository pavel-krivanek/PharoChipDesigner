Class {
	#name : #ChipDesigner,
	#superclass : #ComposablePresenter,
	#instVars : [
		'list',
		'editor',
		'scopes',
		'area',
		'toolbar',
		'controller',
		'editModeButton',
		'editMode',
		'viaModeButton',
		'viaMode',
		'modeNormalForm',
		'modeShiftForm',
		'modeDeleteForm',
		'modeViaOn',
		'modeViaOff',
		'modeDeleteSiliconForm',
		'inspectButton',
		'notebook',
		'currentLevel'
	],
	#category : #ChipDesigner
}

{ #category : #examples }
ChipDesigner class >> buttonsDimension [

	^35
]

{ #category : #examples }
ChipDesigner class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecPanedLayout newHorizontal
				position: 200;
				add: #list;
				add: (
					SpecBoxLayout newVertical
					add: (SpecBoxLayout newHorizontal
							add: #editModeButton withConstraints: [ :constraints | constraints width: self buttonsDimension ];
							add: #viaModeButton withConstraints: [ :constraints | constraints width: self buttonsDimension ];
							add: #inspectButton withConstraints: [ :constraints | constraints width: self buttonsDimension ];
							
							yourself)
						withConstraints: [ :constraints | constraints height: self buttonsDimension ];
						add: (SpecPanedLayout newVertical
							position: 360;
							add: #editor;
							add: #notebook)));
		yourself
]

{ #category : #examples }
ChipDesigner class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #initialization }
ChipDesigner >> editModeIcon [

	^ (Dictionary newFrom: { 
		#delete -> modeDeleteForm.
		#deleteSilicon -> modeDeleteSiliconForm.
		#metal -> modeNormalForm.
		#shift -> modeShiftForm.	
	 }) at: editMode
]

{ #category : #initialization }
ChipDesigner >> editorMorph [

	| editorMorph |
	
	editorMorph := ChipDesignerMorph newColumn.
	editorMorph color: (Color r: 0.506 g: 0.506 b: 0.506 alpha: 1.0).
	editorMorph addMorphBack: (ChDAreaMorph for: area).
	
	controller := editorMorph submorphs first controller.
	controller announcer when: ChDModeAnnouncement do: [ :announcement |
		editMode := announcement controller deleteMode
			ifTrue: [ 
				(announcement controller inputMode = #metal)
					ifTrue: [ #delete ]
					ifFalse: [ #deleteSilicon ] ] 
			ifFalse: [ announcement controller inputMode ].
		viaMode := announcement controller viaMode. 
		editModeButton icon: self editModeIcon.
		viaModeButton icon: self viaModeIcon ].

	^ editorMorph
]

{ #category : #initialization }
ChipDesigner >> initialExtent [
	^ 840@720
]

{ #category : #initialization }
ChipDesigner >> initialize [ 

	area := ChDArea extent: 45@30.
	editMode := #metal.
	toolbar := self toolbar. 
	viaMode := false.

	currentLevel := ChipDesignerClassicLevel1 on: area.

	modeNormalForm := self modeIcon: (Rectangle origin: 0@0 extent: 27@14).
	modeShiftForm := self modeIcon: (Rectangle origin: 26@0 extent: 27@14).
	modeDeleteForm := self modeIcon: (Rectangle origin: 52@0 extent: 15@14).
	modeDeleteSiliconForm := self modeIcon: (Rectangle origin: 65@0 extent: 15@14).
	modeViaOn := self modeIcon: (Rectangle origin: 78@0 extent: 14@14).
	modeViaOff := self modeIcon: (Rectangle origin: 91@0 extent: 14@14).
		
	super initialize.
	
	
	
	
	
]

{ #category : #initialization }
ChipDesigner >> initializeWidgets [

	| editorMorph scopesPage |
	
	list := self newList.
	list items: #('KT411I - Quad intverter gate').
	
	editorMorph := self editorMorph.
	editor := editorMorph asSpecAdapter.
	scopes := self sequenceMorph asSpecAdapter.
	
	editModeButton := self newButton icon: self editModeIcon.
	editModeButton help: 'Drawing / delete mode <X>, extended <Shift>'.
	editModeButton action: [editorMorph submorphs first controller swapDeleteMode].

	viaModeButton := self newButton icon: self viaModeIcon.
	viaModeButton help: 'Insert one via'.
	viaModeButton action: [editorMorph submorphs first controller swapViaMode].

	inspectButton := self newButton 
		help: 'Inspect area';
		icon: (self iconNamed: #glamorousInspect).
	inspectButton action: [area inspect].
	
	notebook := self newNotebook.
	scopesPage := NotebookPage title: 'Scopes' provider: [ scopes ].
	notebook addPage: scopesPage.
	

	
]

{ #category : #initialization }
ChipDesigner >> modeIcon: aRectangle [ 

	| sourceForm aForm |

	sourceForm := PNGReadWriter formFromFileNamed: self modesPng.

	aForm := Form extent: aRectangle extent depth: sourceForm depth.
	aForm copyBits: (aRectangle) from: sourceForm at: 0@0
		clippingBox: aForm boundingBox rule: Form over fillColor: nil.
		
	^ aForm
	
	
]

{ #category : #initialization }
ChipDesigner >> modesPng [

	^ './pharo-local/iceberg/pavel-krivanek/PharoChipDesigner/graphics/modes.png' asFileReference.

	
	
]

{ #category : #initialization }
ChipDesigner >> sequenceMorph [

	| sequenceMorph |
	
	sequenceMorph := ChipDesignerMorph newColumn.
	sequenceMorph color: (Color r: 0.506 g: 0.506 b: 0.506 alpha: 1.0).

	currentLevel scopes do: [ :scope |
		sequenceMorph addMorphBack: scope ].
	
	^ sequenceMorph
]

{ #category : #initialization }
ChipDesigner >> title [
	
	^ 'Pharo Chip Designer'.
]

{ #category : #initialization }
ChipDesigner >> toolbar [
	| aMenu |
	aMenu := self newMenuBar
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Inspect area';
						icon: (self iconNamed: #glamorousInspect);
						action: [ area inspect ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Type';
						icon: (self iconNamed: #testNotRun);
						action: [  ] ].
			group
				addItem: [ :item | 
					editModeButton := item
						name: nil;
						description: 'Mode';
						icon: (self editModeIcon);
						action: [  ] ] ].
	^ aMenu
]

{ #category : #initialization }
ChipDesigner >> viaModeIcon [

	^ viaMode
		ifTrue: [ modeViaOn ]
		ifFalse: [ modeViaOff ].
	
]
