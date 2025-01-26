Class {
	#name : #BitStreamExamples,
	#superclass : #Object,
	#category : #'Urbit-Core-Examples'
}

{ #category : #exmaple }
BitStreamExamples >> empty [
	<gtExample>
	| bit |
	bit := BitStream on: NockBinaryAtom new.
	self assert: bit isEmpty.
	^ bit
]

{ #category : #example }
BitStreamExamples >> twelve [
	<gtExample>
	| bit bitAlso |
	bit := self empty.
	bit
		nextBitsPutAll: {1.
				1.
				0.
				0}.
	bitAlso := self empty.
	bitAlso nextPutBitStream: bit.
	self assert: bit currentOffsetWord equals: bitAlso currentOffsetWord.
	self assert: bit isEmpty not.
	^ bit
]

{ #category : #example }
BitStreamExamples >> twelveCombine [
	<gtExample>
	| bit1 bit2 |
	bit1 := self twelve.
	bit2 := self twelve.
	bit1 nextPutBitStream: bit2.
	self assert: bit1 currentOffset = 0.
	^ bit1
]
