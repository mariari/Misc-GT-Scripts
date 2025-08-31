Class {
	#name : #SillyDoublyLinkedListForExample,
	#superclass : #Object,
	#instVars : [
		'car',
		'cdr',
		'pcdr'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
SillyDoublyLinkedListForExample >> car [
	^ car
]

{ #category : #accessing }
SillyDoublyLinkedListForExample >> car: anObject [
	car := anObject
]

{ #category : #accessing }
SillyDoublyLinkedListForExample >> cdr [
	^ cdr
]

{ #category : #accessing }
SillyDoublyLinkedListForExample >> cdr: anObject [
	<argument: #anObject isKindOf: #SillyDoublyLinkedListForExample>
	cdr := anObject.
	anObject pcdr: self
]

{ #category : #'as yet unclassified' }
SillyDoublyLinkedListForExample >> elements [
	"Return all nodes belonging to the same doubly-linked chain as the receiver,
	ordered from head to tail, as an OrderedCollection."

	| current result seen |
	"Find the head by following pcdr backwards"
	"Collect forward from head using cdr (guard against cycles)"
	result := OrderedCollection new.
	current := self first.
	seen := IdentitySet new.
	[ current notNil and: [ (seen includes: current) not ] ]
		whileTrue: [ result add: current.
			seen add: current.
			current := current cdr ].
	^ result
]

{ #category : #'as yet unclassified' }
SillyDoublyLinkedListForExample >> first [
	| head |
	head := self.
	[ head notNil and: [ head pcdr notNil ] ] whileTrue: [ head := head pcdr ].
	^ head
]

{ #category : #'as yet unclassified' }
SillyDoublyLinkedListForExample >> graphicalElementsFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graphical Elements';
		priority: 9;
		painting: [ :view | 
			view nodes
				stencil: [ :x | 
					BlTextElement new
						border: (BlBorder paint: Color black);
						background: Color paleOrange;
						padding: (BlInsets all: 5);
						constraintsDo: [ :c | c margin: (BlInsets all: 10) ];
						text: x car asString asRopedText ];
				with: self elements.
			view edges
				stencil: [ :x | 
					BlLineElement new
						border: (BlBorder paint: Color black);
						toHead: (BlArrowheadSimpleArrow new background: Color black) ];
				connectFrom: [ :x | x ]
					toAll: [ :x | 
						{x cdr.
							x pcdr} ].
			view layout horizontal ]
]

{ #category : #'as yet unclassified' }
SillyDoublyLinkedListForExample >> gtElementsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Elements';
		priority: 10;
		items: [
			| nodes head current seen |
			nodes := OrderedCollection new.
			"Find the head by following pcdr to the beginning"
			head := self.
			[ head notNil and: [ head pcdr notNil ] ] whileTrue: [ head := head pcdr ].
			"Collect forward from head using cdr (guard against cycles)"
			current := head.
			seen := IdentitySet new.
			[ current notNil and: [ (seen includes: current) not ] ] whileTrue: [
				nodes add: current.
				seen add: current.
				current := current cdr ].
			nodes ];
		column: 'Car' text: [ :node | node car ];
		column: 'Prev (pcdr)' text: [ :node | node pcdr ];
		column: 'Next (cdr)' text: [ :node | node cdr ]
]

{ #category : #accessing }
SillyDoublyLinkedListForExample >> pcdr [
	^ pcdr
]

{ #category : #accessing }
SillyDoublyLinkedListForExample >> pcdr: anObject [
	pcdr := anObject
]
