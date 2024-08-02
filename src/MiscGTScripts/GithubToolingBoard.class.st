Class {
	#name : #GithubToolingBoard,
	#superclass : #GithubToolingOrg,
	#traits : 'GitLabelsMixin',
	#classTraits : 'GitLabelsMixin classTrait',
	#instVars : [
		'board'
	],
	#category : #'MiscGTScripts-git - query'
}

{ #category : #accessing }
GithubToolingBoard >> board [
	^ board
]

{ #category : #setting }
GithubToolingBoard >> board: anObject [
	board := anObject
]

{ #category : #building }
GithubToolingBoard >> build [
	self computeLabels
]

{ #category : #building }
GithubToolingBoard >> computeLabels [
	^ self allLabels: self projectBoardBasicStatus
]

{ #category : #visualization }
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
GithubToolingBoard >> labelName [
	^ 'Statuses'
]

{ #category : #querying }
GithubToolingBoard >> projectBoardArguments [
	^ Dictionary new
		at: #organization put: self organization;
		at: #board put: self board;
		at: #after put: nil;
		yourself
]

{ #category : #stream }
GithubToolingBoard >> projectBoardBasicItems [
	^ self projectBoardQuery paginator
		cursorInputName: #after;
		connectorPath: #(organization projectV2 items);
		collect: [ :item | GithubProjectV2Item new fromJson: (item asGtJson at: #node) ]
]

{ #category : #stream }
GithubToolingBoard >> projectBoardBasicStatus [
	^ (self projectBoardStatus data asGtJson
		atPath: #(organization projectV2 status options))
		collect: [ :x | GitLabelInfo new fromJson: x ]
]

{ #category : #querying }
GithubToolingBoard >> projectBoardQuery [
	^ self context client
		operation: 'query WhatsCooking($board: Int!, $organization: String!, $after: String){
	organization(login: $organization) {
		login name url
		projectV2 (number: $board) {
			__typename
			title
			number
			id
			items(first: 99, after: $after) {
				totalCount
				pageInfo { hasNextPage endCursor hasPreviousPage startCursor }
				edges {
					cursor
					node {
					id
					content {
						... on Issue {
							id
							number
							closed
							title
							repository {
								labels(first: 99) {
								edges { node { color name description } } }
							}
						}
						... on PullRequest {
							id
							headRefName 
							number
							repository {
								labels(first: 99) {
								edges { node { color name description } } }
							} } }
					labels: fieldValueByName (name: "Labels") {
						... on ProjectV2ItemFieldLabelValue {
							
							labels(first: 10) {
								edges { node { color name description } } } } }
					status: fieldValueByName (name: "Status") {
						
						... on ProjectV2ItemFieldSingleSelectValue {
							color name description } } } } } } } }'
		input: self projectBoardArguments
]

{ #category : #querying }
GithubToolingBoard >> projectBoardStatus [
	^ self context client
		operation: 'query Status($board: Int!, $organization: String!){
	organization(login: $organization) {
		projectV2 (number: $board) {
			status: field(name: "Status") {
				__typename
				... on ProjectV2SingleSelectField {
					options { color name description }}}}}}'
		input: self projectBoardArguments
]
