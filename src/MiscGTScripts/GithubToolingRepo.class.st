Class {
	#name : #GithubToolingRepo,
	#superclass : #GithubToolingOwner,
	#instVars : [
		'repoName',
		'repository'
	],
	#category : #'MiscGTScripts-git - query'
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

{ #category : #accessing }
GithubToolingRepo >> labels [
	repository allLabels ifNil: [ self queryLabels ].
	repository allLabels isAsyncStream
		ifTrue: [ ^ repository allLabels asyncSimilarCopy ].
	^ repository allLabels
]

{ #category : #stream }
GithubToolingRepo >> labelsPagination [
	"much slower than labelsPagination, but we should keep it around when
	pagination isn't so slow"

	^ (self rawQueryRepoLabels data asGtJson atPath: #(repository labels edges))
		collect: [ :item | GitLabelInfo new fromJson: (item asGtJson at: #node) ]
]

{ #category : #stream }
GithubToolingRepo >> labelsPaginationProper [
	"much slower than labelsPagination, but we should keep it around when
	pagination isn't so slow"
	^ self rawQueryRepoLabels paginator
		cursorInputName: #after;
		connectorPath: #(repository labels);
		collect: [ :item | 
			GitLabelInfo new fromJson: (item asGtJson at: #node) ]
]

{ #category : #'private - accessing' }
GithubToolingRepo >> owner: aString [
	super owner: aString.
	repository owner: aString
]

{ #category : #building }
GithubToolingRepo >> queryEssential [

]

{ #category : #accessing }
GithubToolingRepo >> queryLabels [
	repository allLabels: self labelsPagination
]

{ #category : #accessing }
GithubToolingRepo >> rawQueryRepoLabels [
	^ self context client
		operation: 'query Labels($login: String!, $name : String!, $after: String) {
	repository(owner: $login, name: $name) {
		__typename
		description
		name
		id
		labels(first: 99, after: $after) {
			edges { node { color name description id } }
		}
	}
}'
		input: self repoArguments
]

{ #category : #accessing }
GithubToolingRepo >> repoArguments [
	^ Dictionary new
		at: #login put: self owner;
		at: #name put: self repoName;
		at: #after put: nil;
		yourself
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

{ #category : #accessing }
GithubToolingRepo >> repository [
	^ repository
]

{ #category : #accessing }
GithubToolingRepo >> repository: anObject [
	repository := anObject
]
