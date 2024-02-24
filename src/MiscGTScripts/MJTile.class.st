Class {
	#name : #MJTile,
	#superclass : #Object,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJTile class >> kind: kind specific: value [
	^ kind = value
		ifTrue: [ MJFace new new: kind ]
		ifFalse: [ MJNumber new suit: kind number: value ]
]

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

{ #category : #predicates }
MJTile >> combinesWith: tile [
	^ (self runsWith: tile) or: [ self sameAs: tile ]
]

{ #category : #accessing }
MJTile >> image: aView [
	^ self subclassResponsibility
]

{ #category : #predicates }
MJTile >> isSpecial [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> kind [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> runsWith: tile [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> sameAs: tile [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> uniqueHash [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> value [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> valueSort [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> visualize [
	^ self subclassResponsibility
]
