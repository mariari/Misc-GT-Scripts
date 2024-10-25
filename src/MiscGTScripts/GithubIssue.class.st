Class {
	#name : #GithubIssue,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON + GitLabelsMixin',
	#classTraits : 'GithubJSON classTrait + GitLabelsMixin classTrait',
	#instVars : [
		'title',
		'itemNumber',
		'repo',
		'author'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GithubIssue >> author [
	^ author
]

{ #category : #accessing }
GithubIssue >> author: anObject [
	author := anObject
]

{ #category : #'as yet unclassified' }
GithubIssue >> authorNameFromJson: ajson [
	self author: (ajson atPath: #(author login)) jsonObject
]

{ #category : #setting }
GithubIssue >> fromJson: ajson [
	self
		titleFromJSON: ajson;
		itemNumberFromJson: ajson;
		repositoryInfoFromJson: ajson;
		authorNameFromJson: ajson;
		labelsFromJson: ajson
]

{ #category : #initalization }
GithubIssue >> initialize [
	super initialize.
	self repo: GithubRepoMinimal new
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
GithubIssue >> labelName [
	^ 'current labels'
]

{ #category : #accessing }
GithubIssue >> labelsFromJson: projectBoardItem [
	self
		allLabels: ((projectBoardItem atPath: #(labels edges))
				collect: [ :x | GitLabelInfo new fromJson: (x at: #node) ])
]

{ #category : #accessing }
GithubIssue >> name [
	^ self title
]

{ #category : #accessing }
GithubIssue >> owner: aString [
	self repo owner: aString
]

{ #category : #accessing }
GithubIssue >> projectAwareItem [
	^ GitIssueInfo new
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
	self repo fromJson: (ajson at: #repository)
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
