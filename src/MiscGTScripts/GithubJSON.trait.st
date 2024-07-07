Trait {
	#name : #GithubJSON,
	#category : #'MiscGTScripts-git'
}

{ #category : #setting }
GithubJSON >> fromJson: ajson [
	^ self explicitRequirement 
]
