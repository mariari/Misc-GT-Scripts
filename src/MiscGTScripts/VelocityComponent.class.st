Class {
	#name : #VelocityComponent,
	#superclass : #Object,
	#instVars : [
		'dx',
		'dy'
	],
	#category : #'MiscGTScripts-ECSPlayground'
}

{ #category : #accessing }
VelocityComponent >> dx [
	^ dx
]

{ #category : #accessing }
VelocityComponent >> dx: anObject [
	dx := anObject
]

{ #category : #accessing }
VelocityComponent >> dy [
	^ dy
]

{ #category : #accessing }
VelocityComponent >> dy: anObject [
	dy := anObject
]
