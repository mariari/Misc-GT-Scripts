Class {
	#name : #MahjongExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-Examples'
}

{ #category : #accessing }
MahjongExamples >> basicGraph [
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
MahjongExamples >> versitility [
	<gtExample>
	| view tiles pairs honor |
	view := GtMondrian new.

	tiles := ((1 to: 9) collect: [ :each | MJNumber pin: each ])
			asOrderedCollection.

	honor := MJFace 東.


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
