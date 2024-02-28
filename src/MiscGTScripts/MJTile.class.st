"
I represent a {{gtWordExplanation:Mahjong}} tile.

I am an abstract class and one should create instance of my children {{gtClass:name=MJFace}} or {{gtClass:name=MJNumber}}.
"
Class {
	#name : #MJTile,
	#superclass : #Object,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJTile class >> characterRepresentation [
	^ self subclassResponsibility
]

{ #category : #creation }
MJTile class >> num: aNumber kind: aChar [
	^ self resolveClass: aChar with: aNumber
]

{ #category : #creation }
MJTile class >> resolveClass: char with: num [
	char = $z ifTrue: [ ^ MJFace fromNumber: num ].
	char = $s ifTrue: [ ^ MJZhu new: num ].
	char = $p ifTrue: [ ^ MJPin new: num ].
	char = $m ifTrue: [ ^ MJMan new: num ].
	^ RegexSyntaxError signal: 'improper syntax'
]

{ #category : #accessing }
MJTile class >> suit [
	^ self subclassResponsibility
]

{ #category : #visualization }
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

{ #category : #represenations }
MJTile >> numericRepresentation [
	^ self subclassResponsibility
]

{ #category : #predicates }
MJTile >> runsWith: tile [
	^ self subclassResponsibility
]

{ #category : #predicates }
MJTile >> sameAs: tile [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> suit [
	^ self class suit
]

{ #category : #equality }
MJTile >> uniqueHash [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> value [
	^ self subclassResponsibility
]

{ #category : #equality }
MJTile >> valueSort [
	^ self subclassResponsibility
]

{ #category : #visualization }
MJTile >> visualize [
	^ self subclassResponsibility
]
