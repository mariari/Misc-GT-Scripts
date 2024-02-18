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
	"Basic Graph view"

	| view edgeStyling |
	edgeStyling := self defaultStyling: (Color blue alpha: 1.0).

	view := GtMondrian new.

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
				hand: {MJFace 東.
						MJFace 中}.
			MJFace 東}.

	pairs := {(tiles at: 1) -> (tiles at: 2)}.

	^ self basicGraph: tiles edges: pairs
]

{ #category : #tiles }
MahjongExamples >> mans [
	^ self allSuits:[ :each | MJNumber man: each ]
]

{ #category : #tiles }
MahjongExamples >> pins [
	^ self allSuits:[ :each | MJNumber pin: each ]
]

{ #category : #accessing }
MahjongExamples >> safeTiles [
	<gtExample>
	| view tiles pairs |
	view := GtMondrian new.

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
	| view tiles pairs honor |
	view := GtMondrian new.

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
	| view tiles pairs honor second third best |
	view := GtMondrian new.

	tiles := self pins asOrderedCollection.

	honor := MJFace 中.
	second := MJHand
			hand: {tiles at: 1.
					tiles at: 9}.
	third := MJHand
			hand: {tiles at: 2.
					tiles at: 8}.
	best := MJHand hand: (tiles copyFrom: 3 to: 7).


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
	^ self allSuits:[ :each | MJNumber zhu: each ]
]
