Class {
	#name : #ChDClassicLevel5,
	#superclass : #ChDClassicLevel,
	#category : #'ChipDesigner-Levels'
}

{ #category : #accessing }
ChDClassicLevel5 class >> levelName [

	^ '[05] KO223 - Dual Fixed Frequency Oscillator'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel5 >> instructions [ 

	^ 'classic05.png'
]

{ #category : #'as yet unclassified' }
ChDClassicLevel5 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'EN0'
			sequence: 1809251394333065553491764145219884065145560071537429849915298050424541544448.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC0'
			expectedSequence: 1807486271021521099294765100139966498690007776791595922603044017001864364032.			

		ChipDesignerClassicLevelPort 
			name: 'EN1'
			sequence: 1809251394333063946555252383231974655574824859445932416682729794555633205248.	 
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'OSC1'
			expectedSequence: 1807486271021521097727022161835588050485548522926140803155987852849797136384.	 
		}


]
