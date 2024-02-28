Class {
	#name : #MJZhu,
	#superclass : #MJNumber,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJZhu class >> characterRepresentation [
	^ $s
]

{ #category : #creation }
MJZhu class >> dora [
	^ MJDoraZhu
]

{ #category : #accessing }
MJZhu class >> suit [
	^ #zhu
]

{ #category : #equality }
MJZhu >> valueSort [
	^ (2 bitShift: 7 + 16) * self number
]
