Class {
	#name : #GitProjectBoardAuthor,
	#superclass : #Object,
	#instVars : [
		'author',
		'projectBoard'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitProjectBoardAuthor >> author [
	^ author
]

{ #category : #accessing }
GitProjectBoardAuthor >> author: anObject [
	author := anObject
]

{ #category : #graph }
GitProjectBoardAuthor >> authorDependencyGraph [
	^ ((self authorTopics: projectBoard depCache nodes)
		detect: [ :anItem | anItem author = author ]
		ifNone: [ ^ projectBoard depCache ]) nodesWithTheSameAuthor
]

{ #category : #visualization }
GitProjectBoardAuthor >> authorTopics: items [
	^ items select: [ :anItem | anItem author = author ]
]

{ #category : #visualization }
GitProjectBoardAuthor >> gtRepositoryDependencies: aView [
	<gtView>
	^ aView forward
		title: (author , '''s Dependency Graph') capitalized;
		priority: 10;
		object: [ self authorDependencyGraph ];
		view: #gtRepositoryDependencies:
]

{ #category : #visualization }
GitProjectBoardAuthor >> gtRepositoryProjectBoard: aView [
	<gtView>
	^ projectBoard
		gtRepositoryProjectBoard: aView
		withItems: [ self authorTopics: projectBoard items ]
]

{ #category : #accessing }
GitProjectBoardAuthor >> projectBoard [
	^ projectBoard
]

{ #category : #accessing }
GitProjectBoardAuthor >> projectBoard: anObject [
	projectBoard := anObject
]
