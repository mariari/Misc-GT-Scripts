Class {
	#name : #GithubGQLRepository,
	#superclass : #GitProjectBoard,
	#instVars : [
		'queryContext'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GithubGQLRepository >> context [ 
	<return: #GtGQLContext>
	^ queryContext context
]

{ #category : #accessing }
GithubGQLRepository >> context: aContext [
	<argument: #aContext isKindOf: #GtGQLContext>
	queryContext context: aContext
]

{ #category : #initalization }
GithubGQLRepository >> initialize [
	super initialize.
	queryContext := GithubToolingRepo new
]

{ #category : #accessing }
GithubGQLRepository >> organization: organization [
	queryContext organization: organization
]

{ #category : #accessing }
GithubGQLRepository >> repoName [
	^ queryContext repoName
]

{ #category : #accessing }
GithubGQLRepository >> repoName: aString [
	queryContext repoName: aString
]
