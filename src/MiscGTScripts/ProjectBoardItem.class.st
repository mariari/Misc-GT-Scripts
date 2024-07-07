Class {
	#name : #ProjectBoardItem,
	#superclass : #Object,
	#instVars : [
		'tags',
		'status',
		'allTags',
		'itemNumber'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
ProjectBoardItem >> allTags [
	^ allTags
]

{ #category : #setting }
ProjectBoardItem >> allTags: anObject [
	allTags := anObject
]

{ #category : #predicates }
ProjectBoardItem >> isTopic [
	^ self subclassResponsibility
]

{ #category : #accessing }
ProjectBoardItem >> itemNumber [
	^ itemNumber
]

{ #category : #accessing }
ProjectBoardItem >> itemNumber: anObject [
	itemNumber := anObject
]

{ #category : #accessing }
ProjectBoardItem >> status [
	^ status
]

{ #category : #setting }
ProjectBoardItem >> status: anObject [
	status := anObject
]

{ #category : #accessing }
ProjectBoardItem >> tags [
	^ tags
]

{ #category : #setting }
ProjectBoardItem >> tags: anObject [
	tags := anObject
]
