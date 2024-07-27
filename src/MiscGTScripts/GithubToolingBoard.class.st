Class {
	#name : #GithubToolingBoard,
	#superclass : #GithubToolingOrg,
	#instVars : [
		'board'
	],
	#category : #'MiscGTScripts-git - query'
}

{ #category : #accessing }
GithubToolingBoard >> board [
	^ board
]

{ #category : #accessing }
GithubToolingBoard >> board: anObject [
	board := anObject
]

{ #category : #accessing }
GithubToolingBoard >> gtProjectView: aView [
	<gtView>
	^ aView columnedList
		title: 'Project View';
		items: [ self projectBoardBasicItems ];
		priority: 10;
		column: 'Index'
			text: [ :aValue :anIndex | anIndex asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
			width: 40;
		column: 'Item Name'
			text: [ :aValue | aValue itemName asRopedText foreground: Color black ];
		column: 'State'
			do: [ :aColumn | 
				aColumn
					stencil: [ :aValue | 
						BrButton new
							aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousToggleWithLabelAptitude;
							border: aValue status color;
							label: aValue status name ] ];
		column: 'Tags'
			do: [ :aColumn | 
				aColumn
					stencil: [ :aValue | aValue labelsCrumbList ];
					width: 300 ]
]

{ #category : #accessing }
GithubToolingBoard >> projectBoardBasicItems [
	^ self projectBoardQuery paginator
		connectorPath: #(organization projectV2 items);
		collect: [ :item | GithubProjectV2Item new fromJson: (item asGtJson at: #node) ]
]

{ #category : #querying }
GithubToolingBoard >> projectBoardQuery [
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
		input: (Dictionary new
				at: #organization put: self organization;
				at: #board put: self board;
				yourself)
]
