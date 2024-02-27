Class {
	#name : #MJPin,
	#superclass : #MJNumber,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #creation }
MJPin class >> dora [
	^ MJDoraPin
]

{ #category : #accessing }
MJPin >> suit [
	^ #pin
]

{ #category : #equality }
MJPin >> valueSort [
	^ (2 bitShift: 7 + 8) * self number
]
