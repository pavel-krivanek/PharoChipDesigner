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
		'currentLevel',
		'exportButton',
		'importButton',
		'runButton',
		'stepButton',
		'resetButton',
		'selectModeButton'
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
				position: 200;
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

{ #category : #obsolete }
ChipDesigner class >> exampleRSLatch [

	<script>
	
	| area graphS graphR graphOut mainMorph |
	area := (ChDArea decodeFrom: 
			'0000700007200412014120141201412014120181000022004120141201816204920181200A1000022004120181640250B00B200A120061201810000264029000020A40B240B564091200A1620850A2150A81502017220B5220B5620312006120181640432014120121200A10000220041201612014120141201412012100002').

	mainMorph := AlignmentMorph newColumn.
	mainMorph color: (Color r: 0.506 g: 0.506 b: 0.506 alpha: 1.0).
	mainMorph addMorphBack: (ChDAreaMorph for: area).

	graphS := ChDSequenceMorph input name: 'S'.
	graphS region: (area atX: 1 y: 2) metalRegion.

	graphR := ChDSequenceMorph input name: 'R'.
	graphR region: (area atX: 1 y: 3) metalRegion.

	graphOut := ChDSequenceMorph output name: 'Q'.
	graphOut region: (area atX: 1 y: 7) metalRegion.
	
	mainMorph addMorphBack: graphS.
	mainMorph addMorphBack: graphR.
	mainMorph addMorphBack: graphOut.
	mainMorph openInWindowLabeled: 'Pharo Chip Designer: RS Latch'.


	area simulation preStepBlock: [ :aSimulation |
		(area atX: 1 y: 1) metalRegion hasVcc: true.
		(area atX: 1 y: 2) metalRegion hasVcc: (graphS sequence at: aSimulation time+1).
		(area atX: 1 y: 3) metalRegion hasVcc: (graphR sequence at: aSimulation time+1) ].
]

{ #category : #obsolete }
ChipDesigner class >> exampleX903 [

	"not fully correctly working (because of differences in the original simulation?)"

	<script>
	
	| area fire lock trigger mainMorph |
	
	area := ChDArea decodeFrom: 	'0002C0001B000B2200C1201C12018100048200C1201C12018100004200E1201E1201E1201C120141201412014120141201412014120141201412014120141201412014120141201412014120141201C12014120141201810001E200E1201E1201A100004200612016120121200A100020620250A81562091620250A8156209100014200C120141201412016120161201210000A200A10002064049641036402964049641036402900014200A10000E200C1201C120181200A1000201440B620951500B1440B620951500B00014200A100004200C1201C12018100004200E1201E1201A1200A10002064083640696418364083640696418300014620250A81562051201E1201E1201A100004200612016120121200A1000206202D0A215620B16202D0A21562071201412014120141201412014120141201412014120141201412014164183000022006120161201210000A640251481564051621052A8956205164149201416414920141641492014164149201416210900002640CD2B18B00002640652B18B0001A200A10000C200C1201C1201C12014162103200C1201416412362085350CB62105350CB62105350CB62105350CB641050B00B00002240AB6202300004620230001A2006120141201C1201C12018100004200E1201E1201A1200C12014120121200C164105240B56403300002640230000264023000026402300002620C3201412412B00026200E1201E1201A100004200612016120121200A1200C120141201210000220061201412014120141201412014120141201412014120121000021440B62091000242006120161201210000A200A1200A10001C0400B200A10002E200C1201C1201C120121200A1200C1201412014120141201412014120141201412014120141201412014120141201412414B201A100024200C1201C12018100004200E1201E1201A1200C120121200A10001A0400B200E1201412014120141201C120141201412018100016200E1201E1201A100004200612016120121200A100002200A10001A0400B620250A8156209100002200A100004620250A815620910000E200C1201412016120161201210000A200A100002200A10001A0400B64049641036402900002200A1000046404964103640290000E200A10000C200C1201C1201C12012100002200A10001A0400B1440B620951500B00002200A1000041440B620951500B00002200C120141201412014120141201416412900002200C1201C12018100004200E1201E1201A100004200A10001A0400B64083640696418300002200A1000046408364069641C3201412012100008620850A21562051201E1201E1201A10000420061201612012100004200A10001A0400B6202D0A215620B10000262029000046202D0A215620310000C200A1000042006120161201210000E200A10001A640472B18B00002200E1641051421564051641452B18B00010200A10000E200C1201C1201C12014120141201210001C6202300002200A100008620230000C6408900002200A100004200C1201C12018100004200E1201E1201A1000262006120141201412014120141201412014120141201412014120141621052A27562151201612014120141201E1201E1201A10000420061201612012100048200612016120121000B2'.

	area descriptions add: ('+Vcc' -> (3@4)).
	area descriptions add: ('N/C' -> (3@8)).
	area descriptions add: ('fire' -> (3@12)).
	area descriptions add: ('lock' -> (3@16)).
	area descriptions add: ('trig' -> (3@20)).
	area descriptions add: ('+Vcc' -> (3@24)).

	area descriptions add: ('+Vcc' -> (42@4)).
	area descriptions add: ('  A+' -> (42@8)).
	area descriptions add: ('  A-' -> (42@12)).
	area descriptions add: ('  B+' -> (42@16)).
	area descriptions add: ('  B-' -> (42@20)).
	area descriptions add: ('+Vcc' -> (42@24)).

	mainMorph := AlignmentMorph newColumn.
	mainMorph color: (Color r: 0.506 g: 0.506 b: 0.506 alpha: 1.0).
	mainMorph addMorphBack: (ChDAreaMorph for: area).

	fire := ChDSequenceMorph input name: 'FIRE'.
	fire decodedFrom: 1809251394333065553493296640760748558846215340791094592969933453019578368000.
	fire region: (area atX: 3 y: 12) metalRegion.

	lock := ChDSequenceMorph input name: 'LOCK'.
	lock  decodedFrom: 1725434941193085158148186249241239458149418352329945174454753508196352.
	lock region: (area atX: 3 y: 16) metalRegion.

	trigger := ChDSequenceMorph output name: 'TRIGGER'.
	trigger region: (area atX: 3 y: 19) metalRegion.

	mainMorph addMorphBack: fire.
	mainMorph addMorphBack: lock.
	mainMorph addMorphBack: trigger.
	mainMorph openInWindowLabeled: 'Pharo Chip Designer: X903'.

	area simulation preStepBlock: [ :aSimulation |
		(area atX: 3 y: 3) metalRegion hasVcc: true.
		(area atX: 3 y: 24) metalRegion hasVcc: true.
		(area atX: 42 y: 3) metalRegion hasVcc: true.
		(area atX: 42 y: 24) metalRegion hasVcc: true.
		(area atX: 3 y: 12) metalRegion hasVcc: (fire sequence at: aSimulation time+1).
		(area atX: 3 y: 16) metalRegion hasVcc: (lock sequence at: aSimulation time+1) ].


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
	
	editorMorph := AlignmentMorph newColumn.
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
	editModeButton label: 'mode'.
	editModeButton help: 'Drawing / delete mode <X>, extended <Shift>'.
	editModeButton action: [editorMorph submorphs first controller swapDeleteMode].

	viaModeButton := self newButton icon: self viaModeIcon.
	viaModeButton label: 'via'.
	viaModeButton help: 'Insert one via'.
	viaModeButton action: [editorMorph submorphs first controller swapViaMode].

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
ChipDesigner >> openSelectionMenu [

	| menu |
	
	menu := self selectionMenu.
	menu openWithSpecAt: ActiveHand position
]

{ #category : #initialization }
ChipDesigner >> paste [

	| temporary |
	
	temporary := ChDArea oneByOne decodedFromZipString: Clipboard clipboardText asString.
	
	
	area decodedFromZipString: Clipboard clipboardText asString at: area selection origin.
	area disconnectBorder: (Rectangle origin: area selection origin extent: (temporary width-1)@(temporary height-1)).
	self refreshEditor. 
]

{ #category : #initialization }
ChipDesigner >> refreshEditor [

	editor widget submorphs first changed
]

{ #category : #initialization }
ChipDesigner >> selectMode [

	controller selectMode: true. 
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
	editor widget submorphs first changed.
]

{ #category : #initialization }
ChipDesigner >> title [
	
	^ 'Pharo Chip Designer'.
]

{ #category : #initialization }
ChipDesigner >> toggleRun [

	editor widget submorphs first toggleRun
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
