Class {
	#name : #ChipDesigner,
	#superclass : #ComposablePresenter,
	#instVars : [
		'list',
		'editor',
		'areaMorph',
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
		'currentLevel',
		'exportButton',
		'importButton',
		'runButton',
		'stepButton',
		'resetButton',
		'selectModeButton',
		'instructions'
	],
	#category : #ChipDesigner
}

{ #category : #examples }
ChipDesigner class >> buttonsExtent [

	^67@30
]

{ #category : #examples }
ChipDesigner class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecPanedLayout newHorizontal
				position: 300;
				add: #list;
				add: (
					SpecBoxLayout newVertical
					add: (SpecBoxLayout newHorizontal
							add: #editModeButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #viaModeButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #selectModeButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #exportButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #importButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #inspectButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #runButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #stepButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #resetButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							
							yourself)
						withConstraints: [ :constraints | constraints height: self buttonsExtent y ];
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
ChipDesigner >> copy [ 
	
	| temporary |
	
	self flag: #todo. "should be repced by a less hackish copying"
	
	temporary := ChDArea extent: (area selection width@(area selection height)).
	temporary decodedFromZipString: (area encodedRectangle: area selection) zipped asByteArray base64Encoded.
	temporary disconnect: (Rectangle origin: 1@1 corner: (temporary width@temporary height)).
	
	Clipboard clipboardText: temporary zipString
]

{ #category : #initialization }
ChipDesigner >> delete [

	area deleteSelection.
	self refreshEditor.
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

	| editorMorph scrollPane |
	
	areaMorph := ChDAreaMorph for: area.
	
	editorMorph := AlignmentMorph newColumn.
	editorMorph color: (Color r: 0.506 g: 0.506 b: 0.506 alpha: 1.0).
	
	scrollPane := ScrollPane new.
	scrollPane scroller addMorph: areaMorph.
	editorMorph addMorph: scrollPane fullFrame: LayoutFrame identity.

	
	controller := areaMorph controller.
	controller announcer when: ChDModeAnnouncement do: [ :announcement |
		| buttons |
		buttons := { editModeButton. viaModeButton. selectModeButton }.
		buttons do: [ :button | button state: false ].
		(buttons at: announcement inputMode buttonIndex) state: true.
		
		editMode := announcement inputMode isDelete
			ifTrue: [ 
				(announcement inputMode affectsMetal)
					ifTrue: [ #delete ]
					ifFalse: [ #deleteSilicon ] ] 
			ifFalse: [ self translatedInputMode: announcement inputMode ].
		viaMode := announcement controller inputMode isInsertVia. 
		editModeButton icon: self editModeIcon.
		viaModeButton icon: self viaModeIcon ].


	controller announcer when: ChDContextMenuAnnouncement do: [ :announcement |
		self openSelectionMenu ].


	^ editorMorph
]

{ #category : #initialization }
ChipDesigner >> export [ 

	| aString dialog textPresenter |
	
	aString := area zipString.
	
	dialog := SpecVersatileDialogPresenter new.
	dialog title: 'Export area'.
	textPresenter := dialog newText.
	textPresenter text: aString.
	dialog contentArea: textPresenter.
	dialog addButton: #ok text: 'OK' value: true.
	
	dialog openModalWithSpec.

	dialog result logCr.
	
]

{ #category : #initialization }
ChipDesigner >> import [ 

	| dialog textPresenter |
		
	dialog := SpecVersatileDialogPresenter new.
	dialog title: 'Import area'.
	textPresenter := dialog newText.
	textPresenter autoAccept: true.
	dialog contentArea: textPresenter.
	dialog addButton: #ok text: 'OK' value: true.
	dialog addButton: #cancel text: 'Cancel' value: false.
	
	dialog openModalWithSpec.

	dialog result ifFalse: [ ^ self ].

	[ 
		area decodedFromZipString: textPresenter text asString.
		currentLevel reinitialize.	
	] ifError: [ :e | self inform: 'Import error: ', e asString ].

	self refreshEditor
]

{ #category : #initialization }
ChipDesigner >> initialExtent [
	^ 940@720
]

{ #category : #initialization }
ChipDesigner >> initialize [ 

	area := ChDArea extent: 45@30.
	editMode := #metal.
	toolbar := self toolbar. 
	viaMode := false.

	currentLevel := ChDClassicLevel1Intro on: area.

	modeNormalForm := self modeIcon: (Rectangle origin: 0@0 extent: 27@14).
	modeShiftForm := self modeIcon: (Rectangle origin: 26@0 extent: 27@14).
	modeDeleteForm := self modeIcon: (Rectangle origin: 52@0 extent: 15@14).
	modeDeleteSiliconForm := self modeIcon: (Rectangle origin: 65@0 extent: 15@14).
	modeViaOn := self modeIcon: (Rectangle origin: 78@0 extent: 14@14).
	modeViaOff := self modeIcon: (Rectangle origin: 91@0 extent: 14@14).
		
	super initialize.
	
	
	
	
	
]

{ #category : #initialization }
ChipDesigner >> initializeList [

	| designs |
	
	designs := (ChDDesign allSubclasses select: [ :each | each isRoot ]) sorted: [:a :b | a priority <= b priority ].

	list := self newTreeTable.

	list
		addColumn:
			(CompositeTableColumn new
				title: 'Designs';
				addColumn:
					(ImageTableColumn new
						width: 20;
						evaluated: #designIcon;
						yourself);
				addColumn:
					(StringTableColumn new
						evaluated: #designName;
						yourself);
				yourself);
		roots: designs;
		children: [ :design | design levels ];
		beResizable.

	list whenSelectionChangedDo: [ :selection | 
		| levelClass |
		levelClass := selection selectedItem.
		levelClass selectable ifTrue: [ 
			currentLevel := levelClass on: area.
			self refreshEditor.
			self initializeNotebook.
			self needRebuild: false.
			self buildWithSpec ] ].
 
]

{ #category : #initialization }
ChipDesigner >> initializeNotebook [
	
	| instructionsPage scopesPage |
	instructions := self instructionsMorph asSpecAdapter.
	scopes := self sequenceMorph asSpecAdapter.


	notebook := self newNotebook.
	instructionsPage := NotebookPage title: 'Instructions' provider: [ instructions ].
	scopesPage := NotebookPage title: 'Scopes' provider: [ scopes ].
	notebook addPage: instructionsPage.
	notebook addPage: scopesPage.
	
	

	
]

{ #category : #initialization }
ChipDesigner >> initializeWidgets [

	| editorMorph instructionsPage scopesPage |
	
	self initializeList.
	
	editorMorph := self editorMorph.
	editor := editorMorph asSpecAdapter.
	
	editModeButton := self newButton icon: self editModeIcon.
	editModeButton label: 'mode'.
	editModeButton help: 'Drawing / delete mode <X>, extended <Shift>'.
	editModeButton action: [ 
		controller swapDeleteMode].
	editModeButton state: true.

	viaModeButton := self newButton icon: self viaModeIcon.
	viaModeButton label: 'via'.
	viaModeButton help: 'Insert one via'.
	viaModeButton action: [controller swapViaMode].

	selectModeButton := self newButton icon: (self iconNamed: #group).
	selectModeButton label: 'select'.
	selectModeButton help: 'select cells'.
	selectModeButton action: [ self selectMode ].

	exportButton := self newButton icon: (self iconNamed: #smallSave).
	exportButton label: 'export'.
	exportButton help: 'export area to a string'.
	exportButton action: [ self export ].

	importButton := self newButton icon: (self iconNamed: #smallLoadProject).
	importButton label: 'import'.
	importButton help: 'import area from a string'.
	importButton action: [ self import ].	

	runButton := self newButton icon: (self iconNamed: #smallDoIt).
	runButton label: 'run'.
	runButton help: 'run / stop simulation'.
	runButton action: [ self toggleRun ].	

	area simulation announcer when: ChDSimulationRunAnnouncement do: [ :announcement |
		runButton icon: (self iconNamed: (announcement running
			ifTrue: [ #stop ]
			ifFalse: [ #smallDoIt ])) ].

	resetButton := self newButton icon: (self iconNamed: #smallUpdate).
	resetButton label: 'reset'.
	resetButton help: 'reset simulation'.
	resetButton action: [ self simulationReset ].	

	stepButton := self newButton icon: (self iconNamed: #glamorousPlay).
	stepButton label: 'step'.
	stepButton help: 'run / stop simulation'.
	stepButton action: [ self simulationStep ].	

	inspectButton := self newButton 
		label: 'inspect';
		help: 'Inspect area';
		icon: (self iconNamed: #glamorousInspect).
	inspectButton action: [area inspect].
	
	self initializeNotebook.
	

	
]

{ #category : #initialization }
ChipDesigner >> instructionsMorph [

	^ currentLevel instructions 
		ifNotNil: [ :fileName |
			 | form |
			form := PNGReadWriter formFromFileNamed: './pharo-local/iceberg/pavel-krivanek/PharoChipDesigner/levels/', fileName.
			form asMorph
		 ]
		ifNil: [ Morph new ]
]

{ #category : #initialization }
ChipDesigner >> levels [

	^ { 
		ChDClassicLevel1Intro.
		ChDClassicLevel1.
		ChDClassicLevel2.
		ChDClassicLevel3.
		ChDClassicLevel4.
		ChDClassicLevel5.
		ChDClassicLevel6.
		ChDClassicLevel7.
		ChDClassicLevel8.
		ChDClassicLevel9.
		ChDClassicLevel10.
		ChDClassicLevel11.
		ChDClassicLevel12.
		ChDClassicLevel13.
		ChDClassicLevel14.
		ChDClassicLevel15.
		ChDClassicLevel16.
		ChDClassicLevel17.
		ChDClassicLevel18.
		ChDClassicLevel19.
	 }
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
ChipDesigner >> openSelectionMenu [

	| menu |
	
	menu := self selectionMenu.
	menu openWithSpecAt: ActiveHand position
]

{ #category : #initialization }
ChipDesigner >> paste [

	| temporary destinationRectangle |

		
	temporary := ChDArea oneByOne decodedFromZipString: Clipboard clipboardText asString.

	destinationRectangle := 	Rectangle origin: area selection origin extent: (temporary width-1)@(temporary height-1).
	area deleteRectangle: destinationRectangle.
	
	area decodedFromZipString: Clipboard clipboardText asString at: area selection origin.
	area disconnectBorder: destinationRectangle.
	
	self refreshEditor. 
]

{ #category : #initialization }
ChipDesigner >> refreshEditor [

	areaMorph resetExtent.
	areaMorph changed
]

{ #category : #initialization }
ChipDesigner >> selectMode [

	controller inputMode: ChDSelectMode new. 
]

{ #category : #initialization }
ChipDesigner >> selectionMenu [

	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Copy';
				icon: (self iconNamed: #smallCopy);
				action: [ self copy]];
		addItem: [ :item | 
			item
				name: 'Paste';
				icon: (self iconNamed: #smallPaste);
				action: [ self paste ]  ];
		addItem: [ :item | 
			item
				name: 'Delete';
				icon: (self iconNamed: #changeRemove);
				action: [ self delete ]  ];
				
		yourself
]

{ #category : #initialization }
ChipDesigner >> sequenceMorph [

	| sequenceMorph |
	
	sequenceMorph := AlignmentMorph newColumn.
	sequenceMorph color: (Color r: 0.506 g: 0.506 b: 0.506 alpha: 1.0).

	currentLevel scopes do: [ :scope |
		sequenceMorph addMorphBack: scope ].
	
	^ sequenceMorph
]

{ #category : #initialization }
ChipDesigner >> simulationReset [

	area simulation reset.
	self refreshEditor
]

{ #category : #initialization }
ChipDesigner >> simulationStep [

	area simulation step. 
	areaMorph changed.
]

{ #category : #initialization }
ChipDesigner >> title [
	
	^ 'Pharo Chip Designer'.
]

{ #category : #initialization }
ChipDesigner >> toggleRun [

	areaMorph toggleRun
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
ChipDesigner >> translatedInputMode: inputMode [

	^ (Dictionary newFrom: { 
		ChDDeleteMetalMode -> #delete.
		ChDDeleteSubstrateMode -> #deleteSilicon.
		ChDInsertMetalMode -> #metal.
		ChDInsertPSubstrateMode -> #shift.
		ChDInsertNSubstrateMode -> #metal.	
	 }) at: inputMode class ifAbsent: [ #metal ]
]

{ #category : #initialization }
ChipDesigner >> viaModeIcon [

	^ viaMode
		ifTrue: [ modeViaOn ]
		ifFalse: [ modeViaOff ].
	
]
