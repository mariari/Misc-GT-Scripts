Class {
	#name : #NockBinaryAtom,
	#superclass : #ByteArray,
	#type : #bytes,
	#category : #'Urbit-Core-Nock'
}

{ #category : #'as yet unclassified' }
NockBinaryAtom >> asBitString [
	^ String
		streamContents: [ :stream | 
			self
				do: [ :each | 
					each printOn: stream base: 2.
					stream space ] ]
]

{ #category : #conversion }
NockBinaryAtom >> asIntegerAtom [
	"Find a better name, asInteger is taken and I'd rather not override it"
	
	^ self reversed asInteger asNock
]

{ #category : #bits }
NockBinaryAtom >> bitSize [
	"Gets the bitSize of the byteArray assuming a bigEndian encoding"

	^ (self at: 1) highBit + ((self size - 1) * 8)
]

{ #category : #'as yet unclassified' }
NockBinaryAtom >> gtJamInfo: aView [
	<gtView>
	^ aView columnedList
		title: 'Atom Info';
		priority: 10;
		items: [ {{'Atom'.
					self asIntegerAtom.
					self asBitString}.
				{'Number of bits'.
					self bitSize.
					(NockBinaryAtom newFromArray: self bitSize asByteArray) asBitString}.
				{'bit length'.
					self bitSize highBit.
					(NockBinaryAtom newFromArray: self bitSize highBit asByteArray) asBitString}} ];
		column: 'Key' text: #first;
		column: 'Value' text: #second;
		column: 'Bits' text: #third;
		send: #second
]

{ #category : #predicates }
NockBinaryAtom >> isAtom [
	^ true
]

{ #category : #predicates }
NockBinaryAtom >> isCell [
	^ false
]
