Class {
	#name : #GitProjectBoardByHand,
	#superclass : #GitProjectBoard,
	#category : #'GitProjectBoard-git'
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
