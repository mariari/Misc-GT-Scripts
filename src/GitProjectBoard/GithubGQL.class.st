"
I represent classes that can be queried from github's GraphQL API.
"
Class {
	#name : #GithubGQL,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GithubGQL >> id [
	^ id
]

{ #category : #accessing }
GithubGQL >> id: anObject [
	id := anObject
]

{ #category : #setting }
GithubGQL >> idFromJson: jsonData [
	self id: (jsonData at: #id) jsonObject
]
