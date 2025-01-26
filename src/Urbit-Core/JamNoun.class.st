Class {
	#name : #JamNoun,
	#superclass : #JamBaseData,
	#category : #'Urbit-Core-Nock'
}

{ #category : #annotation }
JamNoun >> annotateFullJam: jammedText paddingAdded: aPadding [
	(self tagSubtext: aPadding withKnownPadding: jammedText)
		underlineColor: Color lightMagenta.
	^ jammedText
]

{ #category : #annotation }
JamNoun >> tagLength [
	^ 2
]

{ #category : #'as yet unclassified' }
JamNoun >> tagSubtext: aPadding withKnownPadding: jammedText [
	^ jammedText
		from: (self paddedOffset: end - 2 paddingAdded: aPadding)
		to: (self paddedOffset: end paddingAdded: aPadding)
]
