Class {
	#name : #GithubGQLProjectBoard,
	#superclass : #GitProjectBoard,
	#instVars : [
		'queryContext'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #view }
GithubGQLProjectBoard >> authorsBoard [
	self loadAllItems.
	^ (self items collectAsSet: [ :item | item author ])
		collect: [ :author | self sliceByAuthor: author ]
		as: Array
]

{ #category : #accessing }
GithubGQLProjectBoard >> board [
	^ queryContext board
]

{ #category : #setting }
GithubGQLProjectBoard >> board: anInteger [
	queryContext board: anInteger
]

{ #category : #accessing }
GithubGQLProjectBoard >> computeItems [
	items := self projectValueStream.
	^ items
]

{ #category : #stream }
GithubGQLProjectBoard >> computeStatus [
	queryContext queryStatuses.
	^ self allLabels: queryContext statuses
]

{ #category : #accessing }
GithubGQLProjectBoard >> context [
	<return: #GtGQLContext>
	^ queryContext context
]

{ #category : #accessing }
GithubGQLProjectBoard >> context: aContext [
	<argument: #aContext isKindOf: #GtGQLContext>
	queryContext context: aContext
]

{ #category : #visualization }
GithubGQLProjectBoard >> gtAuthorsView: aView [
	<gtView>
	^ aView columnedList
		title: 'Authors View';
		priority: 11;
		items: [ self authorsBoard ];
		column: 'Authors' text: [ :item | item author asRopedText ]
]

{ #category : #initalization }
GithubGQLProjectBoard >> initialize [
	super initialize.
	self queryContext: GithubToolingBoard new
]

{ #category : #accessing }
GithubGQLProjectBoard >> organization: anObject [
	queryContext organization: anObject
]

{ #category : #accessing }
GithubGQLProjectBoard >> owner [
	^ queryContext owner
]

{ #category : #accessing }
GithubGQLProjectBoard >> populateEverything [
	queryContext queryEverything
]

{ #category : #stream }
GithubGQLProjectBoard >> projectValueStream [
	^ queryContext itemsWithSurroundingKnowledge
		collect: [ :v2Item | v2Item gitRepository: self repo ]
]

{ #category : #accessing }
GithubGQLProjectBoard >> queryContext [
	^ queryContext
]

{ #category : #setting }
GithubGQLProjectBoard >> queryContext: anObject [
	queryContext := anObject
]

{ #category : #accessing }
GithubGQLProjectBoard >> sliceByAuthor: author [
	^ GitProjectBoardAuthor new
		author: author;
		projectBoard: self
]

{ #category : #accessing }
GithubGQLProjectBoard >> user: anObject [
	queryContext user: anObject
]
