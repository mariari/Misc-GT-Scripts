Class {
	#name : #MahjongExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-Examples'
}

{ #category : #tiles }
MahjongExamples >> allSuits: ablock [
	^ (1 to: 9) collect: ablock
]

{ #category : #visualization }
MahjongExamples >> basicGraph: tiles edges: pairs [
	^ self
		basicGraph: tiles
		edges: pairs
		withView: self defaultGraph
]

{ #category : #visualization }
MahjongExamples >> basicGraph: tiles edges: pairs withView: view [
	"Basic Graph view"

	self basicGraphNodes: tiles withView: view.
	self basicGraphEdges: pairs withView: view.
	self spreadTree: view.
	view edges fromCenterBottom.
	^ view
]

{ #category : #visualization }
MahjongExamples >> basicGraphEdges: pairs withView: view [
	| edgeStyling |
	edgeStyling := self defaultStyling: (Color blue alpha: 1.0).
	view edges
		stencil: edgeStyling;
		connectAssociations: pairs
]

{ #category : #visualization }
MahjongExamples >> basicGraphNodes: tiles withView: view [
	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles
]

{ #category : #example }
MahjongExamples >> defaultGraph [
	<gtExample>
	| view |
	view := GtMondrian new.
	view edges fromCenterBottom.
	^ view
]

{ #category : #visualization }
MahjongExamples >> defaultStyling: color [
	^ [ BlBezierElement new
		border: (BlBorder paint: color width: 5);
		toHead: (BlArrowheadSimpleArrow new background: color) ]
]

{ #category : #example }
MahjongExamples >> groupExample [
	<gtExample>
	| val |
	val := '23s' asMJGroup.
	self assert: val acceptsTiles valueSort equals: '14s' asMJHand valueSort.
	^ val
]

{ #category : #example }
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

{ #category : #example }
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

{ #category : #example }
MahjongExamples >> runWaits [
	<gtExample>
	| run |
	run := '23456m' asMJHand.
	self assert: run acceptsComplete tiles size equals: 3.
	^ run visualizeAcceptsComplete: self defaultGraph
]

{ #category : #example }
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

{ #category : #example }
MahjongExamples >> simpleAcceptance [
	<gtExample>
	^ '23456m' asMJHand
]

{ #category : #example }
MahjongExamples >> simpleAccepting [
	<gtExample>
	^ '23m' asMJGroup
]

{ #category : #example }
MahjongExamples >> simpleAccepts [
	<gtExample>
	| tiles |
	tiles := (MJGroups with: '55567812p' asMJHand tiles) accepts.

	self assert: tiles tiles size equals: 2.
	self assert: (tiles tiles at: 1) value equals: 3.
	self assert: (tiles tiles at: 2) value equals: 5.
	^ tiles
]

{ #category : #example }
MahjongExamples >> simpleGroup [
	<gtExample>
	^ '5s' asMJGroup
]

{ #category : #example }
MahjongExamples >> simpleGroups [
	<gtExample>
	^ (MJGroups with: '12246799p' asMJHand tiles)
]

{ #category : #example }
MahjongExamples >> spreadTree: view [
	| layout |
	layout := view layout tree.
	layout
		levelDistance: 50;
		nodeDistance: 50
]

{ #category : #accessing }
MahjongExamples >> testGroupInvalid [
	<gtExample>
	| group |
	group := MJGroups with: '2346p' asMJHand tiles.
	group addIndependently: (MJNumber pin: 4).
	self assert: group valid not.


	group := MJGroups with: '23466p' asMJHand tiles.
	group addIndependently: (MJNumber pin: 1).
	self assert: group valid.
	
	group := MJGroups with: '23466p' asMJHand tiles.
	group addGroupIndependently: ('66p' asMJGroup).
	
	self assert: group valid not.
	^ group
]

{ #category : #example }
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

{ #category : #example }
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
