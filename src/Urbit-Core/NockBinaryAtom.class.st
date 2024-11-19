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
					stream space ].
			stream ensureNoSpace ]
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
	| lenAtom lenLen |
	^ aView columnedList
		title: 'Atom Info';
		priority: 10;
		items: [ lenAtom := (NockBinaryAtom newFromArray: self bitSize asByteArray) asBitString.
			lenAtom := lenAtom copyFrom: 2 to: lenAtom size.
			lenLen := '1' , ('0' repeat: self bitSize highBit).
			{{'Atom'.
					self asIntegerAtom.
					self reversed asBitString}.
				{'UTF8'.
					[ ZnUTF8Encoder new decodeBytes: self ]
						on: ZnCharacterEncodingError
						do: [ :exception | exception ].
					'N/A'}.
				{'Number of bits'.
					self bitSize.
					lenAtom}.
				{'bits length'.
					self bitSize highBit.
					lenLen}.
				{'Jam'.
					self reversed asBitString , '-' , lenAtom , '-' , lenLen.
					'Endian Reverse'}} ];
		column: 'Key' text: #first;
		column: 'Value' text: #second;
		column: 'Jammed Layout' text: #third;
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
