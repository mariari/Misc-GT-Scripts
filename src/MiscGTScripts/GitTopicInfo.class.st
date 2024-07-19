Class {
	#name : #GitTopicInfo,
	#superclass : #ProjectBoardItem,
	#instVars : [
		'topic',
		'description'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitTopicInfo >> gtCommitsFor: aView [
	<gtView>
	^ aView forward
		title: 'commits';
		priority: 10;
		object: [ topic ];
		view: #gtCommitsFor:
]

{ #category : #accessing }
GitTopicInfo >> isTopic [
	^ true
]

{ #category : #printing }
GitTopicInfo >> printOn: stream [
	^ stream nextPutAll: self topic name
]

{ #category : #accessing }
GitTopicInfo >> topic [
	^ topic
]

{ #category : #setting }
GitTopicInfo >> topic: atopic [
	topic := atopic
]

{ #category : #setting }
GitTopicInfo >> topic: atopic tags: atags [
	self topic: atopic.
	self tags: atags.
	self
]

{ #category : #accessing }
GitTopicInfo >> topicName [
	^ self topic name
]

{ #category : #accessing }
GitTopicInfo >> topicShortName [
	^ self topic shortName
]
