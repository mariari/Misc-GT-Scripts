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

{ #category : #accessing }
GithubGQLProjectBoard >> board [
	^ board
]

{ #category : #setting }
GithubGQLProjectBoard >> board: anInteger [ 
	board := anInteger
]

{ #category : #accessing }
GithubGQLProjectBoard >> computeItems [
	^ self projectValueStream
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
								edges { node { color name } } }
							} } }
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
				at: #organization put: organisation;
				at: #board put: board;
				yourself)
]

{ #category : #stream }
GithubGQLProjectBoard >> projectValueStream [
	| aResult |
	aResult := self projectBoardResult.
	^ aResult paginator
		connectorPath: #(organization projectV2 items);
		collect: [ :item | 
			GithubProjectV2Item new
				fromJson: (item asJson at: #node);
				toProjectBoardItemWith: self repo andUpstream: self remoteName ]
]
