Class {
	#name : #MJTileVisualizer,
	#superclass : #Object,
	#instVars : [
		'size',
		'path'
	],
	#category : #'MahjongModel-Graphics'
}

{ #category : #creation }
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
		initalizePath: self new defaultPath / 'honors'
				/ (kind numericRepresentation asString , self fileType)
]

{ #category : #accessing }
MJTileVisualizer class >> suit: kind number: num [
	^ self new initalizePath: self new defaultPath / kind / (num asString , self fileType)
]

{ #category : #visual }
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
MJTileVisualizer >> defaultPath [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTileVisualizer >> defaultSize [
	^ self subclassResponsibility
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
