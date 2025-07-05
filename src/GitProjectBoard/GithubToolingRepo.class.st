Class {
	#name : #GithubToolingRepo,
	#superclass : #GithubToolingOwner,
	#instVars : [
		'repoName',
		'repository'
	],
	#category : #'GitProjectBoard-git - query'
}

{ #category : #accessing }
GithubToolingRepo >> gtLabelView: aView [
	<gtView>
	^ aView forward
		object: [ self labels.
			repository ];
		priority: 11;
		view: #gtLabelView:;
		title: 'Labels'
]

{ #category : #initalization }
GithubToolingRepo >> initialize [
	super initialize.
	repository := GithubRepo new.
]

{ #category : #stream }
GithubToolingRepo >> issuePagination [
	^ self rawQueryIssues paginator
		cursorInputName: #after;
		connectorPath: #(repository issues);
		collect: [ :item | 
			GithubIssue new
				fromJson: (item asGtJson at: #node);
				repo: self repository ]
]

{ #category : #accessing }
GithubToolingRepo >> issues [
	"TODO factor this out"

	repository issues ifNil: [ self queryIssues ].
	repository issues isAsyncStream ifTrue: [ ^ repository issues asAsyncStream ].
	^ repository issues
]

{ #category : #'as yet unclassified' }
GithubToolingRepo >> items [
	"I prove issues and prs together"

	"TODO use pagination instead of loading all"

	^ self loadIssues , self loadPrs
]

{ #category : #accessing }
GithubToolingRepo >> labels [
	repository allLabels ifNil: [ self queryEssential ].
	repository allLabels isAsyncStream
		ifTrue: [ ^ repository allLabels asyncSimilarCopy ].
	^ repository allLabels
]

{ #category : #stream }
GithubToolingRepo >> labelsPagination [
	"much slower than labelsPagination, but we should keep it around when
	pagination isn't so slow"
	^ self rawQueryRepoInfo paginator
		cursorInputName: #after;
		connectorPath: #(repository labels);
		collect: [ :item | 
			GitLabelInfo new fromJson: (item asGtJson at: #node) ]
]

{ #category : #loading }
GithubToolingRepo >> loadIssues [
	"TODO factor this out"

	| issues |
	issues := self issues.
	issues isAsyncStream
		ifTrue: [ issues := issues toArray wait.
			repository issues: issues ].
	^ issues
]

{ #category : #loading }
GithubToolingRepo >> loadPrs [
	"TODO factor this out"

	| prs |
	prs := self prs.
	prs isAsyncStream
		ifTrue: [ prs := prs toArray wait.
			repository prs: prs ].
	^ prs
]

{ #category : #'private - accessing' }
GithubToolingRepo >> owner: aString [
	super owner: aString.
	repository owner: aString
]

{ #category : #arguments }
GithubToolingRepo >> prIssueArguments [
	^ Dictionary new
		at: #login put: self owner;
		at: #repo put: self repoName;
		at: #after put: nil;
		yourself
]

{ #category : #stream }
GithubToolingRepo >> prPagination [
	^ self rawQueryPRs paginator
		cursorInputName: #after;
		connectorPath: #(repository pullRequests);
		collect: [ :item | 
			GithubPR new
				fromJson: (item asGtJson at: #node);
				repo: self repository ]
]

{ #category : #accessing }
GithubToolingRepo >> prs [
	"TODO factor this out"

	repository prs ifNil: [ self queryPrs ].
	repository prs isAsyncStream ifTrue: [ ^ repository prs asAsyncStream ].
	^ repository prs
]

{ #category : #building }
GithubToolingRepo >> queryEssential [
	^ repository fromJson: (self rawQueryRepoInfo data atPath: #(repository))
]

{ #category : #building }
GithubToolingRepo >> queryIssues [
	repository issues: self prPagination
]

{ #category : #building }
GithubToolingRepo >> queryLabels [
	repository allLabels: self labelsPagination
]

{ #category : #building }
GithubToolingRepo >> queryPrs [
	repository prs: self prPagination
]

{ #category : #querying }
GithubToolingRepo >> rawQueryIssues [
	^ self context client
		operation: '
query Issues($repo: String!, $login: String!, $after: String) {
	repository(name: $repo, owner: $login) {
		issues (after: $after, states: OPEN, first: 99 ) {
			edges { node {
		' , GithubIssue rawQueryString , '} } } } }'
		input: self prIssueArguments
]

{ #category : #querying }
GithubToolingRepo >> rawQueryPRs [
	^ self context client
		operation: '
query PullRequests($repo: String!, $login: String!, $after: String) {
	repository(name: $repo, owner: $login) {
		pullRequests (after: $after, states: OPEN, first: 99 ) {
			edges { node {
		' , GithubPR rawQueryString , '} } } } }'
		input: self prIssueArguments
]

{ #category : #querying }
GithubToolingRepo >> rawQueryRepoInfo [
	^ self context client
		operation: '
query Info($login: String!, $repo : String!, $after: String) {
	repository(owner: $login, name: $repo) {
		__typename
		description
		name
		id
		owner { login }
		labels(first: 99, after: $after) {
			edges { node { color name description id } }
		}
	}
}'
		input: self prIssueArguments
]

{ #category : #stream }
GithubToolingRepo >> repoIssuess [
	^ self rawQueryIssues paginator
		cursorInputName: #after;
		connectorPath: #(repository issues);
		collect: [ :item | GithubIssue new fromJson: (item asGtJson at: #node) ]
]

{ #category : #accessing }
GithubToolingRepo >> repoName [
	^ repoName
]

{ #category : #accessing }
GithubToolingRepo >> repoName: anObject [
	repository name: anObject.
	repoName := anObject.
]

{ #category : #stream }
GithubToolingRepo >> repoPRs [
	^ self rawQueryPRs paginator
		cursorInputName: #after;
		connectorPath: #(repository pullRequests);
		collect: [ :item | GithubPR new fromJson: (item asGtJson at: #node) ]
]

{ #category : #accessing }
GithubToolingRepo >> repository [
	^ repository
]

{ #category : #accessing }
GithubToolingRepo >> repository: anObject [
	repository := anObject
]
