Class {
	#name : #JamBaseData,
	#superclass : #Object,
	#instVars : [
		'start',
		'end',
		'data'
	],
	#category : #'Urbit-Core-Nock'
}

{ #category : #annotation }
JamBaseData >> annotateFullJam: jammedText paddingAdded: aPadding [
	^ self subclassResponsibility
]

{ #category : #accessing }
JamBaseData >> data [
	^ data
]

{ #category : #accessing }
JamBaseData >> data: anObject [
	data := anObject
]

{ #category : #accessing }
JamBaseData >> end [
	^ end
]

{ #category : #accessing }
JamBaseData >> end: anObject [
	end := anObject
]

{ #category : #annotation }
JamBaseData >> paddedOffset: offset paddingAdded: padding [
	"We want to deal with the string we are annotated being broken into 8 bit bytes"

	| newOffset |
	newOffset := offset + padding.
	^ offset + (newOffset - 1 // 8)
]

{ #category : #accessing }
JamBaseData >> start [
	^ start
]

{ #category : #accessing }
JamBaseData >> start: anObject [
	start := anObject
]

{ #category : #annotation }
JamBaseData >> tagLength [
	^ self subclassResponsibility
]
