Class {
	#name : #MJMan,
	#superclass : #MJNumber,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #creation }
MJMan class >> dora [
	^ MJDoraMan
]

{ #category : #accessing }
MJMan >> suit [
	^ #man
]

{ #category : #equality }
MJMan >> valueSort [
	^ (2 bitShift: 7) * self number
]
