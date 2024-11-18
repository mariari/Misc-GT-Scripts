Class {
	#name : #NockAstTransformation,
	#superclass : #NockExpressionNodeVisitor,
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
NockAstTransformation >> visitCell: aCell [
	"I need to make this more optimal by passing an array buffer"

	| collection last newCell |
	collection := aCell expressions collect: [ :each | self acceptNode: each ].
	last := collection last.
	^ (last isKindOf: NockCell)
		ifTrue: [ newCell := NockCell new: last size + collection size - 1.
			1 to: collection size - 1 do: [ :i | newCell at: i put: (collection at: i) ].
			last
				withIndexDo: [ :each :i | newCell at: i + collection size - 1 put: each ].
			newCell ]
		ifFalse: [ NockCell newFromArray: collection ]
]

{ #category : #generated }
NockAstTransformation >> visitNumber: aNumber [
	^ NockIntegerAtom new data: aNumber number value asNumber
]
