Class {
	#name : #MJHandKnown,
	#superclass : #MJHand,
	#instVars : [
		'groupings'
	],
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJHandKnown >> groups [
	^ groupings
]

{ #category : #creation }
MJHandKnown >> groups: size [
	groupings := size
]

{ #category : #accessing }
MJHandKnown >> pair [
	"maybe reconsider if true"

	^ true
]
