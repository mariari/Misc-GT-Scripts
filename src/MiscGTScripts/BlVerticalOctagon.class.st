"
###TODO
- Set Proportions
"
Class {
	#name : #BlVerticalOctagon,
	#superclass : #BlOctagon,
	#instVars : [
		'left',
		'middle',
		'right',
		'container'
	],
	#category : #'MiscGTScripts-Graphics'
}

{ #category : #accessing }
BlVerticalOctagon >> container [
	^ container
]

{ #category : #accessing }
BlVerticalOctagon >> container: anObject [
	container := anObject
]

{ #category : #initalization }
BlVerticalOctagon >> initialize [
	super initialize.

	left := BrFrame new
			matchParent;
			constraintsDo: [ :c | c linear weight: 0.3 ].

	middle := BrFrame new
			matchParent;
			constraintsDo: [ :c | c linear weight: 0.40 ].

	right := BrFrame new
			matchParent;
			constraintsDo: [ :c | c linear weight: 0.3 ].

	container := BrHorizontalPane new
			matchParent;
			alignCenter;
			addChild: left;
			addChild: middle;
			addChild: right.

	self addChild: container
]

{ #category : #accessing }
BlVerticalOctagon >> left [
	^ left
]

{ #category : #accessing }
BlVerticalOctagon >> left: anObject [
	left := anObject
]

{ #category : #accessing }
BlVerticalOctagon >> middle [
	^ middle
]

{ #category : #accessing }
BlVerticalOctagon >> middle: anObject [
	middle := anObject
]

{ #category : #accessing }
BlVerticalOctagon >> right [
	^ right
]

{ #category : #accessing }
BlVerticalOctagon >> right: anObject [
	right := anObject
]
