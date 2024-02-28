Class {
	#name : #MJMan,
	#superclass : #MJNumber,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJMan class >> characterRepresentation [
	^ $m
]

{ #category : #creation }
MJMan class >> dora [
	^ MJDoraMan
]

{ #category : #accessing }
MJMan class >> suit [
	^ #man
]

{ #category : #equality }
MJMan >> valueSort [
	^ (2 bitShift: 7) * self number
]
