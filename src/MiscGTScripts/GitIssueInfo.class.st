Class {
	#name : #GitIssueInfo,
	#superclass : #ProjectBoardItem,
	#instVars : [
		'title'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitIssueInfo >> isTopic [
	^ false
]

{ #category : #accessing }
GitIssueInfo >> itemName [
	^ self title
]

{ #category : #accessing }
GitIssueInfo >> title [
	^ title
]

{ #category : #accessing }
GitIssueInfo >> title: anObject [
	title := anObject
]
