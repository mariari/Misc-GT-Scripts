Class {
	#name : #MJFace,
	#superclass : #MJTile,
	#instVars : [
		'name'
	],
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #creation }
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

{ #category : #creation }
MJFace class >> default [
	^ self red
]

{ #category : #creation }
MJFace class >> dong [
	^ self east
]

{ #category : #creation }
MJFace class >> east [
	^ self new new: #east
]

{ #category : #creation }
MJFace class >> green [
	^ self new new: #green
]

{ #category : #creation }
MJFace class >> north [
	^ self new new: #north
]

{ #category : #creation }
MJFace class >> num: anInteger [ 
	^ self convertKind: anInteger.
]

{ #category : #creation }
MJFace class >> red [
	^ self new new: #red
]

{ #category : #creation }
MJFace class >> south [
	^ self new new: 'south'
]

{ #category : #creation }
MJFace class >> west [
	^ self new new: #west
]

{ #category : #creation }
MJFace class >> white [
	^ self new new: #white
]

{ #category : #creation }
MJFace class >> 中 [
	^ self red
]

{ #category : #creation }
MJFace class >> 北 [
	^ self north
]

{ #category : #creation }
MJFace class >> 南 [
	^ self south
]

{ #category : #creation }
MJFace class >> 東 [
	^ self east
]

{ #category : #creation }
MJFace class >> 發 [
	^ self green
]

{ #category : #creation }
MJFace class >> 白 [
	^ self white
]

{ #category : #creatoin }
MJFace class >> 西 [
	^ self west
]

{ #category : #visualization }
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

{ #category : #creation }
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
MJFace >> suit [
	^ self name
]

{ #category : #equality }
MJFace >> uniqueHash [
	^ name hash
]

{ #category : #equality }
MJFace >> value [
	^ name
]

{ #category : #equality }
MJFace >> valueSort [
	#east = name ifTrue: [ ^ 4294967296 ].
	#south = name ifTrue: [ ^ 4294967296 * 2 ].
	#west = name ifTrue: [ ^ 4294967296 * 3 ].
	#north = name ifTrue: [ ^ 4294967296 * 4 ].
	#white = name ifTrue: [ ^ 4294967296 * 5 ].
	#green = name ifTrue: [ ^ 4294967296 * 6 ].
	#red = name ifTrue: [ ^ 4294967296 * 7 ]
]

{ #category : #visualization }
MJFace >> visualize [
	^ MJTileVisualizerTenhou honor: name
]
