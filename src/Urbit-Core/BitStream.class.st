"
I am a bit stream.

I work only on streams backed by an {{gtClass:name=ByteArray}}.

Since we only work on ByteArrays an {{gtMethod:name=BitStream>>empty}} is given
"
Class {
	#name : #BitStream,
	#superclass : #WriteStream,
	#instVars : [
		'bitOffset',
		'bitBuffer'
	],
	#category : #'Urbit-Core-Base'
}

{ #category : #creation }
BitStream class >> empty [
	^ self on: ByteArray new
]

{ #category : #'private - writing' }
BitStream >> ingestBit: aBit [
	(0 = aBit or: 1 = aBit) ifFalse: [ ^ self error: 'A bit must be given' ].
	bitOffset := 1 + bitOffset.
	bitBuffer := (bitBuffer << 1) + aBit
]

{ #category : #writing }
BitStream >> nextBitsPutAll: aCollection [
	" TODO combine all the bits into bytes then write those bytes, should be more efficient"

	aCollection do: [ :aBit | self nextPutBit: aBit ].
	^ aCollection
]

{ #category : #writing }
BitStream >> nextBytesPutAll: aCollection [
	^ self nextPutAll: aCollection
]

{ #category : #writing }
BitStream >> nextPut: anInteger [
	"We assume the object coming in is byte paded, so we inject our bits into the front before
	calling the write that should be there.
	
	See WriteStream>>nextPut: for the documentation"

	| byteToPut return |
	bitOffset isZero ifTrue: [ ^ super nextPut: byteToPut ].
	byteToPut := (anInteger >> bitOffset << bitOffset) + bitBuffer.
	return := super nextPut: byteToPut.	"We try putting the byte first in case it errors"
	bitBuffer := (2 raisedTo: bitOffset) - 1 bitAnd: anInteger.
	^ return
]

{ #category : #writing }
BitStream >> nextPutAll: aCollection [
	bitOffset isZero ifTrue: [ ^ super nextPutAll: aCollection ].
	aCollection do: [ :aByte | self nextPut: aByte ].	"We can do a few things here. I chose to just do: #nextPut: as otherwise we'd need to allocate another ByteArray"
	^ aCollection
]

{ #category : #writing }
BitStream >> nextPutBit: aBit [
	self ingestBit: aBit.
	bitOffset = 8
		ifTrue: [ self nextPut: bitBuffer.
			self onByteBoundary ].
	^ aBit
]

{ #category : #'instance creation' }
BitStream >> on: aCollection [
	self onByteBoundary.
	^ super on: aCollection
]

{ #category : #initialization }
BitStream >> onByteBoundary [
	bitOffset := 0.
	bitBuffer := 0
]

{ #category : #initialization }
BitStream >> reset [
	"Refer to the comment in PositionableStream|reset."

	self onByteBoundary.
	^ super reset
]

{ #category : #positioning }
BitStream >> resetContents [
	"Set the position and limits to 0."

	self onByteBoundary.
	super resetContents
]

{ #category : #positioning }
BitStream >> resetToStart [
	self onByteBoundary.
	super resetToStart
]

{ #category : #'instace creation' }
BitStream >> with: aCollection [
	"Since we are starting with a collection that is padded to a byte we should stay at 0"

	self onByteBoundary.
	^ super with: aCollection
]
