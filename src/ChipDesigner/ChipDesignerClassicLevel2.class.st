Class {
	#name : #ChipDesignerClassicLevel2,
	#superclass : #ChipDesignerClassicLevel,
	#category : #ChipDesigner
}

{ #category : #accessing }
ChipDesignerClassicLevel2 class >> levelName [

	^ 'KT221A - Dual 2-Input AND Gate'
]

{ #category : #'as yet unclassified' }
ChipDesignerClassicLevel2 >> portsDefinition [

	^ { 
		ChipDesignerClassicLevelPort 
			name: 'A0'
			sequence: 1850865941526037605677840993543748958310219930499370732899973713546974357093376.
		ChipDesignerClassicLevelPort 
			name: 'B0'
			sequence: 1895284918403236866476334451802278920706695325499002450078158606984470829909147648.
		ChipDesignerClassicLevelPort 
			name: 'Y0'
			expectedSequence: 1765121628193292057405265415457089902134244724516531196945931213012467712.
		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.

		ChipDesignerClassicLevelPort notConnectedNamed: 'N/C'.
		ChipDesignerClassicLevelPort 
			name: 'A1'
			sequence: 1897135782579639594181454147332278531850166882490053848351047417049313874829900800.	 
		ChipDesignerClassicLevelPort 
			name: 'B1'
			sequence: 1723751590030945562870485466389691206541816773269623482238588968501248.	 
		ChipDesignerClassicLevelPort 
			name: 'Y1'
			expectedSequence: 1723751590030945562870485466388331406302128804331642887615922176000000.	 
		}


]
