Class {
	#name : #BaselineOfMiscGTScripts,
	#superclass : #BaselineOf,
	#category : #BaselineOfMiscGTScripts
}

{ #category : #baseline }
BaselineOfMiscGTScripts >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'MiscGTScripts'
		]
]
