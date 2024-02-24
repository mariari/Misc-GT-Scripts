Class {
	#name : #MJTileVisualizer,
	#superclass : #Object,
	#instVars : [
		'size',
		'path'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJTileVisualizer class >> convertKind: string [
	#east = string ifTrue: [ ^ '1' ].
	#south = string ifTrue: [ ^ '2' ].
	#west = string ifTrue: [ ^ '3' ].
	#north = string ifTrue: [ ^ '4' ].
	#white = string ifTrue: [ ^ '5' ].
	#green = string ifTrue: [ ^ '6' ].
	#red = string ifTrue: [ ^ '7' ].
	^ '7'
]

{ #category : #accessing }
MJTileVisualizer class >> default [

 ^ self new default
]

{ #category : #accessing }
MJTileVisualizer class >> fileType [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTileVisualizer class >> honor: kind [
	^ self new
		initalizePath: self new defaultPath / 'honors' / ((self convertKind: kind) , self fileType)
]

{ #category : #accessing }
MJTileVisualizer class >> suit: kind number: num [
	^ self new initalizePath: self new defaultPath / kind / (num asString , self fileType)
]

{ #category : #accessing }
MJTileVisualizer >> asBlElement [
	| background |
	background := BlImageBackground image: self form.
	^ BlElement new
		geometry: BlRoundedRectangleGeometry new;
		size: size;
		background: background;
		yourself
]

{ #category : #accessing }
MJTileVisualizer >> default [
	^ self initalizePath: self defaultPath / 'man' / ('1' , self class fileType)
]

{ #category : #accessing }
MJTileVisualizer >> form [
	^ Form fromBinaryStream: path binaryReadStream
]

{ #category : #accessing }
MJTileVisualizer >> image: aView [
	<gtView> 
	^ aView explicit
		title: 'Image';
		stencil: [self form]
]

{ #category : #accessing }
MJTileVisualizer >> initalizePath: p [
	size := self defaultSize.
	path := p.
	^ self
]
