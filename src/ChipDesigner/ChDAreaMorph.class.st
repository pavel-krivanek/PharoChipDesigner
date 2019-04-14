Class {
	#name : #ChDAreaMorph,
	#superclass : #Morph,
	#instVars : [
		'controller',
		'sourceForm',
		'area',
		'inputMode',
		'metalForm',
		'nForm',
		'pForm',
		'mouseDown',
		'lastCell',
		'deleteMode',
		'suppressedCells',
		'stepping'
	],
	#category : #ChipDesigner
}

{ #category : #'instance creation' }
ChDAreaMorph class >> exampleRSLatch [

	<script>
	
	| area graphS graphR graphOut |
	area := (ChDArea decodeFrom: 
			'0000700007200412014120141201412014120181000022004120141201816204920181200A1000022004120181640250B00B200A120061201810000264029000020A40B240B564091200A1620850A2150A81502017220B5220B5620312006120181640432014120121200A10000220041201612014120141201412012100002').
	area show.

	graphS := ChDSequenceMorph input name: 'S'.
	graphS region: (area atX: 1 y: 2) metalRegion.
	graphS openInWindow.

	graphR := ChDSequenceMorph input name: 'R'.
	graphR region: (area atX: 1 y: 3) metalRegion.
	graphR openInWindow.

	graphOut := ChDSequenceMorph output name: 'Q'.
	graphOut region: (area atX: 1 y: 7) metalRegion.
	graphOut openInWindow.

	area simulation stepBlock: [ :aSimulation |
		(area atX: 1 y: 1) metalRegion hasVcc: true.
		(area atX: 1 y: 2) metalRegion hasVcc: (graphS sequence at: aSimulation time+1).
		(area atX: 1 y: 3) metalRegion hasVcc: (graphR sequence at: aSimulation time+1) ].
]

{ #category : #'instance creation' }
ChDAreaMorph class >> exampleX903 [

	"not fully correctly working (because of differences in the original simulation?)"

	<script>
	
	| area fire lock trigger |
	
	area := ChDArea decodeFrom: 	'0002C0001B000B2200C1201C12018100048200C1201C12018100004200E1201E1201E1201C120141201412014120141201412014120141201412014120141201412014120141201412014120141201C12014120141201810001E200E1201E1201A100004200612016120121200A100020620250A81562091620250A8156209100014200C120141201412016120161201210000A200A10002064049641036402964049641036402900014200A10000E200C1201C120181200A1000201440B620951500B1440B620951500B00014200A100004200C1201C12018100004200E1201E1201A1200A10002064083640696418364083640696418300014620250A81562051201E1201E1201A100004200612016120121200A1000206202D0A215620B16202D0A21562071201412014120141201412014120141201412014120141201412014164183000022006120161201210000A640251481564051621052A8956205164149201416414920141641492014164149201416210900002640CD2B18B00002640652B18B0001A200A10000C200C1201C1201C12014162103200C1201416412362085350CB62105350CB62105350CB62105350CB641050B00B00002240AB6202300004620230001A2006120141201C1201C12018100004200E1201E1201A1200C12014120121200C164105240B56403300002640230000264023000026402300002620C3201412412B00026200E1201E1201A100004200612016120121200A1200C120141201210000220061201412014120141201412014120141201412014120121000021440B62091000242006120161201210000A200A1200A10001C0400B200A10002E200C1201C1201C120121200A1200C1201412014120141201412014120141201412014120141201412014120141201412414B201A100024200C1201C12018100004200E1201E1201A1200C120121200A10001A0400B200E1201412014120141201C120141201412018100016200E1201E1201A100004200612016120121200A100002200A10001A0400B620250A8156209100002200A100004620250A815620910000E200C1201412016120161201210000A200A100002200A10001A0400B64049641036402900002200A1000046404964103640290000E200A10000C200C1201C1201C12012100002200A10001A0400B1440B620951500B00002200A1000041440B620951500B00002200C120141201412014120141201416412900002200C1201C12018100004200E1201E1201A100004200A10001A0400B64083640696418300002200A1000046408364069641C3201412012100008620850A21562051201E1201E1201A10000420061201612012100004200A10001A0400B6202D0A215620B10000262029000046202D0A215620310000C200A1000042006120161201210000E200A10001A640472B18B00002200E1641051421564051641452B18B00010200A10000E200C1201C1201C12014120141201210001C6202300002200A100008620230000C6408900002200A100004200C1201C12018100004200E1201E1201A1000262006120141201412014120141201412014120141201412014120141621052A27562151201612014120141201E1201E1201A10000420061201612012100048200612016120121000B2'.
	area show.
	area encoded.

	fire := ChDSequenceMorph input name: 'FIRE'.
	fire decodedFrom: 1809251394333065553493296640760748558846215340791094592969933453019578368000.
	fire region: (area atX: 3 y: 12) metalRegion.
	fire openInWindow.

	lock := ChDSequenceMorph input name: 'LOCK'.
	lock  decodedFrom: 1725434941193085158148186249241239458149418352329945174454753508196352.
	lock region: (area atX: 3 y: 16) metalRegion.
	lock openInWindow.

	trigger := ChDSequenceMorph output name: 'TRIGGER'.
	trigger region: (area atX: 3 y: 19) metalRegion.
	trigger openInWindow.


	area simulation stepBlock: [ :aSimulation |
		(area atX: 3 y: 3) metalRegion hasVcc: true.
		(area atX: 3 y: 24) metalRegion hasVcc: true.
		(area atX: 42 y: 3) metalRegion hasVcc: true.
		(area atX: 42 y: 24) metalRegion hasVcc: true.
		(area atX: 3 y: 12) metalRegion hasVcc: (fire sequence at: aSimulation time+1).
		(area atX: 3 y: 16) metalRegion hasVcc: (lock sequence at: aSimulation time+1) ].


]

{ #category : #'instance creation' }
ChDAreaMorph class >> for: anArea [

	^ self basicNew initialize initializeFor: anArea; yourself.
]

{ #category : #'instance creation' }
ChDAreaMorph class >> new [ 

	| area |
	
	area := ChDArea withDefaultExtent.	
	^ self basicNew initialize initializeFor: area; yourself.
]

{ #category : #initialization }
ChDAreaMorph >> area [ 

	^ controller area
]

{ #category : #initialization }
ChDAreaMorph >> cellExtent [

	^ self cellSize @ self cellSize
]

{ #category : #initialization }
ChDAreaMorph >> cellForm: index from: aForm [

	^ aForm copy: (((index*self cellSize)@0) extent: self cellSize@self cellSize).

]

{ #category : #initialization }
ChDAreaMorph >> cellSize [ 

	^ 13
]

{ #category : #initialization }
ChDAreaMorph >> colorize: aForm with: aColor [

	0 to: aForm width do: [ :x |
		0 to: aForm height do: [ :y |
			| c |
			c := aForm colorAt: x@y.
			(c red > 0.9) ifTrue: [ 
				aForm colorAt: x@y put: aColor ]
			]].
	
]

{ #category : #accessing }
ChDAreaMorph >> controller [
	^ controller
]

{ #category : #accessing }
ChDAreaMorph >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
ChDAreaMorph >> drawCellX: x y: y type: type sourceForm: aForm on: aCanvas origin: origin block: aBlock layer: aLayer [

	| cell cellForm |
		
	cell := self area atX: x y: y.
	(aBlock value: cell) ifTrue: [
		| index |
		(aLayer isSetFor: cell) ifTrue: [
			index := aLayer connectionsFor: cell. 
			cellForm := self cellForm: index from: aForm.
			self drawImage: cellForm atX: x y: y origin: origin on: aCanvas.
						
			(cell isHi) 
				ifTrue: [ 
					cellForm := self cellForm: 58 from: aForm.
					self drawImage: cellForm atX: x y: y origin: origin on: aCanvas. ]

			 ] ]
]

{ #category : #initialization }
ChDAreaMorph >> drawImage: aForm atX: x y: y origin: origin on: aCanvas [

	aCanvas translucentImage: aForm at: origin + (((self cellSize*(x-1)))@(self cellSize*(y-1)))
	
]

{ #category : #initialization }
ChDAreaMorph >> drawJunctionX: x y: y sourceForm: aForm on: aCanvas origin: origin block: aBlock layer: aLayer [

	| cell cellForm |
		
	cell := self area atX: x y: y.
	(aBlock value: cell) ifTrue: [
		| index |
		
		cell junctionType = #npn ifTrue: [ 
			(cell junctionConnections = 2r0001) ifTrue: [ 	index := 50 ]. 
			(cell junctionConnections = 2r0010) ifTrue: [ 	index := 55 ]. 
			(cell junctionConnections = 2r0100) ifTrue: [ 	index := 54 ].
			(cell junctionConnections = 2r1000) ifTrue: [ 	index := 51 ] ].
			
		cell junctionType = #pnp ifTrue: [ 
			(cell junctionConnections = 2r0001) ifTrue: [ 	index := 52 ]. 
			(cell junctionConnections = 2r0010) ifTrue: [ 	index := 57 ]. 
			(cell junctionConnections = 2r0100) ifTrue: [ 	index := 56 ].
			(cell junctionConnections = 2r1000) ifTrue: [ index := 53 ] ].
			
		cellForm := self cellForm: index from: aForm.
		self drawImage: cellForm atX: x y: y origin: origin on: aCanvas.

		(cell substrateRegion open) 
				ifTrue: [ 
					cellForm := self cellForm: 58 from: aForm.
					self drawImage: cellForm atX: x y: y origin: origin on: aCanvas. ]

]
		
]

{ #category : #initialization }
ChDAreaMorph >> drawOn: aCanvas [

	| bgForm viaForm origin drawSuppressed  suppressForm |
		
	origin := self innerBounds origin.
	
	bgForm := self cellForm: 48 from: sourceForm.
	viaForm := self cellForm: 49 from: sourceForm.
	suppressForm := self cellForm: 59 from: sourceForm.
	
	drawSuppressed := suppressedCells notEmpty.

	1 to: area width do: [ :x |
		1 to: area height do: [ :y | 
			| cell | 
			cell := area atX: x y:y.

			aCanvas drawImage: bgForm at: origin + ((13*(x-1))@(13*(y-1))).

			self drawJunctionX: x y: y sourceForm: sourceForm on: aCanvas origin: origin block: [:aCell | aCell junctionType notNil] layer: area substrateLayer.
		
			self drawCellX: x y: y type: #n sourceForm: nForm on: aCanvas origin: origin block: [:aCell | (aCell substrateType = #n) and: [aCell junctionType isNil]] layer: area substrateLayer.
			self drawCellX: x y: y type: #p sourceForm: pForm on: aCanvas origin: origin block: [:aCell | (aCell substrateType = #p) and: [aCell junctionType isNil]] layer: area substrateLayer.
			self drawCellX: x y: y type: #metal sourceForm: metalForm on: aCanvas origin: origin block: [:aCell | aCell metalConnections notNil] layer: area metalLayer.
			cell via ifTrue: [ 
				aCanvas translucentImage: viaForm at: origin + ((13*(x-1))@(13*(y-1))) ].

			drawSuppressed ifTrue: [ 
				(suppressedCells includes: (x@y)) ifTrue: [ 
					aCanvas translucentImage: suppressForm at: origin + ((13*(x-1))@(13*(y-1)))					
					 ]
				 ]	
			 ]]
	

]

{ #category : #initialization }
ChDAreaMorph >> eventPointOf: anEvent [

	^ ((anEvent cursorPoint - self position) // self cellSize) + (1@1).

]

{ #category : #initialization }
ChDAreaMorph >> handlesKeyboard: evt [
	"Yes, we do it here."
	
	^true
]

{ #category : #initialization }
ChDAreaMorph >> handlesMouseDown: anEvent [

	^ true
]

{ #category : #initialization }
ChDAreaMorph >> handlesMouseMove: evt [
	^ true
]

{ #category : #initialization }
ChDAreaMorph >> initializeFor: anArea [

	area := anArea.

	controller := ChDAreaController new.
	controller area: area.
	controller view: self.
	
	sourceForm := PNGReadWriter formFromFileNamed: './pharo-local/iceberg/pavel-krivanek/PharoChipDesigner/graphics/box.png'.
	metalForm := sourceForm deepCopy.
	nForm := sourceForm deepCopy.
	pForm := sourceForm deepCopy.
	
	self colorize: metalForm with: ((Color fromHexString: 'E8E8E8') alpha: 0.6).
	self colorize: nForm with: ((Color fromHexString: 'B60000') alpha: 1).
	self colorize: pForm with: ((Color fromHexString: 'FFFF00') alpha: 1).
	
	self extent: 13*area width@(13*area height).
	
	suppressedCells := OrderedCollection new.
	stepping := false.
	self stopStepping.
	
]

{ #category : #initialization }
ChDAreaMorph >> keyStroke: event [ 
	"Process keys navigation and space to toggle."
	
	event keyCharacter = $x
		ifTrue: [controller deleteMode: controller deleteMode not].
		
	event keyCharacter = $v
		ifTrue: [controller viaMode: controller viaMode not].
		
	event keyCharacter = $s
		ifTrue: [area simulation step. self changed].
		
	event keyCharacter = $r
		ifTrue: [self run]
]

{ #category : #initialization }
ChDAreaMorph >> keyboardFocusChange: aBoolean [
	"The message is sent to a morph when its keyboard focus changes.
	Update for focus feedback."
	
	super keyboardFocusChange: aBoolean.
	self focusChanged
]

{ #category : #initialization }
ChDAreaMorph >> keyboardFocusOnMouseDown [
	^ self class keyboardFocusOnMouseDown
]

{ #category : #initialization }
ChDAreaMorph >> mouseDown: anEvent [

	controller onMouseDownAt: (self eventPointOf: anEvent) event: anEvent.

]

{ #category : #initialization }
ChDAreaMorph >> mouseMove: anEvent [

	controller onMouseMoveAt: (self eventPointOf: anEvent) event: anEvent
]

{ #category : #initialization }
ChDAreaMorph >> mouseUp: anEvent [

	controller onMouseUpAt: (self eventPointOf: anEvent) event: anEvent
]

{ #category : #initialization }
ChDAreaMorph >> run [ 

	stepping := true.
	self startStepping.
]

{ #category : #initialization }
ChDAreaMorph >> step [
	
	stepping ifTrue: [ 
		(self area simulation time+1) >= 280 ifTrue: [ 
			self stopStepping.
			stepping := false.
			^ self ].

		self area simulation step.
		self changed ].
]

{ #category : #initialization }
ChDAreaMorph >> stepTime [
	^ 1 
]

{ #category : #accessing }
ChDAreaMorph >> suppressedCells [
	^ suppressedCells
]

{ #category : #accessing }
ChDAreaMorph >> suppressedCells: anObject [
	suppressedCells := anObject
]

{ #category : #initialization }
ChDAreaMorph >> takesKeyboardFocus [
	^ true
]
