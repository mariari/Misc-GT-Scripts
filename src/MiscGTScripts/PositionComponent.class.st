Class {
	#name : #PositionComponent,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'MiscGTScripts-ECSPlayground'
}

{ #category : #accessing }
PositionComponent >> x [
	^ x
]

{ #category : #accessing }
PositionComponent >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PositionComponent >> y [
	^ y
]

{ #category : #accessing }
PositionComponent >> y: anObject [
	y := anObject
]
