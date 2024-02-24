Class {
	#name : #MJTiles,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJTiles class >> with: aCollection [
	^ self subclassResponsibility
]

{ #category : #visualization }
MJTiles >> asBlElement [
	| view ele |
	view := GtMondrian new.

	view nodes
		shape: [ :each | each asBlElement ];
		with: self tiles.
	ele := view asElement.
	ele padding: BlInsets empty.
	ele size: self tileSize.
	ele layout horizontal columnCount: tiles size.
	^ ele
]

{ #category : #visualization }
MJTiles >> image: aView [
	<gtView>
	^ aView mondrian
		title: 'Image';
		painting: [ :view |  self naturalLayout: view ]
]

{ #category : #visualization }
MJTiles >> naturalHandLayout [
	| view |
	view := self naturalLayout.
	view root layout horizontal columnCount: self tiles size.
	^ view
]

{ #category : #visualization }
MJTiles >> naturalLayout [
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :each | each asBlElement ];
		with: self tiles.
	^ view
]

{ #category : #visualization }
MJTiles >> naturalLayout: view [
	view nodes
		shape: [ :each | each asBlElement ];
		with: self tiles.
	^ view
]

{ #category : #sorting }
MJTiles >> sort [
	tiles := (tiles asSortedCollection: [ :a :b | a valueSort < b valueSort ]) asOrderedCollection.
	^ self
]

{ #category : #visualization }
MJTiles >> tileSize [
	| size |
	tiles ifEmpty: [ ^ 0 @ 0 ].
	size := (self tiles at: 1) visualize defaultSize.
	^ (size x * tiles size) @ size y
]

{ #category : #accessing }
MJTiles >> tiles [
	^ tiles
]

{ #category : #unique }
MJTiles >> unique [
	| set |
	set := PluggableSet new.
	set equalBlock: [ :a :b | a sameAs: b ].
	set hashBlock: [ :ele | ele uniqueHash ].
	tiles do: [ :tile | set add: tile ].
	tiles := set.
	self sort.
	^ self
]

{ #category : #equality }
MJTiles >> uniqueHash [
	^ self valueSort hash
]

{ #category : #equality }
MJTiles >> valueSort [
	"Fixup we need to shift the values by the index"
	| index | 
	index := 0.
	^ tiles inject: 0 into: [ :sum :b | index := index + 1. sum + (b valueSort * index) ]
]
