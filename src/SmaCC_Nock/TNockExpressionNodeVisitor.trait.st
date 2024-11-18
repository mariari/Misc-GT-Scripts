Trait {
	#name : #TNockExpressionNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
TNockExpressionNodeVisitor >> visitCell: aCell [
	^ self visitExpression: aCell
]

{ #category : #generated }
TNockExpressionNodeVisitor >> visitExpression: anExpression [
	^ self visitSmaCCParseNode: anExpression
]

{ #category : #generated }
TNockExpressionNodeVisitor >> visitNumber: aNumber [
	^ self visitExpression: aNumber
]
