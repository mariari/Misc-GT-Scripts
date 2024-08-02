"
I contain information about a specific git project.

This is a combination of information about the repo's tags and the project board's labels.

My {{gtClass:name=GitLabelsMixin}} refers to the labels that {{gtClass:name=GitTopicInfo}} or {{gtClass:name=GitIssueInfo}} may contain. We do not use it to contain the status information that a {{gtClass:name=GitProjectBoard}}.
"
Class {
	#name : #GitProjectInfo,
	#superclass : #Object,
	#traits : 'GitLabelsMixin',
	#classTraits : 'GitLabelsMixin classTrait',
	#instVars : [
		'stauses'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitProjectInfo >> gtStatusView: aView [
	<gtView>
	^ aView forward
		title: 'Project Board Statuses';
		object: (GitProjectInfo new allLabels: self stauses);
		view: #gtLabelView:
]

{ #category : #accessing }
GitProjectInfo >> labelName [
	^ 'Repository Labels'
]

{ #category : #accessing }
GitProjectInfo >> statuses: anObject [
	stauses := anObject
]

{ #category : #accessing }
GitProjectInfo >> stauses [
	^ stauses
]
