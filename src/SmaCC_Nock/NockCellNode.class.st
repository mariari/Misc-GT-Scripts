Class {
	#name : #NockCellNode,
	#superclass : #NockExpressionNode,
	#instVars : [
		'lbrac',
		'expressions',
		'rbrac'
	],
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
NockCellNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitCell: self
]

{ #category : #generated }
NockCellNode >> compositeNodeVariables [
	^ #(#expressions)
]

{ #category : #generated }
NockCellNode >> expressions [
	^ expressions
]

{ #category : #generated }
NockCellNode >> expressions: anOrderedCollection [
	self setParents: self expressions to: nil.
	expressions := anOrderedCollection.
	self setParents: self expressions to: self
]

{ #category : #'generated-initialize-release' }
NockCellNode >> initialize [
	super initialize.
	expressions := OrderedCollection new: 2.
]

{ #category : #generated }
NockCellNode >> lbrac [
	^ lbrac
]

{ #category : #generated }
NockCellNode >> lbrac: aSmaCCToken [
	lbrac := aSmaCCToken
]

{ #category : #generated }
NockCellNode >> rbrac [
	^ rbrac
]

{ #category : #generated }
NockCellNode >> rbrac: aSmaCCToken [
	rbrac := aSmaCCToken
]

{ #category : #generated }
NockCellNode >> tokenVariables [
	^ #(#lbrac #rbrac)
]
