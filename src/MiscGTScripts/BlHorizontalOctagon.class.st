Class {
	#name : #BlHorizontalOctagon,
	#superclass : #BlOctagon,
	#instVars : [
		'top',
		'middle',
		'bottom',
		'container'
	],
	#category : #'MiscGTScripts-Graphics'
}

{ #category : #accessing }
BlHorizontalOctagon >> bottom [
	^ bottom
]

{ #category : #accessing }
BlHorizontalOctagon >> bottom: anObject [
	bottom := anObject
]

{ #category : #accessing }
BlHorizontalOctagon >> container [
	^ container
]

{ #category : #accessing }
BlHorizontalOctagon >> container: anObject [
	container := anObject
]

{ #category : #initalization }
BlHorizontalOctagon >> initialize [
	super initialize.

	top := BrFrame new
			matchParent;
			constraintsDo: [ :c | c linear weight: 0.3 ].

	middle := BrFrame new
			matchParent;
			constraintsDo: [ :c | c linear weight: 0.40 ].

	bottom := BrFrame new
			matchParent;
			constraintsDo: [ :c | c linear weight: 0.3 ].

	container := BrVerticalPane new
			matchParent;
			alignCenter;
			addChild: top;
			addChild: middle;
			addChild: bottom.

	self addChild: container
]

{ #category : #accessing }
BlHorizontalOctagon >> middle [
	^ middle
]

{ #category : #accessing }
BlHorizontalOctagon >> middle: anObject [
	middle := anObject
]

{ #category : #accessing }
BlHorizontalOctagon >> top [
	^ top
]

{ #category : #accessing }
BlHorizontalOctagon >> top: anObject [
	top := anObject
]
