Class {
	#name : #NockExpressionNode,
	#superclass : #SmaCCParseNode,
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
NockExpressionNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitExpression: self
]

{ #category : #'as yet unclassified' }
NockExpressionNode >> asNock [
	^ NockAstTransformation new accept: self
]
