Class {
	#name : #MJTiles,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJTiles class >> with: aCollection [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTiles >> asBlElement [
	| view ele |
	view := GtMondrian new.

	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles.
	ele := view asElement.
	ele padding: BlInsets empty.
	ele size: self tileSize.
	ele layout horizontal columnCount: tiles size.
	^ ele
]

{ #category : #accessing }
MJTiles >> image: aView [
	<gtView>
	^ aView mondrian
		title: 'Image';
		painting: [ :view |  self naturalLayout: view ]
]

{ #category : #accessing }
MJTiles >> naturalHandLayout [
	| view |
	view := self naturalLayout.
	view root layout horizontal columnCount: tiles size.
	^ view
]

{ #category : #accessing }
MJTiles >> naturalLayout [
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles.
	^ view
]

{ #category : #accessing }
MJTiles >> naturalLayout: view [
	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles.
	^ view
]

{ #category : #accessing }
MJTiles >> sort [
	tiles := tiles asSortedCollection: [ :a :b | a valueSort < b valueSort ].
	^ self
]

{ #category : #accessing }
MJTiles >> tileSize [
	| size |
	tiles ifEmpty: [ ^ 0 @ 0 ].
	size := (tiles at: 1) visualize defaultSize.
	^ (size x * tiles size) @ size y
]

{ #category : #accessing }
MJTiles >> tiles [
	^ tiles
]

{ #category : #accessing }
MJTiles >> unique [
	| set |
	set := PluggableSet new.
	set equalBlock: [ :a :b | a sameAs: b ].
	set hashBlock: [ :ele | ele uniqueHash ].
	tiles do: [ :tile | set add: tile ].
	tiles := set asSortedCollection: [ :a :b | a valueSort < b valueSort ].
	self sort.
	^ self
]
