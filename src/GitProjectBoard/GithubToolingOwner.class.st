Class {
	#name : #GithubToolingOwner,
	#superclass : #GithubToolingContext,
	#instVars : [
		'owner',
		'kind'
	],
	#category : #'GitProjectBoard-git - query'
}

{ #category : #accessing }
GithubToolingOwner class >> orgQuery: aQuery [
	^ 'organization (login: $login) {' , aQuery , '}'
]

{ #category : #accessing }
GithubToolingOwner class >> userQuery: aQuery [
	^ 'user (login: $login) {' , aQuery , '}'
]

{ #category : #accessing }
GithubToolingOwner >> gtReposView: aView [
	<gtView>
	^ aView forward
		title: 'Repositories';
		object: [ self rawQueryOwner report ];
		priority: 13;
		view: #gtOrganizationRepositoriesFor:
]

{ #category : #accessing }
GithubToolingOwner >> organization: anObject [
	self owner: anObject.
	kind := #organization
]

{ #category : #accessing }
GithubToolingOwner >> owner [
	^ owner
]

{ #category : #'private - accessing' }
GithubToolingOwner >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
GithubToolingOwner >> owner: aString withKind: akind [
	self owner: aString.
	kind := akind
]

{ #category : #accessing }
GithubToolingOwner >> ownerQuery: aQuery [
	<argument: #aQuery isKindOf: #String>
	kind = #user ifTrue: [ ^ self class userQuery: aQuery ].
	kind = #organization ifTrue: [ ^ self class orgQuery: aQuery ]
]

{ #category : #querying }
GithubToolingOwner >> rawQueryOwner [
	^ self context client
		operation: 'query Organization($login: String!) {'
				, (self
						ownerQuery: '
			login
			name
			url
		
		}')
		input: (Dictionary new
				at: #login put: self owner;
				yourself)
]

{ #category : #accessing }
GithubToolingOwner >> user: anObject [
	self owner: anObject.
	kind := #user
]
