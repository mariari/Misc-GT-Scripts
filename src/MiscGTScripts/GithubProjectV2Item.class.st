"
I represent [github's project feature](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects) using the [](https://docs.github.com/en/graphql) github API.

My {{gtClass:name=GitLabelsMixin}} refers to the status's any {{gtClass:name=ProjectBoardItem}} may take.
"
Class {
	#name : #GithubProjectV2Item,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON + GitLabelsMixin',
	#classTraits : 'GithubJSON classTrait + GitLabelsMixin classTrait',
	#instVars : [
		'itemID',
		'status',
		'contents'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #'json  - queries' }
GithubProjectV2Item >> contentFromJson: projectBoardItem [
	" update later to handle WIP Issues, need to match off the __typename"

	"__typname is bugged in gt, replace the check with __typename later"

	(projectBoardItem atPath: #(content headRefName)) exists
		ifTrue: [ ^ self contents: (GithubPR new fromJson: (projectBoardItem at: #content)) ].
	self contents: (GithubIssue new fromJson: (projectBoardItem at: #content))
]

{ #category : #accessing }
GithubProjectV2Item >> contents [
	^ contents
]

{ #category : #accessing }
GithubProjectV2Item >> contents: anObject [
	contents := anObject
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
GithubProjectV2Item >> isTopic [
	^ contents isTopic
]

{ #category : #accessing }
GithubProjectV2Item >> itemID [
	^ itemID
]

{ #category : #accessing }
GithubProjectV2Item >> itemID: anObject [
	itemID := anObject
]

{ #category : #accessing }
GithubProjectV2Item >> itemName [
	^ self isTopic
		ifTrue: [ contents topicName ]
		ifFalse: [ self notYetImplemented ]
]

{ #category : #accessing }
GithubProjectV2Item >> labelName [
	^ 'current labels'
]

{ #category : #'json  - queries' }
GithubProjectV2Item >> labelsFromJson: projectBoardItem [
	self
		allLabels: ((projectBoardItem atPath: #(labels labels edges))
				collect: [ :x | GitLabelInfo new fromJson: (x at: #node) ])
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
	self
		status: (GitLabelInfo new fromJson: (projectBoardItem atPath: #(status)))
]

{ #category : #stream }
GithubProjectV2Item >> toProjectBoardItemWith: repo andUpstream: upstream [
	^ self
		toProjectBoardItemWith: repo
		andUpstream: upstream
		andProjectStatus: nil
]

{ #category : #stream }
GithubProjectV2Item >> toProjectBoardItemWith: repo andUpstream: upstream andProjectStatus: allStatuses [
	| content topic projectItem |
	" TODO, try to get WIP issue info as well"
	"TODO replace boolean check with dispatch to contents to allocate their type"
	content := self contents.
	projectItem := content isTopic
			ifTrue: [ topic := IceGitRemoteBranch
						named: upstream , '/' , content refName
						inRepository: repo.
				GitTopicInfo new
					projectInfo: (GitProjectInfo new
							allLabels: content repo allLabels;
							statuses: allStatuses;
							yourself);
					topic: topic ]
			ifFalse: [ GitIssueInfo new title: content title ].

	^ projectItem
		status: self status;
		allLabels: self allLabels;
		itemNumber: content itemNumber;
		yourself
]
