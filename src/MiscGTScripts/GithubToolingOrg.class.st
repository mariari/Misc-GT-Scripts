Class {
	#name : #GithubToolingOrg,
	#superclass : #GithubToolingContext,
	#instVars : [
		'organization'
	],
	#category : #'MiscGTScripts-git - query'
}

{ #category : #accessing }
GithubToolingOrg >> gtReposView: aView [
	<gtView>
	^ aView forward
		title: 'Repositories';
		object: [ self organizationQuery report ];
		priority: 13;
		view: #gtOrganizationRepositoriesFor:
]

{ #category : #accessing }
GithubToolingOrg >> organization [
	^ organization
]

{ #category : #accessing }
GithubToolingOrg >> organization: anObject [
	organization := anObject
]

{ #category : #querying }
GithubToolingOrg >> organizationQuery [
	^ self context client
		operation: 'query Organization($login: String!) {
	organization (login: $login) {
		login
		name
		url
		
	}
}'
		input: (Dictionary new
				at: #login put: self organization;
				yourself)
]
