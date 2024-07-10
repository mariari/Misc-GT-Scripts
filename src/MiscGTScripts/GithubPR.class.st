"
I represent [github's pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) using the [](https://docs.github.com/en/graphql) github API.

My {{gtClass:name=GitLabelsMixin}} refers to the status's any {{gtClass:name=ProjectBoardItem}} may take.
"
Class {
	#name : #GithubPR,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON',
	#classTraits : 'GithubJSON classTrait',
	#instVars : [
		'refName',
		'prNumber',
		'repo'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #setting }
GithubPR >> fromJson: ajson [
	self
		refNameFromJSON: ajson;
		prNumberFromJson: ajson.
	self repositoryInfoFromJson: ajson.	"We probably shouldn't parse a repo here we do as it's technically cheaper"

	^ self
]

{ #category : #accessing }
GithubPR >> prNumber [
	^ prNumber
]

{ #category : #accessing }
GithubPR >> prNumber: anObject [
	prNumber := anObject
]

{ #category : #setting }
GithubPR >> prNumberFromJson: ajson [
	self prNumber: (ajson at: #number) jsonObject
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
	self repo: (GithubRepo new fromJson: (ajson at: #repository))
]
