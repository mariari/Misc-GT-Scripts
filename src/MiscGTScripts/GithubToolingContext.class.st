Class {
	#name : #GithubToolingContext,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'MiscGTScripts-git - query'
}

{ #category : #accessing }
GithubToolingContext >> context [
	^ context
]

{ #category : #accessing }
GithubToolingContext >> context: aContext [
	context := aContext
]
