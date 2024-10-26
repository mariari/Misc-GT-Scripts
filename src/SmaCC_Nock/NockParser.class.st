Class {
	#name : #NockParser,
	#superclass : #SmaCCParser,
	#category : #'SmaCC_Nock'
}

{ #category : #'generated-accessing' }
NockParser class >> cacheId [
	^'2024-10-27T00:04:50.192242+08:00'
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
	: Noun
	| Number
	;
	
Noun
	: <lbrac> Expression 'expressions' + <rbrac> {{Noun}}
	;
Number
	: <number> 'number' {{}}
	;
Start
	: Expression
	;"
]

{ #category : #generated }
NockParser class >> reduceTable [
^#(
	#(9 1 #reduceActionForNumber1: 284673 false) 
	#(6 1 #liftFirstValue: 185345 false) 
	#(6 1 #liftFirstValue: 185346 false) 
	#(8 1 #reduceActionForExpression__expressions___1: 236545 false) 
	#(7 3 #reduceActionForNoun1: 220161 false) 
	#(8 2 #reduceActionForExpression__expressions___2: 236546 false)
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
	^ #('<number>' '<whitespace>' '<lbrac>' '<rbrac>' 'B e g i n' 'Expression' 'Noun' 'Expression ''expressions'' +' 'Number' 'Start' 'E O F' 'error')
]

{ #category : #generated }
NockParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #NockExpressionNode #NockExpressionNode #NockNounNode #OrderedCollection #NockNumberNode #NockExpressionNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
NockParser class >> transitionTable [
^#(
#[1 0 9 0 1 0 13 0 3 0 17 0 6 0 17 0 7 0 17 0 9] 
#[0 0 6 0 1 0 3 0 4 0 11] 
#[1 0 9 0 1 0 13 0 3 0 29 0 6 0 29 0 7 0 33 0 8 0 29 0 9] 
#[0 0 0 0 11] 
#[0 0 10 0 1 0 3 0 4 0 11] 
#[0 0 14 0 1 0 3 0 4 0 11] 
#[0 0 18 0 1 0 3 0 4] 
#[1 0 9 0 1 0 13 0 3 0 37 0 4 0 41 0 6 0 41 0 7 0 41 0 9] 
#[0 0 22 0 1 0 3 0 4 0 11] 
#[0 0 26 0 1 0 3 0 4]
	).
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForExpression__expressions___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForExpression__expressions___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForNoun1: nodes [
	| result |
	result := NockNounNode new.
	result addNodes: (nodes at: 2) to: result expressionses.
	^ result
]

{ #category : #'generated-reduction actions' }
NockParser >> reduceActionForNumber1: nodes [
	| result |
	result := NockNumberNode new.
	result number: (nodes at: 1).
	^ result
]
