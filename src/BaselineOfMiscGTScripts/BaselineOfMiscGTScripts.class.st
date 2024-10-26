Class {
	#name : #BaselineOfMiscGTScripts,
	#superclass : #BaselineOf,
	#category : #BaselineOfMiscGTScripts
}

{ #category : #loading }
BaselineOfMiscGTScripts class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'Misc-GT-Scripts' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfMiscGTScripts >> baseline: spec [
	<baseline>
	^ spec
		for: #common
		do: [ spec
				package: 'SmaCC_Nock';
				package: 'MiscGTScripts';
				package: 'GitProjectBoard';
				package: 'MahjongModel';
				package: 'NatoSymbols' ]
]
