Class {
	#name : #GitProjectBoard,
	#superclass : #Object,
	#instVars : [
		'gqlContext',
		'organization',
		'board',
		'repo',
		'remoteName',
		'candidate'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitProjectBoard >> board: anInteger [ 
	board := anInteger
]

{ #category : #accessing }
GitProjectBoard >> context [
	<return: #GtGQLContext>
	^ gqlContext
]

{ #category : #setting }
GitProjectBoard >> context: aContext [
	gqlContext := aContext
]

{ #category : #setting }
GitProjectBoard >> gitLocation: aPath [
	<argument: #aPath isKindOf: #FileLocator>
	repo := IceLibgitRepository new location: aPath
]

{ #category : #accessing }
GitProjectBoard >> gtRepositoryProjectBoard: aView [
	<gtView>
	^ aView forward
		title: 'Project Board';
		priority: 10;
		object: [ self releaseStatus ];
		view: #gtRepositoryProjectBoard:
]

{ #category : #predicates }
GitProjectBoard >> hasReleaseCandidate [
	^ self releaseCandidate isNotNil
]

{ #category : #setting }
GitProjectBoard >> organization: aString [
	organization := aString
]

{ #category : #'json - queries' }
GitProjectBoard >> projectBoardItemRemoteName: projectBoardItem [
	^ remoteName , '/'
		, (projectBoardItem atPath: #(node content headRefName)) asJsonString
		copyWithout: $"
]

{ #category : #'json - queries' }
GitProjectBoard >> projectBoardItemStatus: projectBoardItem [
	^ (projectBoardItem atPath: #(node status name)) jsonObject
]

{ #category : #'json - queries' }
GitProjectBoard >> projectBoardItemTag: projectBoardItem [
	^ (projectBoardItem atPath: #(node labels labels edges))
		collect: [ :x | x node name jsonObject ]
]

{ #category : #queries }
GitProjectBoard >> projectBoardResult [
	^ self context client
		operation: 'query WhatsCooking($board: Int!, $organization: String!){
	organization(login: $organization) {
		login name url
		projectV2 (number: $board) {
			__typename
			title
			number
			id
			items(first: 99) {
				totalCount
				pageInfo { hasNextPage endCursor hasPreviousPage startCursor }
				edges {
					cursor
					node {  
					id
					content {
						#__typename
						... on PullRequest { headRefName } }
					labels: fieldValueByName (name: "Labels") {
						... on ProjectV2ItemFieldLabelValue {
							#__typename
							labels(first: 10) {
								edges { node { color name } } } } }
					status: fieldValueByName (name: "Status") {
						#__typename
						... on ProjectV2ItemFieldSingleSelectValue {
							name } } } } } } } } 
'
		input: (Dictionary new
				at: #organization put: organization;
				at: #board put: board;
				yourself)
]

{ #category : #accessing }
GitProjectBoard >> projectValueStream [
	| aResult topic tags projectBoardItem status |
	aResult := self projectBoardResult.
	^ aResult paginator
		connectorPath: #(organization projectV2 items);
		collect: [ :each | 
			projectBoardItem := each asJson.
			topic := IceGitRemoteBranch
					named: (self projectBoardItemRemoteName: projectBoardItem)
					inRepository: repo.
			tags := self projectBoardItemTag: projectBoardItem.
			status := self projectBoardItemStatus: projectBoardItem.
			GitTopicInfo new
				topic: topic tags: tags;
				status: status;
				yourself ]
]

{ #category : #accessing }
GitProjectBoard >> releaseCandidate [
	^ candidate
]

{ #category : #setting }
GitProjectBoard >> releaseCandidate: aString [
	candidate := IceGitLocalBranch named: aString inRepository: self repo
]

{ #category : #accessing }
GitProjectBoard >> releaseStatus [
	^ GitReleaseStatus new
		releaseBranch: self releaseCandidate;
		topics: self projectValueStream;
		yourself
]

{ #category : #setting }
GitProjectBoard >> remoteName: aString [
	remoteName := aString
]

{ #category : #accessing }
GitProjectBoard >> repo [
	<return: #IceLibgitRepository>
	^ repo
]
