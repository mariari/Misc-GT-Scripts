Class {
	#name : #NockNounNode,
	#superclass : #NockExpressionNode,
	#instVars : [
		'expressionses'
	],
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
NockNounNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitNoun: self
]

{ #category : #generated }
NockNounNode >> compositeNodeVariables [
	^ #(#expressionses)
]

{ #category : #generated }
NockNounNode >> expressionses [
	^ expressionses
]

{ #category : #generated }
NockNounNode >> expressionses: anOrderedCollection [
	self setParents: self expressionses to: nil.
	expressionses := anOrderedCollection.
	self setParents: self expressionses to: self
]

{ #category : #'generated-initialize-release' }
NockNounNode >> initialize [
	super initialize.
	expressionses := OrderedCollection new: 2.
]
