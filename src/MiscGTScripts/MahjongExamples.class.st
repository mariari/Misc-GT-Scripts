Class {
	#name : #MahjongExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-Examples'
}

{ #category : #tiles }
MahjongExamples >> allSuits: ablock [
	^ (1 to: 9) collect: ablock
]

{ #category : #accessing }
MahjongExamples >> basicGraph: tiles edges: pairs [
	^ self
		basicGraph: tiles
		edges: pairs
		withView: self defaultGraph
]

{ #category : #accessing }
MahjongExamples >> basicGraph: tiles edges: pairs withView: view [
	"Basic Graph view"

	self basicGraphNodes: tiles withView: view.
	self basicGraphEdges: pairs withView: view.
	self spreadTree: view.
	view edges fromCenterBottom.
	^ view
]

{ #category : #accessing }
MahjongExamples >> basicGraphEdges: pairs withView: view [
	| edgeStyling |
	edgeStyling := self defaultStyling: (Color blue alpha: 1.0).
	view edges
		stencil: edgeStyling;
		connectAssociations: pairs
]

{ #category : #accessing }
MahjongExamples >> basicGraphNodes: tiles withView: view [
	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles
]

{ #category : #accessing }
MahjongExamples >> defaultGraph [
	<gtExample>
	| view |
	view := GtMondrian new.
	view edges fromCenterBottom.
	^ view
]

{ #category : #accessing }
MahjongExamples >> defaultStyling: color [
	^ [ BlBezierElement new
		border: (BlBorder paint: color width: 5);
		toHead: (BlArrowheadSimpleArrow new background: color) ]
]

{ #category : #accessing }
MahjongExamples >> handExample [
	<gtExample>
	| view tiles pairs |
	view := GtMondrian new.

	tiles := {MJHand
				with: {MJFace 東.
						MJFace 中}.
			MJFace 東}.

	pairs := {(tiles at: 1) -> (tiles at: 2)}.

	^ self basicGraph: tiles edges: pairs
]

{ #category : #tiles }
MahjongExamples >> mans [
	<gtExample>
	^ self allSuits:[ :each | MJNumber man: each ]
]

{ #category : #accessing }
MahjongExamples >> pairGet [
	<gtExample>
	| view z1 z2 |
	view := self defaultGraph.
	z1 := '23s' asMJGroup.
	z2 := '45s' asMJGroup.
	{ z1 . z2 } do: [:e | e visualizeAccepts: view].

	^ view
]

{ #category : #tiles }
MahjongExamples >> pins [
	<gtExample>
	^ self allSuits: [ :each | MJNumber pin: each ]
]

{ #category : #accessing }
MahjongExamples >> runWaits [
	<gtExample>
	| tiles pairs five |
	tiles := self mans asOrderedCollection.
	five := MJHand with: (tiles copyFrom: 2 to: 6).



	pairs := {five -> (tiles at: 1).
			five -> (tiles at: 4).
			five -> (tiles at: 7)}.

	^ self
		basicGraph: {five.
				tiles at: 1.
				tiles at: 4.
				tiles at: 7}
		edges: pairs
]

{ #category : #accessing }
MahjongExamples >> safeTiles [
	<gtExample>
	| tiles pairs |
	tiles := self zhus asOrderedCollection.

	pairs := {(tiles at: 6) -> (tiles at: 3).
			(tiles at: 6) -> (tiles at: 9).
			(tiles at: 5) -> (tiles at: 2).
			(tiles at: 5) -> (tiles at: 8).
			(tiles at: 4) -> (tiles at: 1).
			(tiles at: 4) -> (tiles at: 7)}.

	^ self basicGraph: tiles edges: pairs
]

{ #category : #accessing }
MahjongExamples >> simpleAcceptance [
	<gtExample>
	^ '23456m' asMJHand
]

{ #category : #accessing }
MahjongExamples >> simpleAccepting [
	<gtExample>
	^ '23m' asMJGroup
]

{ #category : #accessing }
MahjongExamples >> simpleGroup [
	<gtExample>
	^ '5s' asMJGroup
]

{ #category : #accessing }
MahjongExamples >> simpleGroups [
	<gtExample>
	^ (MJGroups with: '12246799p' asMJHand tiles)
]

{ #category : #accessing }
MahjongExamples >> spreadTree: view [
	| layout |
	layout := view layout tree.
	layout
		levelDistance: 50;
		nodeDistance: 50
]

{ #category : #accessing }
MahjongExamples >> versitility [
	<gtExample>
	| tiles pairs honor |
	tiles := self pins asOrderedCollection.

	honor := MJFace 中.

	pairs := {(tiles at: 1) -> (tiles at: 8).
			(tiles at: 9) -> (tiles at: 2).
			(tiles at: 2) -> (tiles at: 5).
			(tiles at: 2) -> (tiles at: 6).
			(tiles at: 2) -> (tiles at: 7).
			(tiles at: 8) -> (tiles at: 3).
			(tiles at: 8) -> (tiles at: 4).
			(tiles at: 8) -> (tiles at: 5).
			(tiles at: 8) -> (tiles at: 6).
			honor -> (tiles at: 1).
			honor -> (tiles at: 9)}.

	tiles addFirst: honor.
	^ self basicGraph: tiles edges: pairs
]

{ #category : #accessing }
MahjongExamples >> versitilityHand [
	<gtExample>
	| tiles pairs honor second third best |
	tiles := self pins asOrderedCollection.

	honor := MJFace 中.
	second := MJHand
			with: {tiles at: 1.
					tiles at: 9}.
	third := MJHand
			with: {tiles at: 2.
					tiles at: 8}.
	best := MJHand with: (tiles copyFrom: 3 to: 7).


	pairs := {honor -> second.
			second -> third.
			third -> best}.


	^ self
		basicGraph: {honor.
				second.
				third.
				best}
		edges: pairs
]

{ #category : #tiles }
MahjongExamples >> zhus [
	<gtExample>
	^ self allSuits:[ :each | MJNumber zhu: each ]
]
