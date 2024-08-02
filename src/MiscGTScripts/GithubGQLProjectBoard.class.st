Class {
	#name : #GithubGQLProjectBoard,
	#superclass : #GitProjectBoard,
	#instVars : [
		'queryContext'
	],
	#category : #'MiscGTScripts-git'
}

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
	items := self projectValueStream toArray wait.
	^ items
]

{ #category : #stream }
GithubGQLProjectBoard >> computeStatus [
	queryContext computeLabels.
	^ self allLabels: queryContext allLabels
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

{ #category : #initalization }
GithubGQLProjectBoard >> initialize [
	super initialize.
	self queryContext: GithubToolingBoard new
]

{ #category : #accessing }
GithubGQLProjectBoard >> organisation [
	^ queryContext organization
]

{ #category : #accessing }
GithubGQLProjectBoard >> organisation: anObject [
	queryContext organization: anObject
]

{ #category : #stream }
GithubGQLProjectBoard >> projectValueStream [
	^ queryContext projectBoardQuery paginator
		connectorPath: #(organization projectV2 items);
		collect: [ :item | 
			GithubProjectV2Item new
				fromJson: (item asGtJson at: #node);
				toProjectBoardItemWith: self repo
					andUpstream: self remoteName
					andProjectStatus: self allLabels ]
]

{ #category : #accessing }
GithubGQLProjectBoard >> queryContext [
	^ queryContext
]

{ #category : #setting }
GithubGQLProjectBoard >> queryContext: anObject [
	queryContext := anObject
]
