Class {
	#name : #GithubToolingBoard,
	#superclass : #GithubToolingOwner,
	#instVars : [
		'board',
		'projectBoard',
		'itemRepos'
	],
	#category : #'GitProjectBoard-git - query'
}

{ #category : #accessing }
GithubToolingBoard >> board [
	^ board
]

{ #category : #setting }
GithubToolingBoard >> board: anObject [
	board := anObject
]

{ #category : #accessing }
GithubToolingBoard >> githubToolingRepoAt: aRepo [
	<argument: #aRepo isKindOf: #GithubRepoMinimal>
	<return: #GithubToolingRepo>
	^ itemRepos
		at: aRepo name
		ifAbsentPut: [ self makeGithubToolingRepoAt: aRepo name ]
]

{ #category : #visualization }
GithubToolingBoard >> gtLabelView: aView [
	<gtView>
	^ aView forward
		object: [ self statuses.
			projectBoard ];
		priority: 11;
		view: #gtLabelView:;
		title: 'Statuses'
]

{ #category : #visualization }
GithubToolingBoard >> gtProjectView: aView [
	<gtView>
	^ aView forward
		object: [ projectBoard ];
		view: #gtProjectView:;
		title: 'Project View';
		priority: 10
]

{ #category : #initalization }
GithubToolingBoard >> initialize [
	super initialize.
	projectBoard := GithubProjectBoard new.
	itemRepos := Dictionary new
]

{ #category : #accessing }
GithubToolingBoard >> itemRepos [
	^ itemRepos
]

{ #category : #accessing }
GithubToolingBoard >> itemRepos: anObject [
	itemRepos := anObject
]

{ #category : #accessing }
GithubToolingBoard >> items [
	projectBoard items ifNil: [ self queryItems ].
	projectBoard items isAsyncStream
		ifTrue: [ ^ projectBoard items asyncSimilarCopy ].
	^ projectBoard items
]

{ #category : #accessing }
GithubToolingBoard >> itemsWithSurroundingKnowledge [
	^ self items
		collect: [ :v2Item | 
			v2Item id ifNil: [ self queryEssential ].
			v2Item toProjectAwareItem
				projectBoard: self;
				repo: (self githubToolingRepoAt: v2Item repo) ]
]

{ #category : #accessing }
GithubToolingBoard >> labelName [
	^ 'Statuses'
]

{ #category : #accessing }
GithubToolingBoard >> loadAllItemRepos [
	"Loads all the items and puts their repository into the repository cache"

	"Normally I should not be called, however if one wants to ensure all repos are there now
	then this method will do"

	(self loadAllItems collectAsSet: [ :item | item contents repo name ])
		do: [ :name | itemRepos at: name ifAbsentPut: [ self makeGithubToolingRepoAt: name ] ].
	^ itemRepos
]

{ #category : #accessing }
GithubToolingBoard >> loadAllItems [
	"Forces the async stream of items to be an array"

	| itemList |
	itemList := self items.
	itemList isAsyncStream
		ifTrue: [ itemList := itemList toArray wait.
			projectBoard items: itemList ].
	^ itemList
]

{ #category : #accessing }
GithubToolingBoard >> loadEverything [
	"like queryEverything, but we turn the asynchronous values into being concrete"

	self loadAllItemRepos
]

{ #category : #accessing }
GithubToolingBoard >> makeGithubToolingRepoAt: name [
	^ GithubToolingRepo new
		context: context;
		repoName: name;
		owner: owner withKind: kind
]

{ #category : #accessing }
GithubToolingBoard >> projectBoard: aProjectBoard [
	"replaces the project board, useful for mocking"

	projectBoard := aProjectBoard
]

{ #category : #querying }
GithubToolingBoard >> projectBoardArguments [
	^ Dictionary new
		at: #login put: self owner;
		at: #board put: self board;
		at: #after put: nil;
		yourself
]

{ #category : #stream }
GithubToolingBoard >> projectBoardBasicItems [
	^ self rawQueryBoardItems paginator
		cursorInputName: #after;
		connectorPath: #(organization projectV2 items);
		collect: [ :item | 
			GithubProjectV2Item new
				fromJson: (item asGtJson at: #node);
				owner: self owner ]
]

{ #category : #stream }
GithubToolingBoard >> projectBoardBasicStatus [
	^ (self rawQueryBoardStatus data asGtJson
		atPath: #(organization projectV2 status options))
		collect: [ :x | GitLabelInfo new fromJson: x ]
]

{ #category : #building }
GithubToolingBoard >> queryEssential [
	^ projectBoard fromJson: (self rawQueryBoardEssentialInfo data atPath: #(organization projectV2))
]

{ #category : #building }
GithubToolingBoard >> queryEverything [
	"Computes all fields that can be queried. Queries for items and repos will be an async stream"

	({[ self queryItems ].
		[ self queryEssential ].
		[ self queryStatuses ]} collect: #asAsyncPromise) do: #wait
]

{ #category : #accessing }
GithubToolingBoard >> queryItemRepositories [
	"This can be used for ensuring we have all repositories.
	However in normal use, the repositories should be built incrementally as needed instead"

	^ ((self loadAllItems collectAsSet: [ :item | item contents repo name ])
		collect: [ :name | 
			name
				-> (GithubToolingRepo new
						context: context;
						repoName: name;
						organization: organization) ]) as: Dictionary
]

{ #category : #building }
GithubToolingBoard >> queryItems [
	^ projectBoard items: self projectBoardBasicItems
]

{ #category : #building }
GithubToolingBoard >> queryStatuses [
	^ projectBoard allLabels: self projectBoardBasicStatus
]

{ #category : #querying }
GithubToolingBoard >> rawQueryBoardEssentialInfo [
	^ self context client
		operation: 'query ProjectBoardInfo($board: Int!, $login: String!){'
				, (self
						ownerQuery: '
		projectV2 (number: $board) {
			__typename
			title
			number
			number
			owner { 
				__typename
				...on Organization { name }
			}
			id } }')
		input: self projectBoardArguments
]

{ #category : #querying }
GithubToolingBoard >> rawQueryBoardItems [
	^ self context client
		operation: '
query WhatsCooking($board: Int!, $login: String!, $after: String){'
				, (self
						ownerQuery: '
		projectV2 (number: $board) {
			__typename
			items(first: 99, after: $after) {
				edges { node {
					id
					status: fieldValueByName (name: "Status") {

						... on ProjectV2ItemFieldSingleSelectValue {
							color name description } }
					content {
						... on Issue {
							' , GithubIssue rawQueryString
								, ' }
						... on PullRequest {' , GithubPR rawQueryString , '} } } } } }')
		input: self projectBoardArguments
]

{ #category : #querying }
GithubToolingBoard >> rawQueryBoardStatus [
	^ self context client
		operation: 'query Status($board: Int!, $login: String!){'
				, (self
						ownerQuery: '
		projectV2 (number: $board) {
			status: field(name: "Status") {
				__typename
				... on ProjectV2SingleSelectField {
					options { color name description }}}}}')
		input: self projectBoardArguments
]

{ #category : #accessing }
GithubToolingBoard >> statuses [
	projectBoard allLabels ifNil: [ self queryStatuses ].
	projectBoard allLabels isAsyncStream
		ifTrue: [ ^ projectBoard allLabels asyncSimilarCopy ].
	^ projectBoard allLabels
]
