Class {
	#name : #GitDepFocusedGraph,
	#superclass : #GitDepGraph,
	#instVars : [
		'focusedNodes'
	],
	#category : #'MiscGTScripts-git  - graph'
}

{ #category : #coloring }
GitDepFocusedGraph >> decideBackgrondColor: aNode [
	(focusedNodes includes: aNode)
		ifTrue: [ ^ (Color fromHexString: '#e8f4f8') asBlBackground ].
	^ super decideBackgrondColor: aNode
]

{ #category : #accessing }
GitDepFocusedGraph >> focusedNodes [
	^ focusedNodes
]

{ #category : #accessing }
GitDepFocusedGraph >> focusedNodes: anObject [
	focusedNodes := anObject
]
