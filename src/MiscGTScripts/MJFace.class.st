Class {
	#name : #MJFace,
	#superclass : #MJTile,
	#instVars : [
		'name'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJFace class >> convertKind: number [
	"convert into array indexing"

	1 = number ifTrue: [ ^ self east ].
	2 = number ifTrue: [ ^ self south ].
	3 = number ifTrue: [ ^ self west ].
	4 = number ifTrue: [ ^ self north ].
	5 = number ifTrue: [ ^ self white ].
	6 = number ifTrue: [ ^ self green ].
	7 = number ifTrue: [ ^ self red ].
	^ Error signal: 'invalid conversion'
]

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
MJFace class >> num: anInteger [ 
	^ self convertKind: anInteger.
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

{ #category : #predicates }
MJFace >> isSpecial [
	^ true
]

{ #category : #accessing }
MJFace >> name [
	^ name
]

{ #category : #accessing }
MJFace >> new: kind [
	name := kind
]

{ #category : #predicates }
MJFace >> runsWith: tile [
	^ false
]

{ #category : #predicates }
MJFace >> sameAs: tile [
	^ self class = tile class and: [ name = tile name ]
]

{ #category : #accessing }
MJFace >> uniqueHash [
	^ name hash
]

{ #category : #accessing }
MJFace >> valueSort [
	'east' = name ifTrue: [ ^ 401 ].
	'south' = name ifTrue: [ ^ 402 ].
	'west' = name ifTrue: [ ^ 403 ].
	'north' = name ifTrue: [ ^ 404 ].
	'white' = name ifTrue: [ ^ 405 ].
	'green' = name ifTrue: [ ^ 406 ].
	'red' = name ifTrue: [ ^ 407 ].
]

{ #category : #accessing }
MJFace >> visualize [
	^ MJTileVisualizerTenhou honor: name
]
