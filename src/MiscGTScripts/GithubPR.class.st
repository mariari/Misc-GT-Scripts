Class {
	#name : #GithubPR,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON',
	#classTraits : 'GithubJSON classTrait',
	#instVars : [
		'refName',
		'prNumber',
		'repoLabels'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #setting }
GithubPR >> fromJson: ajson [
	self refNameFromJSON: ajson.
	^ self
]

{ #category : #accessing }
GithubPR >> prNumber [
	^ prNumber
]

{ #category : #accessing }
GithubPR >> prNumber: anObject [
	prNumber := anObject
]

{ #category : #accessing }
GithubPR >> refName [

	^ refName
]

{ #category : #accessing }
GithubPR >> refName: anObject [

	refName := anObject
]

{ #category : #'json - configuration' }
GithubPR >> refNameFromJSON: prJSON [
	refName := (prJSON at: #headRefName) asJsonString copyWithout: $"
]

{ #category : #accessing }
GithubPR >> repoLabels [
	^ repoLabels
]

{ #category : #accessing }
GithubPR >> repoLabels: anObject [
	repoLabels := anObject
]
