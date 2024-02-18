Class {
	#name : #MJHand,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJHand class >> hand: aCollection [
	^ self new withHand: aCollection
]

{ #category : #accessing }
MJHand >> asBlElement [
	| view ele |
	view := GtMondrian new.

	view nodes
		shape: [ :each | each asBlElement ];
		with: tiles.
	ele := view asElement.
	ele padding: BlInsets empty.
	ele size: self tileSize.
	^ ele
]

{ #category : #accessing }
MJHand >> image: aView [
	<gtView>
	
	^ aView explicit
		title: 'Image';
		stencil: [self asBlElement]
]

{ #category : #accessing }
MJHand >> tileSize [
	| size |
	tiles ifEmpty: [ ^ 0 @ 0 ].
	size := (tiles at: 1) visualize defaultSize.
	^ (size x * tiles size) @ size y
]

{ #category : #accessing }
MJHand >> withHand: aCollection [
	tiles := aCollection
]
