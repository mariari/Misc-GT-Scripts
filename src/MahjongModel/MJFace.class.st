Class {
	#name : #MJFace,
	#superclass : #MJTile,
	#category : #'MahjongModel-Tiles'
}

{ #category : #representations }
MJFace class >> characterRepresentation [
	^ $z
]

{ #category : #creation }
MJFace class >> convertKind: aString [
	^ self subclasses
		detect: [ :each | aString = each suit ]
		ifFound: #new
		ifNone: [ NotFound error ]
]

{ #category : #creation }
MJFace class >> fromNumber: anInteger [
	^ self subclasses
		detect: [ :each | anInteger = each numericRepresentation ]
		ifFound: #new
		ifNone: [ NotFound error ]
]

{ #category : #creation }
MJFace class >> num: anInteger [ 
	^ self fromNumber: anInteger.
]

{ #category : #representations }
MJFace class >> numericRepresentation [
	^ self subclassResponsibility
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

{ #category : #representations }
MJFace >> numericRepresentation [
	^ self class numericRepresentation
]

{ #category : #predicates }
MJFace >> runsWith: tile [
	^ false
]

{ #category : #predicates }
MJFace >> sameAs: tile [
	^ self suit = tile suit
]

{ #category : #equality }
MJFace >> uniqueHash [
	^ self suit hash
]

{ #category : #equality }
MJFace >> value [
	^ self suit
]

{ #category : #visualization }
MJFace >> visualize [
	^ MJTileVisualizerTenhou honor: self
]
