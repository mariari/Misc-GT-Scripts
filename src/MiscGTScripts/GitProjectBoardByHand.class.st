Class {
	#name : #GitProjectBoardByHand,
	#superclass : #GitProjectBoard,
	#instVars : [
		'items'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitProjectBoardByHand >> computeItems [
	^ items
]

{ #category : #accessing }
GitProjectBoardByHand >> items: topicsList [
	items := topicsList
]
