"
I am a Spec presenter with the user interface of the Pharo Chip Designer.
"
Class {
	#name : #ChipDesigner,
	#superclass : #SpPresenter,
	#instVars : [
		'list',
		'editor',
		'areaMorph',
		'scopes',
		'area',
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
		'notebook',
		'currentLevel',
		'selectModeButton',
		'instructions',
		'graphics',
		'runButton',
		'statusBar',
		'toolbar'
	],
	#classInstVars : [
		'taskbarIcon'
	],
	#category : #ChipDesigner
}

{ #category : #examples }
ChipDesigner class >> buttonsExtent [

	^67@30
]

{ #category : #examples }
ChipDesigner class >> criticsBrowserMenuOn: aBuilder [ 
	<worldMenu>
	
	(aBuilder item: 'Pharo Chip Designer')
		action: [ self open ];
		order: 10;
		parent: #Tools;
		help: 'Chip design game';
		icon: self taskbarIcon
]

{ #category : #examples }
ChipDesigner class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpPanedLayout newHorizontal
				position: 300;
				add: #list;
				add: (
					SpBoxLayout newVertical
					add: (SpBoxLayout newHorizontal
							add: #editModeButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #viaModeButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							add: #selectModeButton withConstraints: [ :constraints | constraints width: self buttonsExtent x ];
							yourself)
						withConstraints: [ :constraints | constraints height: self buttonsExtent y ];
						add: (SpPanedLayout newVertical
							position: 58 percent;
							add: #editor;
							add: #notebook )));
		yourself
]

{ #category : #examples }
ChipDesigner class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #examples }
ChipDesigner class >> stepButtonsExtent [

	^47@30
]

{ #category : #examples }
ChipDesigner class >> taskbarIcon [ 

	^ taskbarIcon ifNil: [ taskbarIcon := (Form
	extent: (16@16)
	depth: 32
	fromArray: #( 4285546303 4286390047 4285997602 4285558896 4286940549 4286940549 4286874756 4286940549 4286940549 4286874756 4286940549 4286940549 4285558896 4285997602 4286390047 4285546303 4286390047 4290117632 4289003520 4284966759 4291282887 4291282887 4291151301 4291282887 4291282887 4291151301 4291282887 4291282887 4284966759 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284966759 4291282887 4291282887 4290032820 4290032820 4290032820 4290032820 4291282887 4291282887 4284966759 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284900966 4291151301 4291151301 4284835173 4284966759 4284966759 4285822068 4291151301 4291151301 4284900966 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284966759 4291282887 4291282887 4291151301 4291282887 4291282887 4291151301 4291282887 4291282887 4284966759 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284966759 4291282887 4291282887 4291151301 4291282887 4291282887 4291151301 4291282887 4291282887 4284835173 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284900966 4291151301 4291151301 4283255370 4283976009 4283976009 4283913297 4284571947 4284571947 4284703568 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284966759 4291282887 4291282887 4283976009 4290150271 4290150271 4284173372 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284966759 4291282887 4291282887 4283976009 4290150271 4290150271 4284173372 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4284440414 4283979849 4283979849 4284110663 4284173372 4284173372 4283715891 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4286019365 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4286282527 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4286282527 4294967040 4294967040 4286348309 4286348319 4286348319 4287466766 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4286282527 4294967040 4294967040 4293519616 4293388032 4293388032 4293848576 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4286390047 4290117632 4289003520 4286282527 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4294967040 4286348319 4289003520 4290117632 4286390047 4285546303 4286390047 4285997602 4286019414 4288848415 4288848415 4288848415 4288848415 4288848415 4288848415 4288848415 4288848415 4286019414 4285997602 4286390047 4285546303)
	offset: (0@0)) ]
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
	
	areaMorph := ChDAreaMorph for: area graphics: graphics.
	
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
	
	dialog := ChDDialog new.
	dialog title: 'Export area'.
	textPresenter := dialog newText.
	textPresenter text: aString.
	dialog contentArea: textPresenter.
	dialog addButton: #ok text: 'OK' value: true.
	
	dialog openModalWithSpec.	
]

{ #category : #accessing }
ChipDesigner >> graphics [
	^ graphics
]

{ #category : #accessing }
ChipDesigner >> graphics: anObject [
	graphics := anObject
]

{ #category : #initialization }
ChipDesigner >> import [ 

	| dialog textPresenter |
		
	dialog := ChDDialog new.
	textPresenter := dialog newText.
	dialog title: 'Import Area'.
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
	^ 950@800
]

{ #category : #initialization }
ChipDesigner >> initialize [ 

	area := ChDArea extent: 45@30.
	editMode := #metal.
	viaMode := false.
	
	graphics := ChDGraphicsProvider new.
	
	currentLevel := ChDClassicLevel1Intro on: area graphics: graphics.

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
	
	designs := (ChDGenericDesign allSubclasses select: [ :each | each isRoot ]) sorted: [:a :b | a priority <= b priority ].

	list := self newTreeTable.

	list
		addColumn:
			(SpCompositeTableColumn new
				title: 'Designs';
				addColumn:
					(SpImageTableColumn new
						width: 20;
						evaluated: #designIcon;
						yourself);
				addColumn:
					(SpStringTableColumn new
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
			currentLevel := levelClass on: area graphics: areaMorph display graphics.
			self refreshEditor.
			self initializeNotebook.
			self needRebuild: false.
			self buildWithSpec ] ].
 
]

{ #category : #initialization }
ChipDesigner >> initializeNotebook [
	
	| instructionsPage scopesPage |
	instructions := SpMorphPresenter new
		morph: self instructionsMorph;
		yourself.
	scopes := SpMorphPresenter new
		morph: self sequenceMorph;
		yourself.


	notebook := self newNotebook.
	instructionsPage := SpNotebookPage title: 'Instructions' provider: [ instructions ].
	scopesPage := SpNotebookPage title: 'Scopes' provider: [ scopes ].
	notebook addPage: instructionsPage.
	notebook addPage: scopesPage.
	
	

	
]

{ #category : #initialization }
ChipDesigner >> initializeStatusBar [

	statusBar := self instantiate: SpStatusBarPresenter.	
	statusBar pushMessage: 'Ready'.
]

{ #category : #initialization }
ChipDesigner >> initializeToolbar [

	toolbar := self newToolBar
		addItem:
			(SpToolBarButton new
				label: 'Export';
				icon: (self iconNamed: #smallSave);
				help: 'Export area to a string';
				action: [ self export ];
				yourself)
			position: SpToolBarItemPosition left;
		addItem:
			(SpToolBarButton new
				label: 'Import';
				icon: (self iconNamed: #smallLoadProject);
				help: 'Import area from a string';
				action: [ self import ];
				yourself)
			position: SpToolBarItemPosition left;

		addItem:
			(SpToolBarButton new
				label: 'Step';
				icon: (self iconNamed: #glamorousPlay);
				help: 'Single simulation step';
				action: [ self simulationStep: 1 ];
				yourself)
			position: SpToolBarItemPosition left;
		addItem:
			(SpToolBarButton new
				label: '5x';
				icon: (self iconNamed: #glamorousPlay);
				help: '5 simulation steps';
				action: [ self simulationStep: 5 ];
				yourself)
			position: SpToolBarItemPosition left;
		addItem:
			(SpToolBarButton new
				label: '10x';
				icon: (self iconNamed: #glamorousPlay);
				help: 'Ten simulation steps';
				action: [ self simulationStep: 10 ];
				yourself)
			position: SpToolBarItemPosition left;
		addItem:
			(runButton := SpToolBarButton new
						label: 'Run';
						icon: (self iconNamed: #smallDoIt);
						help: 'Run / stop simulation';
						action: [ self toggleRun ];
						yourself)
			position: SpToolBarItemPosition left;

			addItem:
				(SpToolBarButton new
					label: 'Reset';
					icon: (self iconNamed: #smallUpdate);
					help: 'reset simulation';
					action: [ self simulationReset ];
					yourself)
			position: SpToolBarItemPosition left;
			addItem:
				(SpToolBarButton new
					label: 'Inspect';
					icon: (self iconNamed: #glamorousInspect);
					help: 'zoom out the display';
					action: [area inspect];
					yourself)
			position: SpToolBarItemPosition right;
			addItem:
				(SpToolBarButton new
					label: 'Zoom out';
					icon: (self iconNamed: #glamorousZoomOut);
					help: 'zoom out the display';
					action: [ self zoomOut ];
					yourself)
			position: SpToolBarItemPosition right;
			addItem:
				(SpToolBarButton new
					label: 'Zoom in';
					icon: (self iconNamed: #glamorousZoomIn);
					help: 'zoom in the display';
					action: [ self zoomIn ];
					yourself)
			position: SpToolBarItemPosition right.
	
	self subscribeRunButton.
]

{ #category : #initialization }
ChipDesigner >> initializeWidgets [

	| editorMorph|
	
	self initializeList.
	
	editorMorph := self editorMorph.
	editor := SpMorphPresenter new
		morph: editorMorph;
		yourself.
	
	self initializeToolbar.
	
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
	
	self initializeNotebook.
	

	
]

{ #category : #initialization }
ChipDesigner >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		toolBar: toolbar;
		statusBar: statusBar.
	
]

{ #category : #initialization }
ChipDesigner >> instructionsMorph [

	^ currentLevel instructions 
		ifNotNil: [ :fileName |
			 | form |
			form := PNGReadWriter formFromFileNamed: (self class package mcWorkingCopy ancestry ancestors first package repository location / 'levels' / fileName).
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

	^ self class package mcWorkingCopy ancestry ancestors first package repository location / 'graphics' / 'modes.png'.

	
	
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

	self subscribeRunButton.
	
	areaMorph resetExtent.
	areaMorph changed.
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
ChipDesigner >> simulationStep: n [

	n timesRepeat: [ 
		area simulation step ].
	areaMorph changed.
]

{ #category : #accessing }
ChipDesigner >> statusbar [
]

{ #category : #initialization }
ChipDesigner >> subscribeRunButton [
	area simulation announcer
		when: ChDSimulationRunAnnouncement
		do: [ :announcement | 
			runButton
				badge:
					(announcement running
						ifTrue: [ ' ' ]
						ifFalse: [ nil ]).
			"an ugly hack to properly refresh the badge"
			self toolbar adapter changed ]
]

{ #category : #initialization }
ChipDesigner >> title [
	
	^ 'Pharo Chip Designer'.
]

{ #category : #initialization }
ChipDesigner >> toggleRun [

	areaMorph toggleRun
]

{ #category : #accessing }
ChipDesigner >> toolbar [

	^ toolbar
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

{ #category : #initialization }
ChipDesigner >> zoomIn [ 

	areaMorph zoom: areaMorph zoom * 1.25.
	self refreshEditor. 
]

{ #category : #initialization }
ChipDesigner >> zoomOut [ 

	areaMorph zoom: areaMorph zoom * 0.75.
	self refreshEditor. 
]
