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
		withView: GtMondrian new
]

{ #category : #accessing }
MahjongExamples >> basicGraph: tiles edges: pairs withView: view [
	"Basic Graph view"

	| edgeStyling |
	edgeStyling := self defaultStyling: (Color blue alpha: 1.0).

	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles.
	view edges
		stencil: edgeStyling;
		connectAssociations: pairs.
	self spreadTree: view.
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
	| view tiles pairs z234 z456 z41 z42 z1 z7 |
	view := GtMondrian new.

	z234 := MJHand
			with: {MJNumber zhu: 2.
					MJNumber zhu: 3}.
	z456 := MJHand
			with: {MJNumber zhu: 5.
					MJNumber zhu: 6}.
	z41 := MJNumber zhu: 4.
	z42 := z41 clone.
	z1 := MJNumber zhu: 1.
	z7 := MJNumber zhu: 7.


	tiles := {z234. z456. z41. z1. z7. z42}.

	pairs := {z234 -> z1.z234 -> z41.z456 -> z42. z456 -> z7. }.

	^ self basicGraph: tiles edges: pairs
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
