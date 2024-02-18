Class {
	#name : #MJFace,
	#superclass : #MJTile,
	#instVars : [
		'name'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJFace class >> default [
	^ self red
]

{ #category : #accessing }
MJFace class >> dong [
	^ self east
]

{ #category : #accessing }
MJFace class >> east [
	^ self new new: 'east'
]

{ #category : #accessing }
MJFace class >> green [
	^ self new new: 'green'
]

{ #category : #accessing }
MJFace class >> north [
	^ self new new: 'north'
]

{ #category : #accessing }
MJFace class >> red [
	^ self new new: 'red'
]

{ #category : #accessing }
MJFace class >> south [
	^ self new new: 'south'
]

{ #category : #accessing }
MJFace class >> west [
	^ self new new: 'west'
]

{ #category : #accessing }
MJFace class >> white [
	^ self new new: 'white'
]

{ #category : #accessing }
MJFace class >> 中 [
	^ self red
]

{ #category : #accessing }
MJFace class >> 北 [
	^ self north
]

{ #category : #accessing }
MJFace class >> 南 [
	^ self south
]

{ #category : #accessing }
MJFace class >> 東 [
	^ self east
]

{ #category : #accessing }
MJFace class >> 發 [
	^ self green
]

{ #category : #accessing }
MJFace class >> 白 [
	^ self white
]

{ #category : #accessing }
MJFace class >> 西 [
	^ self west
]

{ #category : #accessing }
MJFace >> image: aView [
	<gtView>
	^ self visualize image: aView
]

{ #category : #accessing }
MJFace >> new: kind [
	name := kind
]

{ #category : #accessing }
MJFace >> visualize [
	^ MJTileVisualizerTenhou honor: name
]
