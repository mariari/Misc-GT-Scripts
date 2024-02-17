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
