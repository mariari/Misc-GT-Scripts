Trait {
	#name : #GithubJSON,
	#category : #'GitProjectBoard-git'
}

{ #category : #setting }
GithubJSON >> fromJson: ajson [
	^ self explicitRequirement 
]
