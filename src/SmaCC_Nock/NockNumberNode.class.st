Class {
	#name : #NockNumberNode,
	#superclass : #NockExpressionNode,
	#instVars : [
		'number'
	],
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
NockNumberNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitNumber: self
]

{ #category : #generated }
NockNumberNode >> number [
	^ number
]

{ #category : #generated }
NockNumberNode >> number: aSmaCCToken [
	number := aSmaCCToken
]

{ #category : #generated }
NockNumberNode >> tokenVariables [
	^ #(#number)
]
