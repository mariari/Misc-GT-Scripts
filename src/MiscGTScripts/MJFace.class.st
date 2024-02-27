Class {
	#name : #MJFace,
	#superclass : #MJTile,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #creation }
MJFace class >> convertKind: string [
	#east = string ifTrue: [ ^ MJEast new ].
	#south = string ifTrue: [ ^ MJSouth new ].
	#west = string ifTrue: [ ^ MJWest new ].
	#north = string ifTrue: [ ^ MJNorth new ].
	#white = string ifTrue: [ ^ MJWhite new ].
	#green = string ifTrue: [ ^ MJGreen new ].
	#red = string ifTrue: [ ^ MJRed new ]
]

{ #category : #creation }
MJFace class >> fromNumber: anInteger [
	1 = anInteger ifTrue: [ ^ MJEast new ].
	2 = anInteger ifTrue: [ ^ MJSouth new ].
	3 = anInteger ifTrue: [ ^ MJWest new ].
	4 = anInteger ifTrue: [ ^ MJNorth new ].
	5 = anInteger ifTrue: [ ^ MJWhite new ].
	6 = anInteger ifTrue: [ ^ MJGreen new ].
	7 = anInteger ifTrue: [ ^ MJRed new ]
]

{ #category : #creation }
MJFace class >> num: anInteger [ 
	^ self fromNumber: anInteger.
]

{ #category : #visualization }
MJFace >> image: aView [
	<gtView>
	^ self visualize image: aView
]

{ #category : #predicates }
MJFace >> isSpecial [
	^ true
]

{ #category : #accessing }
MJFace >> name [
	^ self subclassResponsibility
]

{ #category : #predicates }
MJFace >> runsWith: tile [
	^ false
]

{ #category : #predicates }
MJFace >> sameAs: tile [
	^ self suit = tile suit
]

{ #category : #accessing }
MJFace >> suit [
	^ self name
]

{ #category : #equality }
MJFace >> uniqueHash [
	^ self name hash
]

{ #category : #equality }
MJFace >> value [
	^ self name
]

{ #category : #visualization }
MJFace >> visualize [
	^ MJTileVisualizerTenhou honor: self
]
