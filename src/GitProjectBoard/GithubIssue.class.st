Class {
	#name : #GithubIssue,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON + GitLabelsMixin',
	#classTraits : 'GithubJSON classTrait + GitLabelsMixin classTrait',
	#instVars : [
		'title',
		'itemNumber',
		'repo',
		'author',
		'status'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #'querying - github' }
GithubIssue class >> rawQueryString [
	^ '
		id
		number
		state
		author {
			login
		}
		closed
		title
		labels(first: 99) { edges { node { color name description } } }
		repository { name }'
]

{ #category : #accessing }
GithubIssue >> author [
	^ author
]

{ #category : #accessing }
GithubIssue >> author: anObject [
	author := anObject
]

{ #category : #'as yet unclassified' }
GithubIssue >> authorNameFromJson: ajson [
	self author: (ajson atPath: #(author login)) jsonObject
]

{ #category : #'as yet unclassified' }
GithubIssue >> determineStatusCard: aString [
	^ aString = 'OPEN'
		ifTrue: [ GitLabelInfo openLabel ]
		ifFalse: [ GitLabelInfo closedLabel ]
]

{ #category : #setting }
GithubIssue >> fromJson: ajson [
	self
		titleFromJSON: ajson;
		itemNumberFromJson: ajson;
		repositoryInfoFromJson: ajson;
		authorNameFromJson: ajson;
		idFromJson: ajson;
		statusFromJson: ajson;
		labelsFromJson: ajson
]

{ #category : #views }
GithubIssue >> gtSummaryColumnedListFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Issue Summary';
		priority: 5;
		items: [ {'Title' -> self title.
				'Number' -> self itemNumber asString.
				'Author' -> self author.
				'Repo' -> self repo asString.
				'Status' -> self status asString.
				'Labels'
					-> (self allLabels
							ifNil: [ 'None' ]
							ifNotNil: [ :labels | labels ])} ];
		column: 'Property' text: #key;
		column: 'Value' text: #value
]

{ #category : #initalization }
GithubIssue >> initialize [
	super initialize.
	self repo: GithubRepoMinimal new
]

{ #category : #accessing }
GithubIssue >> isTopic [
	^ false
]

{ #category : #accessing }
GithubIssue >> itemNumber [
	^ itemNumber
]

{ #category : #accessing }
GithubIssue >> itemNumber: anObject [
	itemNumber := anObject
]

{ #category : #setting }
GithubIssue >> itemNumberFromJson: ajson [
	self itemNumber: (ajson at: #number) jsonObject
]

{ #category : #accessing }
GithubIssue >> labelName [
	^ 'current labels'
]

{ #category : #accessing }
GithubIssue >> labelsFromJson: projectBoardItem [
	self
		allLabels: ((projectBoardItem atPath: #(labels edges))
				collect: [ :x | GitLabelInfo new fromJson: (x at: #node) ])
]

{ #category : #accessing }
GithubIssue >> name [
	^ self title
]

{ #category : #accessing }
GithubIssue >> owner: aString [
	self repo owner: aString
]

{ #category : #accessing }
GithubIssue >> projectAwareItem [
	^ GitIssueInfo new
]

{ #category : #accessing }
GithubIssue >> repo [
	^ repo
]

{ #category : #accessing }
GithubIssue >> repo: anObject [
	repo := anObject
]

{ #category : #setting }
GithubIssue >> repositoryInfoFromJson: ajson [
	self repo fromJson: (ajson at: #repository)
]

{ #category : #accessing }
GithubIssue >> status [
	^ status
]

{ #category : #accessing }
GithubIssue >> status: aString [
	aString isNil ifTrue: [ ^ self ].
	status := self determineStatusCard: aString
]

{ #category : #'json - configuration' }
GithubIssue >> statusFromJson: aJSON [
	^ self status: (aJSON at: #state) jsonObject
]

{ #category : #accessing }
GithubIssue >> title [
	^ title
]

{ #category : #accessing }
GithubIssue >> title: anObject [
	title := anObject
]

{ #category : #'json - configuration' }
GithubIssue >> titleFromJSON: prJson [
	self title: (prJson at: #title) jsonObject
]
