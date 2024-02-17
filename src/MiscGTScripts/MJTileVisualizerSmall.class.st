Class {
	#name : #MJTileVisualizerSmall,
	#superclass : #MJTileVisualizer,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJTileVisualizerSmall class >> convertKind: string [
	'east' = string ifTrue: [ ^ '1' ].
	'south' = string ifTrue: [ ^ '2' ].
	'west' = string ifTrue: [ ^ '3' ].
	'north' = string ifTrue: [ ^ '4' ].
	'white' = string ifTrue: [ ^ '5' ].
	'green' = string ifTrue: [ ^ '6' ].
	'red' = string ifTrue: [ ^ '7' ]
]

{ #category : #accessing }
MJTileVisualizerSmall class >> default [

 ^ self new default
]

{ #category : #accessing }
MJTileVisualizerSmall class >> honor: kind [
	^ self new
		initalizePath: self new defaultPath / 'honors' / (self convertKind: kind asString , '.gif')
]

{ #category : #accessing }
MJTileVisualizerSmall class >> suit: kind number: num [
	^ self new initalizePath: self new defaultPath / kind / (num asString , '.gif')
]

{ #category : #accessing }
MJTileVisualizerSmall >> default [
	^ self initalizePath: self defaultPath / 'man' / '1.gif'
]

{ #category : #accessing }
MJTileVisualizerSmall >> defaultPath [
	^ (GtGitRepository forClass: Mahjong) icebergRepository repositoryDirectory
		/ 'images' / 'mahjong' / 'small'
]

{ #category : #accessing }
MJTileVisualizerSmall >> defaultSize [
	^ 15 @ 21
]

{ #category : #accessing }
MJTileVisualizerSmall >> initalizePath: p [
	size := self defaultSize.
	path := p.
	^ self
]

{ #category : #accessing }
MJTileVisualizerSmall >> suit: kind number: num [

^ self
]
