Class {
	#name : #MJTile,
	#superclass : #Object,
	#category : #MiscGTScripts
}

{ #category : #'as yet unclassified' }
MJTile class >> num: aNumber kind: aChar [
	^ self resolveClass: aChar with: aNumber
]

{ #category : #accessing }
MJTile class >> resolveClass: char with: num [
	char = $z ifTrue: [ ^ MJFace num: num ].
	char = $s ifTrue: [ ^ MJNumber 竹: num ].
	char = $p ifTrue: [ ^ MJNumber pin: num ].
	char = $m ifTrue: [ ^ MJNumber 萬: num ].
	^ RegexSyntaxError signal: 'improper syntax'
]

{ #category : #accessing }
MJTile >> asBlElement [
	^ self visualize asBlElement
]

{ #category : #accessing }
MJTile >> image: aView [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> visualize [
	^ self subclassResponsibility
]
