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
	area := 	(ChDArea decodeFrom: 
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
