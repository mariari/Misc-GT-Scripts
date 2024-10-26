Class {
	#name : #GithubToolingContext,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'GitProjectBoard-git - query'
}

{ #category : #accessing }
GithubToolingContext >> context [
	^ context
]

{ #category : #accessing }
GithubToolingContext >> context: aContext [
	context := aContext
]
