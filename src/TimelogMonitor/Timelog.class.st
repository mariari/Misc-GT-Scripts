Class {
	#name : #Timelog,
	#superclass : #Object,
	#instVars : [
		'pages'
	],
	#category : #TimelogMonitor
}

{ #category : #accessing }
Timelog >> addEntry: page [ 
	pages add: page
]

{ #category : #'as yet unclassified' }
Timelog >> initialize [
	super initialize.

	self pages: OrderedCollection new
]

{ #category : #accessing }
Timelog >> pages [
	^ pages
]

{ #category : #accessing }
Timelog >> pages: anObject [
	pages := anObject
]
