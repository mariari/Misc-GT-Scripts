Class {
	#name : #NockExpressionNode,
	#superclass : #SmaCCParseNode,
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
NockExpressionNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitExpression: self
]
