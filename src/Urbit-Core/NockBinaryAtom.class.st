Class {
	#name : #NockBinaryAtom,
	#superclass : #ByteArray,
	#type : #bytes,
	#traits : 'NockBehavior',
	#classTraits : 'NockBehavior classTrait',
	#category : #'Urbit-Core-Nock'
}

{ #category : #conversion }
NockBinaryAtom >> asBinary [
	^ self
]

{ #category : #'as yet unclassified' }
NockBinaryAtom >> asBitString [
	^ String
		streamContents: [ :stream | 
			self
				bitsDo: [ :aBit | stream nextPutAll: aBit asString ]
				afterByte: [ stream space ].
			stream ensureNoSpace ]
]

{ #category : #tranforming }
NockBinaryAtom >> asBits [
	^ ByteArray streamContents: [ :aStream | self asBitsOn: aStream ]
]

{ #category : #tranforming }
NockBinaryAtom >> asBitsOn: aStream [
	self bitsDo: [ :aBit | aStream nextPut: aBit ]
]

{ #category : #conversion }
NockBinaryAtom >> asIntegerAtom [
	"Find a better name, asInteger is taken and I'd rather not override it"
	
	^ self reversed asInteger asNock
]

{ #category : #bits }
NockBinaryAtom >> bitSize [
	"Gets the bitSize of the byteArray assuming a littleEndian encoding"

	^ (self at: self size) highBit + ((self size - 1) * 8)
]

{ #category : #tranforming }
NockBinaryAtom >> bitsDo: aBlock [
	"Process the bits from the highest bit to the lowest. No padding on the first byte"

	self processByteAsBitsNoPadding: self last do: aBlock.
	self size - 1
		to: 1
		by: -1
		do: [ :anIndex | self processByteAsBits: (self at: anIndex) do: aBlock ]
]

{ #category : #tranforming }
NockBinaryAtom >> bitsDo: aBlock afterByte: anotherBlock [
	"Process the bits from the highest bit to the lowest. No padding on the first byte"

	self processByteAsBitsNoPadding: self last do: aBlock.
	anotherBlock value.
	self size - 1
		to: 1
		by: -1
		do: [ :anIndex | 
			self processByteAsBits: (self at: anIndex) do: aBlock.
			anotherBlock value ]
]

{ #category : #'as yet unclassified' }
NockBinaryAtom >> gtJamInfo: aView [
	<gtView>
	| lenAtom lenLen bitString |
	^ aView columnedList
		title: 'Atom Info';
		priority: 10;
		items: [ bitString := self asBitString.
			lenAtom := self bitSize asNock asBinary asBitString.
			lenAtom := lenAtom copyFrom: 2 to: lenAtom size.
			lenLen := '1' , ('0' repeat: self bitSize highBit).
			{{'Atom'.
					self asIntegerAtom.
					bitString asRopedText underlineColor: Color red}.
				{'UTF8'.
					[ ZnUTF8Encoder new decodeBytes: self ]
						on: ZnCharacterEncodingError
						do: [ :exception | exception ].
					'N/A'}.
				{'Number of bits'.
					self bitSize.
					lenAtom asRopedText underlineColor: Color blue}.
				{'bits length'.
					self bitSize highBit.
					lenLen asRopedText underlineColor: Color green}.
				{'Jam'.
					self jamAnnotatedText.
					self jam asBitString reversed}} ];
		column: 'Key'
			text: #first
			width: 90;
		column: 'Value'
			stencil: [ :item | 
				BrEditor new
					text: item second;
					aptitude: BrGlamorousRegularEditorAptitude new;
					vFitContent;
					yourself ];
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

{ #category : #encoding }
NockBinaryAtom >> jamWith: aContext and: aBitStream [
	"ingoring backrefs for now"

	"The bitSize calculation could be done with less allocation by doing a workaround to make the first bitsDo: skip the first element"

	<argument: #aContext isKindOf: #Dictionary>
	<argument: #bitBuffer isKindOf: #BitStream>
	self bitsDo: [ :aBit | aBitStream nextPutBit: aBit ].	"write the atom"
	self bitSize asNock asBinary asBits
		allButFirstDo: [ :aBit | aBitStream nextPutBit: aBit ].	"write the len"
	aBitStream nextPutBit: 1.
	self bitSize highBit timesRepeat: [ aBitStream nextPutBit: 0 ].	"write len of len"
	aBitStream nextPutBit: 0.	"add the atom tag"
	aContext
		addAtom: self
		size: self bitSize
		lenSize: self bitSize highBit.
	^ {aContext.
		aBitStream}
]

{ #category : #tranforming }
NockBinaryAtom >> processByteAsBits: byte do: aBlock [
	"Process a byte from the highest bit digit to the lowest digit"
	^ 8
		to: 1
		by: -1
		do: [ :aBit | aBlock value: (byte bitAt: aBit) ]
]

{ #category : #tranforming }
NockBinaryAtom >> processByteAsBitsNoPadding: byte do: aBlock [
	^ byte highBit
		to: 1
		by: -1
		do: [ :aBit | aBlock value: (byte bitAt: aBit) ]
]
