"
I represent informaiton from a github repository using the [](https://docs.github.com/en/graphql) github API.

My {{gtClass:name=GitLabelsMixin}} refers to the labels that {{gtClass:name=GitTopicInfo}} or {{gtClass:name=GitIssueInfo}} may contain.
"
Class {
	#name : #GithubRepo,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON + GitLabelsMixin',
	#classTraits : 'GithubJSON classTrait + GitLabelsMixin classTrait',
	#category : #'MiscGTScripts-git'
}

{ #category : #setting }
GithubRepo >> fromJson: ajson [
	self
		allLabels: ((ajson atPath: #(labels edges))
				collect: [ :node | GitLabelInfo new fromJson: (node at: #node) ]).
	^ self
]

{ #category : #accessing }
GithubRepo >> labelName [
	^ 'Labels'
]
