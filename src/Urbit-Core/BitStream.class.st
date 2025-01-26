"
I am a bit stream.

I work only on streams backed by an {{gtClass:name=ByteArray}}.

Since we only work on ByteArrays an {{gtMethod:name=BitStream class>>empty}} is given
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

{ #category : #accessing }
BitStream >> currentOffset [
	^ bitOffset
]

{ #category : #accessing }
BitStream >> currentOffsetWord [
	^ bitBuffer
]

{ #category : #converting }
BitStream >> finalizeWithBytePaddingStart [
	"pad the byte array to having bits at the front"

	"This copies the data 2 times, which is quite bad. 
	
	1. for making a new array but shifting every bytes
	2. for calling self contents for getting the appropriate array
	
	With a bit of work we can remove 2. but a new structure is needed to remove 1."

	| newStream newContents oldContents |
	oldContents := self contents.
	bitOffset = 0 ifTrue: [ ^ oldContents ].
	newContents := collection species new: oldContents size + 1.
	newStream := BitStream on: newContents.
	8 - bitOffset timesRepeat: [ newStream nextPutBit: 0 ].
	newStream << oldContents.
	bitOffset
		to: 1
		by: -1
		do: [ :index | newStream nextPutBit: (bitBuffer bitAt: index) ].
	^ newContents
]

{ #category : #'private - writing' }
BitStream >> ingestBit: aBit [
	(0 = aBit or: 1 = aBit) ifFalse: [ ^ self error: 'A bit must be given' ].
	bitOffset := 1 + bitOffset.
	bitBuffer := (bitBuffer << 1) + aBit
]

{ #category : #'as yet unclassified' }
BitStream >> isEmpty [
	^ super isEmpty and: [ bitOffset = 0 ]
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
	bitOffset isZero ifTrue: [ ^ super nextPut: anInteger ].
	byteToPut := (anInteger >> bitOffset) + (bitBuffer << (8 - bitOffset)).
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
		ifTrue: [ super nextPut: bitBuffer.
			self onByteBoundary ].
	^ aBit
]

{ #category : #writing }
BitStream >> nextPutBitStream: aBitStream [
	<argument: #aBitStream isKindOf: #BitStream>
	self nextPutAll: aBitStream contents.
	aBitStream currentOffset
		to: 1
		by: -1
		do: [ :i | self nextPutBit: (aBitStream currentOffsetWord bitAt: i) ]
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
