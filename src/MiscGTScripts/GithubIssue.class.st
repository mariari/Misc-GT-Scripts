Class {
	#name : #GithubIssue,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON',
	#classTraits : 'GithubJSON classTrait',
	#instVars : [
		'title',
		'itemNumber',
		'repo'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #setting }
GithubIssue >> fromJson: ajson [
	self
		titleFromJSON: ajson;
		itemNumberFromJson: ajson;
		repositoryInfoFromJson: ajson.
	^ self
]

{ #category : #accessing }
GithubIssue >> isTopic [
	^ false
]

{ #category : #accessing }
GithubIssue >> itemNumber [
	^ itemNumber
]

{ #category : #accessing }
GithubIssue >> itemNumber: anObject [
	itemNumber := anObject
]

{ #category : #setting }
GithubIssue >> itemNumberFromJson: ajson [
	self itemNumber: (ajson at: #number) jsonObject
]

{ #category : #accessing }
GithubIssue >> name [
	^ self title
]

{ #category : #accessing }
GithubIssue >> repo [
	^ repo
]

{ #category : #accessing }
GithubIssue >> repo: anObject [
	repo := anObject
]

{ #category : #setting }
GithubIssue >> repositoryInfoFromJson: ajson [
	self repo: (GithubRepo new fromJson: (ajson at: #repository))
]

{ #category : #accessing }
GithubIssue >> title [
	^ title
]

{ #category : #accessing }
GithubIssue >> title: anObject [
	title := anObject
]

{ #category : #'json - configuration' }
GithubIssue >> titleFromJSON: prJson [
	self title: (prJson at: #title) jsonObject
]
