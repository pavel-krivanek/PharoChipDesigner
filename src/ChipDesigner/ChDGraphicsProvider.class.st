Class {
	#name : #ChDGraphicsProvider,
	#superclass : #Object,
	#instVars : [
		'sourceForm',
		'paths',
		'metalForms',
		'nForms',
		'pForms',
		'corners',
		'bgForm',
		'viaForm',
		'suppressForm',
		'cellForms'
	],
	#category : #ChipDesigner
}

{ #category : #accessing }
ChDGraphicsProvider >> bgForm [
	^ bgForm
]

{ #category : #accessing }
ChDGraphicsProvider >> bgForm: anObject [
	bgForm := anObject
]

{ #category : #initialization }
ChDGraphicsProvider >> cellForm: index corners: cornersIndex from: aFormArray [
	
	| aFrom |

	aFrom := (aFormArray at: cornersIndex+1) copy: (((index*self cellSize)@0) extent: self cellSize@self cellSize).
"
	cornersIndex > 0  ifTrue: [
	(FormCanvas on: aFrom) drawString: cornersIndex asString at: 0@0 ].
"	
	^ aFrom
]

{ #category : #initialization }
ChDGraphicsProvider >> cellForm: index from: aFormArray [

	^ self cellForm: index corners: 0 from: aFormArray
]

{ #category : #accessing }
ChDGraphicsProvider >> cellForms [
	^ cellForms
]

{ #category : #accessing }
ChDGraphicsProvider >> cellForms: anObject [
	cellForms := anObject
]

{ #category : #initialization }
ChDGraphicsProvider >> cellSize [ 

	^ 13
]

{ #category : #initialization }
ChDGraphicsProvider >> colorize: aForm with: aColor [

	0 to: aForm width do: [ :x |
		0 to: aForm height do: [ :y |
			| c |
			c := aForm colorAt: x@y.
			(c red > 0.9) ifTrue: [ 
				aForm colorAt: x@y put: aColor ]
			]].
	
]

{ #category : #accessing }
ChDGraphicsProvider >> corners [
	^ corners
]

{ #category : #accessing }
ChDGraphicsProvider >> corners: anObject [
	corners := anObject
]

{ #category : #initialization }
ChDGraphicsProvider >> drawCornersFor: forms [

	| cornerForms |
	
	cornerForms := (0 to: 3) collect: [ :index | self cellForm: index from: {corners}.].
		
	forms withIndexDo: [ :aForm :index |
		| mask | 
		mask := index - 1.
		(mask bitAnd: 2r0001) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r1001) = 2r1001) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 1) ] ] ].

		(mask bitAnd: 2r0010) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r0011) = 2r0011) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 2) ] ] ].

		(mask bitAnd: 2r0100) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r01100) = 2r1100) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 3) ] ] ].

		(mask bitAnd: 2r1000) > 0 ifTrue: [ 
			(0 to: 15) do: [ :cellIndex | 
				((cellIndex bitAnd: 2r0110) = 2r0110) ifTrue: [ .
					self overlap: aForm at: cellIndex with: (cornerForms at: 4) ] ] ].
	 ].

]

{ #category : #initialization }
ChDGraphicsProvider >> formFromPng: fileName [

	^ PNGReadWriter formFromFileNamed: (self class package mcWorkingCopy ancestry ancestors first package repository location / 'graphics' / fileName)	
]

{ #category : #initialization }
ChDGraphicsProvider >> initialize [

	super initialize.
	
	sourceForm := self formFromPng: 'cells.png'.
	paths :=  self formFromPng: 'paths.png'.
	corners := self formFromPng: 'corners.png'.

	metalForms := (1 to: 16) collect: [ :index | paths deepCopy].
	nForms := (1 to: 16) collect: [ :index | paths deepCopy].
	pForms := (1 to: 16) collect: [ :index | paths deepCopy].

	self drawCornersFor: metalForms.
	self drawCornersFor: nForms.
	self drawCornersFor: pForms.

	metalForms do: [ :metalForm |
		self colorize: metalForm with: ((Color fromHexString: 'E8E8E8') alpha: 0.6) ].		
		
	nForms do: [ :nForm |
		self colorize: nForm with: ((Color fromHexString: 'B60000') alpha: 1) ].

	pForms do: [ :pForm |
		self colorize: pForm with: ((Color fromHexString: 'FFFF00') alpha: 1) ].
	
	bgForm := self cellForm: 0 from: {sourceForm}.
	viaForm := self cellForm: 1 from: {sourceForm}.
	suppressForm := self cellForm: 11 from: {sourceForm}.
	cellForms := sourceForm.


]

{ #category : #accessing }
ChDGraphicsProvider >> metalForms [
	^ metalForms
]

{ #category : #accessing }
ChDGraphicsProvider >> metalForms: anObject [
	metalForms := anObject
]

{ #category : #accessing }
ChDGraphicsProvider >> nForms [
	^ nForms
]

{ #category : #accessing }
ChDGraphicsProvider >> nForms: anObject [
	nForms := anObject
]

{ #category : #initialization }
ChDGraphicsProvider >> overlap: aSourceForm at: zeroBasedIndex with: aFrom [

	| aCanvas |
	
	zeroBasedIndex logCr.
		
	aCanvas := FormCanvas on: aSourceForm.
	aCanvas translucentImage: aFrom at: ((self cellSize*zeroBasedIndex)@0).
	

"	aCanvas drawString: zeroBasedIndex asString at: ((self cellSize*zeroBasedIndex)@0) .

"
]

{ #category : #accessing }
ChDGraphicsProvider >> pForms [
	^ pForms
]

{ #category : #accessing }
ChDGraphicsProvider >> pForms: anObject [
	pForms := anObject
]

{ #category : #accessing }
ChDGraphicsProvider >> paths [
	^ paths
]

{ #category : #accessing }
ChDGraphicsProvider >> paths: anObject [
	paths := anObject
]

{ #category : #accessing }
ChDGraphicsProvider >> sourceForm [
	^ sourceForm
]

{ #category : #accessing }
ChDGraphicsProvider >> sourceForm: anObject [
	sourceForm := anObject
]

{ #category : #accessing }
ChDGraphicsProvider >> suppressForm [
	^ suppressForm
]

{ #category : #accessing }
ChDGraphicsProvider >> suppressForm: anObject [
	suppressForm := anObject
]

{ #category : #accessing }
ChDGraphicsProvider >> viaForm [
	^ viaForm
]

{ #category : #accessing }
ChDGraphicsProvider >> viaForm: anObject [
	viaForm := anObject
]
