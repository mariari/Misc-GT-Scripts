Class {
	#name : #GitIssueInfo,
	#superclass : #ProjectBoardItem,
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GitIssueInfo >> gitRepository: aRepo [
	"do nothing, as issues aren't real"

	
]

{ #category : #accessing }
GitIssueInfo >> isTopic [
	^ false
]

{ #category : #accessing }
GitIssueInfo >> itemName [
	^ self item name
]
