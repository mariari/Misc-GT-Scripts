Class {
	#name : #NockParser,
	#superclass : #SmaCCParser,
	#category : #'SmaCC_Nock'
}

{ #category : #'generated-accessing' }
NockParser class >> cacheId [
	^'2024-11-18T21:58:58.447534+08:00'
]

{ #category : #generated }
NockParser class >> definitionComment [
"%prefix Nock;
%suffix Node;
%root Expression;

# [0-9] can be encoded with \d or <isDigit>
<number>       : \d +;
<whitespace> : \s + ;
<lbrac>        : \[ ;
<rbrac>        : \];

Expression
	: Cell
	| Number
	;
	
Cell: <lbrac> 'lbrac' Expression 'expression' Expression 'expression' + <rbrac>'rbrac' {{}};
Number: <number> 'number' {{}};
Start: Expression;"
]

{ #category : #generated }
NockParser class >> reduceTable [
^#(
	#(9 1 #reduceActionForNumber1: 315393 false) 
	#(6 1 #liftFirstValue: 185345 false) 
	#(6 1 #liftFirstValue: 185346 false) 
	#(8 1 #reduceActionForExpression__expression___1: 267265 false) 
	#(7 4 #reduceActionForCell1: 220161 false) 
	#(8 2 #reduceActionForExpression__expression___2: 267266 false)
	).
]

{ #category : #generated }
NockParser class >> scannerClass [
	^NockScanner
]

{ #category : #generated }
NockParser class >> startingStateForExpression [
	^ 1
]

{ #category : #generated }
NockParser class >> symbolNames [
	^ #('<number>' '<whitespace>' '<lbrac>' '<rbrac>' 'B e g i n' 'Expression' 'Cell' 'Expression ''expression'' +' 'Number' 'Start' 'E O F' 'error')
]

{ #category : #generated }
NockParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #NockExpressionNode #NockExpressionNode #NockCellNode #OrderedCollection #NockNumberNode #NockExpressionNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
NockParser class >> transitionTable [
^#(
#[1 0 9 0 1 0 13 0 3 0 17 0 6 0 17 0 7 0 17 0 9] 
#[0 0 6 0 1 0 3 0 4 0 11] 
#[1 0 9 0 1 0 13 0 3 0 29 0 6 0 29 0 7 0 29 0 9] 
#[0 0 0 0 11] 
#[0 0 10 0 1 0 3 0 4 0 11] 
#[0 0 14 0 1 0 3 0 4 0 11] 
#[1 0 9 0 1 0 13 0 3 0 33 0 6 0 33 0 7 0 37 0 8 0 33 0 9] 
#[0 0 18 0 1 0 3 0 4] 
#[1 0 9 0 1 0 13 0 3 0 41 0 4 0 45 0 6 0 45 0 7 0 45 0 9] 
#[0 0 22 0 1 0 3 0 4 0 11] 
#[0 0 26 0 1 0 3 0 4]
	).
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForCell1: nodes [
	| result |
	result := NockCellNode new.
	result lbrac: (nodes at: 1).
	result addNode: (nodes at: 2) to: result expressions.
	result addNodes: (nodes at: 3) to: result expressions.
	result rbrac: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForExpression__expression___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForExpression__expression___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForNumber1: nodes [
	| result |
	result := NockNumberNode new.
	result number: (nodes at: 1).
	^ result
]
