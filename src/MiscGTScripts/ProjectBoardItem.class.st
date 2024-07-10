"
I am a project board item, which are various `Issues` and `Pull Requests` there may be in a project.


The labels in my {{gtClass:name=GitLabelsMixin}} refers to the labels I am applied with. This is different from {{gtClass:name=GitProjectBoard}} in that those are for exclusive status's while my labels are all the tags that have been placed on me.
"
Class {
	#name : #ProjectBoardItem,
	#superclass : #Object,
	#traits : 'GitLabelsMixin',
	#classTraits : 'GitLabelsMixin classTrait',
	#instVars : [
		'tags',
		'status',
		'itemNumber',
		'projectInfo'
	],
	#category : #'MiscGTScripts-git'
}

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
ProjectBoardItem >> labelName [
	^ 'current tags'
]

{ #category : #accessing }
ProjectBoardItem >> projectInfo [
	<return: #GitProjectInfo>
	^ projectInfo
]

{ #category : #setting }
ProjectBoardItem >> projectInfo: anObject [
	projectInfo := anObject
]

{ #category : #accessing }
ProjectBoardItem >> status [
	^ status
]

{ #category : #setting }
ProjectBoardItem >> status: anObject [
	status := anObject
]
