"
I represent [github's project feature](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects) using the [](https://docs.github.com/en/graphql) github API.

My {{gtClass:name=GitLabelsMixin}} refers to the status's any {{gtClass:name=ProjectBoardItem}} may take.
"
Class {
	#name : #GithubProjectV2Item,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON',
	#classTraits : 'GithubJSON classTrait',
	#instVars : [
		'contents',
		'status'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GithubProjectV2Item >> allLabels [
	^ self contents allLabels
]

{ #category : #'as yet unclassified' }
GithubProjectV2Item >> author [
	^ contents author
]

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
GithubProjectV2Item >> fromJson: jsonData [
	^ self
		statusFromJson: jsonData;
		contentFromJson: jsonData;
		idFromJson: jsonData yourself
]

{ #category : #accessing }
GithubProjectV2Item >> gtLabelView: aView [
	<gtView>
	contents allLabels ifNil: [ ^ aView empty ].
	^ aView forward
		object: [ contents ];
		priority: 11;
		title: 'current labels';
		view: #gtLabelView:
]

{ #category : #accessing }
GithubProjectV2Item >> isTopic [
	^ contents isTopic
]

{ #category : #accessing }
GithubProjectV2Item >> itemName [
	^ self contents name
]

{ #category : #accessing }
GithubProjectV2Item >> itemNumber [
	^ self contents itemNumber
]

{ #category : #accessing }
GithubProjectV2Item >> labelsCrumbList [
	^ self contents labelsCrumbList
]

{ #category : #stream }
GithubProjectV2Item >> owner: aString [
	self contents owner: aString
]

{ #category : #printing }
GithubProjectV2Item >> printOn: aStream [
	aStream
		<< 'V2Item(';
		nextPutAll: self itemName;
		<< ', ';
		print: status;
		<< ')'
]

{ #category : #accessing }
GithubProjectV2Item >> projectAwareItem [
	^ contents projectAwareItem item: self
]

{ #category : #accessing }
GithubProjectV2Item >> refName [
	^ self contents refName
]

{ #category : #accessing }
GithubProjectV2Item >> repo [
	^ contents repo
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
GithubProjectV2Item >> statusFromJson: projectBoardItem [
	self status: (GitLabelInfo new fromJson: (projectBoardItem atPath: #(status)))
]
