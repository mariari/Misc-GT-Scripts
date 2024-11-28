Class {
	#name : #JamAtomKind,
	#superclass : #JamBaseData,
	#instVars : [
		'lenSize'
	],
	#category : #'Urbit-Core-Nock'
}

{ #category : #annotation }
JamAtomKind >> annotateFullJam: jammedText paddingAdded: aPadding [
	(self atomSubtext: jammedText withKnownPadding: aPadding)
		underlineColor: Color red.
	(self lengthSutext: aPadding withKnownPadding: jammedText)
		underlineColor: Color blue.
	(self lengthOfLengthSubtext: aPadding withKnownPadding: jammedText)
		underlineColor: Color green.
	(self tagSubtext: aPadding withKnownPadding: jammedText)
		underlineColor: Color brown.
	^ jammedText
]

{ #category : #annotation }
JamAtomKind >> atomPosition [
	^ end - self tagLength - (2 * lenSize)
]

{ #category : #annotation }
JamAtomKind >> atomSubtext: jammedText withKnownPadding: aPadding [
	^ jammedText
		from: (self paddedOffset: start + 1 paddingAdded: aPadding)
		to: (self paddedOffset: self atomPosition paddingAdded: aPadding)
]

{ #category : #accessing }
JamAtomKind >> lenSize [
	^ lenSize
]

{ #category : #accessing }
JamAtomKind >> lenSize: anObject [
	lenSize := anObject
]

{ #category : #annotation }
JamAtomKind >> lengthOfLengthPosition [
	^ self lengthPosition + lenSize + 1
]

{ #category : #annotation }
JamAtomKind >> lengthOfLengthSubtext: aPadding withKnownPadding: jammedText [
	^ jammedText
		from: (self paddedOffset: self lengthPosition + 1 paddingAdded: aPadding)
		to: (self paddedOffset: self lengthOfLengthPosition paddingAdded: aPadding)
]

{ #category : #annotation }
JamAtomKind >> lengthPosition [
	^ self atomPosition + lenSize - 1
]

{ #category : #annotation }
JamAtomKind >> lengthSutext: aPadding withKnownPadding: jammedText [
	^ jammedText
		from: (self paddedOffset: self atomPosition + 1 paddingAdded: aPadding)
		to: (self paddedOffset: self lengthPosition paddingAdded: aPadding)
]

{ #category : #annotation }
JamAtomKind >> tagSubtext: aPadding withKnownPadding: jammedText [
	^ jammedText
		from: (self paddedOffset: self lengthOfLengthPosition + 1 paddingAdded: aPadding)
		to: (self paddedOffset: end paddingAdded: aPadding)
]
