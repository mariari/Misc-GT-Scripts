Class {
	#name : #GitProjectBoardByHand,
	#superclass : #GitProjectBoard,
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitProjectBoardByHand >> computeItems [
	^ items
]

{ #category : #accessing }
GitProjectBoardByHand >> items: anItems [
	items := anItems.
	^ anItems
]
