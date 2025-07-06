Class {
	#name : #GithubGQLRepository,
	#superclass : #GitProjectBoard,
	#instVars : [
		'queryContext'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GithubGQLRepository >> computeItems [
	items := self promoteItems.
	^ items
]

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
GithubGQLRepository >> promoteItems [
	"TODO: Figure out if we should query some boards"

	^ queryContext items
		collect: [ :item | 
			item projectAwareItem
				repo: queryContext;
				gitRepository: (self repo at: item repo name ifAbsent: nil);
				yourself ]
]

{ #category : #accessing }
GithubGQLRepository >> repoName [
	^ queryContext repoName
]

{ #category : #accessing }
GithubGQLRepository >> repoName: aString [
	queryContext repoName: aString
]
