"
I represent a ProjectItemType, namely a pull request variant
"
Class {
	#name : #GithubProjectV2Item,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON',
	#classTraits : 'GithubJSON classTrait',
	#instVars : [
		'itemID',
		'status',
		'currentLabels',
		'contents'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #'json  - queries' }
GithubProjectV2Item >> contentFromJson: projectBoardItem [
	" update later to handle issues and WIP Issues, need to match off the __typename"

	self contents: (GithubPR new fromJson: (projectBoardItem at: #content))
]

{ #category : #accessing }
GithubProjectV2Item >> contents [
	^ contents
]

{ #category : #accessing }
GithubProjectV2Item >> contents: anObject [
	contents := anObject
]

{ #category : #accessing }
GithubProjectV2Item >> currentLabels [
	^ currentLabels
]

{ #category : #accessing }
GithubProjectV2Item >> currentLabels: anObject [
	currentLabels := anObject
]

{ #category : #setting }
GithubProjectV2Item >> fromJson: ajson [
	^ self
		statusFromJSON: ajson;
		labelsFromJson: ajson;
		contentFromJson: ajson;
		yourself
]

{ #category : #accessing }
GithubProjectV2Item >> itemID [
	^ itemID
]

{ #category : #accessing }
GithubProjectV2Item >> itemID: anObject [
	itemID := anObject
]

{ #category : #'json  - queries' }
GithubProjectV2Item >> labelsFromJson: projectBoardItem [
	self
		currentLabels: ((projectBoardItem atPath: #(labels labels edges))
				collect: [ :x | x node name jsonObject ])
]

{ #category : #accessing }
GithubProjectV2Item >> status [
	^ status
]

{ #category : #accessing }
GithubProjectV2Item >> status: anObject [
	status := anObject
]

{ #category : #'json  - queries' }
GithubProjectV2Item >> statusFromJSON: projectBoardItem [
	self status: (projectBoardItem atPath: #(status name)) jsonObject
]

{ #category : #stream }
GithubProjectV2Item >> toProjectBoardItemWith: repo andUpstream: upstream [
	| content topic |
	" TODO, try to get issue info as well"
	content := self contents.
	topic := IceGitRemoteBranch
			named: upstream , '/' , content refName
			inRepository: repo.
	^ GitTopicInfo new
		tags: self currentLabels;
		status: self status;
		allTags: content repoLabels;
		itemNumber: content prNumber;
		topic: topic;
		yourself
]
