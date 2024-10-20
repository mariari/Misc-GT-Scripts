"
I represent [github's pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) using the [](https://docs.github.com/en/graphql) github API.

My {{gtClass:name=GitLabelsMixin}} refers to the status's any {{gtClass:name=ProjectBoardItem}} may take.
"
Class {
	#name : #GithubPR,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON + GitLabelsMixin',
	#classTraits : 'GithubJSON classTrait + GitLabelsMixin classTrait',
	#instVars : [
		'refName',
		'repo',
		'prNumber',
		'author'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GithubPR >> author [
	^ author
]

{ #category : #accessing }
GithubPR >> author: anObject [
	author := anObject
]

{ #category : #setting }
GithubPR >> authorNumberFromJson: ajson [
	self author: (ajson atPath: #(author login)) jsonObject
]

{ #category : #setting }
GithubPR >> fromJson: ajson [
	self
		refNameFromJSON: ajson;
		prNumberFromJson: ajson;
		repositoryInfoFromJson: ajson;
		authorNumberFromJson: ajson;
		labelsFromJson: ajson
]

{ #category : #initalization }
GithubPR >> initialize [
	super initialize.
	self repo: GithubRepoMinimal new
]

{ #category : #accessing }
GithubPR >> isTopic [
	^ true
]

{ #category : #accessing }
GithubPR >> itemNumber [
	^ prNumber
]

{ #category : #accessing }
GithubPR >> itemNumber: anObject [
	prNumber := anObject
]

{ #category : #accessing }
GithubPR >> labelName [
	^ 'current labels'
]

{ #category : #accessing }
GithubPR >> labelsFromJson: projectBoardItem [
	self
		allLabels: ((projectBoardItem atPath: #(labels edges))
				collect: [ :x | GitLabelInfo new fromJson: (x at: #node) ])
]

{ #category : #accessing }
GithubPR >> name [
	^ self topicName
]

{ #category : #accessing }
GithubPR >> owner: aString [
	self repo owner: aString
]

{ #category : #setting }
GithubPR >> prNumberFromJson: ajson [
	self itemNumber: (ajson at: #number) jsonObject
]

{ #category : #accessing }
GithubPR >> projectAwareItem [
	^ GitTopicInfo new
]

{ #category : #accessing }
GithubPR >> refName [

	^ refName
]

{ #category : #accessing }
GithubPR >> refName: anObject [

	refName := anObject
]

{ #category : #'json - configuration' }
GithubPR >> refNameFromJSON: prJson [
	self refName: (prJson at: #headRefName) jsonObject
]

{ #category : #accessing }
GithubPR >> repo [
	^ repo
]

{ #category : #accessing }
GithubPR >> repo: anObject [
	repo := anObject
]

{ #category : #setting }
GithubPR >> repositoryInfoFromJson: ajson [
	self repo fromJson: (ajson at: #repository)
]

{ #category : #accessing }
GithubPR >> topicName [
	^ self refName
]
