"
I represent informaiton from a github repository using the [](https://docs.github.com/en/graphql) github API.

My {{gtClass:name=GitLabelsMixin}} refers to the labels that {{gtClass:name=GitTopicInfo}} or {{gtClass:name=GitIssueInfo}} may contain.
"
Class {
	#name : #GithubRepo,
	#superclass : #GithubRepoMinimal,
	#traits : 'GitLabelsMixin',
	#classTraits : 'GitLabelsMixin classTrait',
	#instVars : [
		'issues',
		'prs'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #'json ' }
GithubRepo >> fromJson: ajson [
	"Queries all set data. Not repos and Issues"

	super fromJson: ajson.
	self labelFromJson: ajson.
	^ self
]

{ #category : #accessing }
GithubRepo >> issues [
	^ issues
]

{ #category : #accessing }
GithubRepo >> issues: anObject [
	issues := anObject
]

{ #category : #'json ' }
GithubRepo >> labelFromJson: ajson [
	self
		allLabels: ((ajson atPath: #(labels edges))
				collect: [ :node | GitLabelInfo new fromJson: (node at: #node) ])
]

{ #category : #accessing }
GithubRepo >> labelName [
	^ 'Labels'
]

{ #category : #accessing }
GithubRepo >> prs [
	^ prs
]

{ #category : #accessing }
GithubRepo >> prs: anObject [
	prs := anObject
]
