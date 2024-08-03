Class {
	#name : #GitIssueInfo,
	#superclass : #ProjectBoardItem,
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitIssueInfo >> gitRepository: aRepo andRemoteName: upstream [
	"do nothing, as issues aren't real"

	
]

{ #category : #accessing }
GitIssueInfo >> isTopic [
	^ false
]

{ #category : #accessing }
GitIssueInfo >> itemName [
	^ self item itemName
]
