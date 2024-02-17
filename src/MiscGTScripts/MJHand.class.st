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
	| view |
	view := GtMondrian new.
	
	view nodes shape: [ :each | each asBlElement ]; with: tiles.
	^ view
]

{ #category : #accessing }
MJHand >> image: aView [
	<gtView>
	
	^ aView explicit
		title: 'Image';
		stencil: [self asBlElement]
]

{ #category : #accessing }
MJHand >> withHand: aCollection [
	tiles := aCollection
]
