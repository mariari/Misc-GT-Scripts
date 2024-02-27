Class {
	#name : #MJZhu,
	#superclass : #MJNumber,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #creation }
MJZhu class >> dora [
	^ MJDoraZhu
]

{ #category : #accessing }
MJZhu >> suit [
	^ #zhu
]

{ #category : #equality }
MJZhu >> valueSort [
	^ (2 bitShift: 7 + 16) * self number
]
