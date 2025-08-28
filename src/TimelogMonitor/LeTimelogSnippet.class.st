Class {
	#name : #LeTimelogSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'tags'
	],
	#category : #'TimelogMonitor-snippet'
}

{ #category : #'lepiter-store' }
LeTimelogSnippet class >> leJsonV4Name [
	^ #timelogSnippet
]
