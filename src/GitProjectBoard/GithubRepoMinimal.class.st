Class {
	#name : #GithubRepoMinimal,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON + GitToQueryMixin',
	#classTraits : 'GithubJSON classTrait + GitToQueryMixin classTrait',
	#instVars : [
		'name',
		'owner'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GithubRepoMinimal class >> queryClass [
	^ GithubToolingRepo
]

{ #category : #setting }
GithubRepoMinimal >> fromJson: jsonData [
	self idFromJson: jsonData.
	self nameFromJson: jsonData.
	self ownerFromJson: jsonData
]

{ #category : #accessing }
GithubRepoMinimal >> name [
	^ name
]

{ #category : #accessing }
GithubRepoMinimal >> name: anObject [
	name := anObject
]

{ #category : #setting }
GithubRepoMinimal >> nameFromJson: jsonData [
	self name: (jsonData at: #name) jsonObject
]

{ #category : #accessing }
GithubRepoMinimal >> owner [
	^ owner
]

{ #category : #accessing }
GithubRepoMinimal >> owner: anObject [
	owner := anObject
]

{ #category : #setting }
GithubRepoMinimal >> ownerFromJson: jsonData [
	self owner: (jsonData atPath: #(owner login)) jsonObject
]

{ #category : #accessing }
GithubRepoMinimal >> printOn: aStream [
	self name ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self name
]

{ #category : #accessing }
GithubRepoMinimal >> toQueryWith: aContext [
	<argument: #aContext isKindOf: #GtGQLContext>
	^ self class queryClass new
		context: aContext;
		repoName: self name;
		organization: self owner
]
