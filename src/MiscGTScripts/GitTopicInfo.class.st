Class {
	#name : #GitTopicInfo,
	#superclass : #Object,
	#instVars : [
		'topic',
		'tags',
		'status',
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
GitTopicInfo >> status [
	^ status
]

{ #category : #setting }
GitTopicInfo >> status: aString [
	status := aString
]

{ #category : #accessing }
GitTopicInfo >> tags [
	^ tags
]

{ #category : #setting }
GitTopicInfo >> tags: atags [
	tags := atags
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
