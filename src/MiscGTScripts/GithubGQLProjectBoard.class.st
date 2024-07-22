Class {
	#name : #GithubGQLProjectBoard,
	#superclass : #GitProjectBoard,
	#instVars : [
		'gqlContext',
		'board',
		'organisation'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #stream }
GithubGQLProjectBoard >> ProjectInfoDictionary [
	^ Dictionary new
		at: #organization put: organisation;
		at: #board put: board;
		yourself
]

{ #category : #accessing }
GithubGQLProjectBoard >> board [
	^ board
]

{ #category : #setting }
GithubGQLProjectBoard >> board: anInteger [ 
	board := anInteger
]

{ #category : #stream }
GithubGQLProjectBoard >> buildStatus [
	self statuses: self computeStatus
]

{ #category : #accessing }
GithubGQLProjectBoard >> computeItems [
	items := self projectValueStream toArray wait.
	^ items
]

{ #category : #stream }
GithubGQLProjectBoard >> computeStatus [
	^ self
		allLabels: ((self projectBoardStatusesResult data asGtJson
				atPath: #(organization projectV2 status options))
				collect: [ :x | GitLabelInfo new fromJson: x ])
]

{ #category : #accessing }
GithubGQLProjectBoard >> context [
	<return: #GtGQLContext>
	^ gqlContext
]

{ #category : #accessing }
GithubGQLProjectBoard >> context: aContext [
	<argument: #aContext isKindOf: #GtGQLContext>
	gqlContext := aContext
]

{ #category : #accessing }
GithubGQLProjectBoard >> organisation [
	^ organisation
]

{ #category : #accessing }
GithubGQLProjectBoard >> organisation: anObject [
	organisation := anObject
]

{ #category : #stream }
GithubGQLProjectBoard >> projectBoardResult [
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
						... on PullRequest {
							headRefName 
							number
							repository {
								labels(first: 99) {
								edges { node { color name description } } }
							} } }
					labels: fieldValueByName (name: "Labels") {
						... on ProjectV2ItemFieldLabelValue {
							#__typename
							labels(first: 10) {
								edges { node { color name description } } } } }
					status: fieldValueByName (name: "Status") {
						#__typename
						... on ProjectV2ItemFieldSingleSelectValue {
							color name description } } } } } } } }'
		input: self ProjectInfoDictionary
]

{ #category : #stream }
GithubGQLProjectBoard >> projectBoardStatusesResult [
	^ self context client
		operation: 'query Status($board: Int!, $organization: String!){
	organization(login: $organization) {
		projectV2 (number: $board) {
			status: field(name: "Status") {
				__typename
				... on ProjectV2SingleSelectField {
					options { color name description }}}}}}'
		input: self ProjectInfoDictionary
]

{ #category : #stream }
GithubGQLProjectBoard >> projectValueStream [
	| aResult |
	aResult := self projectBoardResult.
	^ aResult paginator
		connectorPath: #(organization projectV2 items);
		collect: [ :item | 
			GithubProjectV2Item new
				fromJson: (item asGtJson at: #node);
				toProjectBoardItemWith: self repo
					andUpstream: self remoteName
					andProjectStatus: self allLabels ]
]

{ #category : #stream }
GithubGQLProjectBoard >> projectValueStreamRaw [
	| aResult |
	"like ProjectValueStream but we don't transform it into our model. 
	  Useful for debugging and seeing hte josn view"
	aResult := self projectBoardResult.
	^ aResult paginator
		connectorPath: #(organization projectV2 items);
		collect: [ :item | GithubProjectV2Item new fromJson: (item asJson at: #node) ]
]
