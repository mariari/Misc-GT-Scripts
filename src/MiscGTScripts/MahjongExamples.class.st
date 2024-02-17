Class {
	#name : #MahjongExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-Examples'
}

{ #category : #accessing }
MahjongExamples >> allSuits: ablock [
	^ (1 to: 9) collect: ablock
]

{ #category : #accessing }
MahjongExamples >> basicGraph: tiles edges: pairs [
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles.
	view edges connectAssociations: pairs.
	view layout tree.
	view edges fromCenterBottom.
	^ view
]

{ #category : #accessing }
MahjongExamples >> handExample [
	<gtExample>
	| view tiles pairs |
	view := GtMondrian new.

	tiles := {(MJHand hand: { MJFace 東. MJFace 中}) . MJFace 東 }.

	pairs := {(tiles at: 1) -> (tiles at: 2).}.

	^ self basicGraph: tiles edges: pairs
]

{ #category : #accessing }
MahjongExamples >> mans [
	^ self allSuits:[ :each | MJNumber man: each ]
]

{ #category : #accessing }
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
MahjongExamples >> versitility [
	<gtExample>
	| view tiles pairs honor |
	view := GtMondrian new.

	tiles := self pins asOrderedCollection.

	honor := MJFace 中.

	pairs := {(tiles at: 1) -> (tiles at: 8).
			(tiles at: 1) -> (tiles at: 2).
			(tiles at: 9) -> (tiles at: 8).
			(tiles at: 9) -> (tiles at: 2).
			(tiles at: 2) -> (tiles at: 3).
			(tiles at: 2) -> (tiles at: 4).
			(tiles at: 2) -> (tiles at: 5).
			(tiles at: 2) -> (tiles at: 6).
			(tiles at: 2) -> (tiles at: 7).
			(tiles at: 8) -> (tiles at: 3).
			(tiles at: 8) -> (tiles at: 4).
			(tiles at: 8) -> (tiles at: 5).
			(tiles at: 8) -> (tiles at: 6).
			(tiles at: 8) -> (tiles at: 7).
			honor -> (tiles at: 1).
			honor -> (tiles at: 9)}.

	tiles addFirst: honor.
	^ self basicGraph: tiles edges: pairs
]

{ #category : #accessing }
MahjongExamples >> zhus [
	^ self allSuits:[ :each | MJNumber zhu: each ]
]
