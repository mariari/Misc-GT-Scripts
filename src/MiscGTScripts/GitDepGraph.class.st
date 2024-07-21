Class {
	#name : #GitDepGraph,
	#superclass : #Object,
	#instVars : [
		'itemNodeIndex',
		'nodes',
		'rawTopics'
	],
	#category : #'MiscGTScripts-git  - graph'
}

{ #category : #creating }
GitDepGraph class >> new: topics [
	<argument: #topics isKindOf: #GitTopicInfo>
	| nodes |
	nodes := topics
			collect: [ :aTopic | aTopic -> (GitDepTopic new: aTopic) ]
			as: Dictionary.
	^ self basicNew
		rawTopics: nodes keys;
		nodes: nodes values;
		itemNodeIndex: nodes
]

{ #category : #accessing }
GitDepGraph >> itemNodeIndex [
	^ itemNodeIndex
]

{ #category : #accessing }
GitDepGraph >> itemNodeIndex: anObject [
	itemNodeIndex := anObject
]

{ #category : #accessing }
GitDepGraph >> nodes [
	^ nodes
]

{ #category : #accessing }
GitDepGraph >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
GitDepGraph >> rawTopics [
	^ rawTopics
]

{ #category : #accessing }
GitDepGraph >> rawTopics: anObject [
	rawTopics := anObject
]
