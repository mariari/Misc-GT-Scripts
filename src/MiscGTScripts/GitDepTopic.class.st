Class {
	#name : #GitDepTopic,
	#superclass : #Object,
	#instVars : [
		'finalized',
		'children',
		'parents',
		'topic',
		'parentConsider',
		'childConsider',
		'unrelated'
	],
	#category : #'MiscGTScripts-git  - graph'
}

{ #category : #creation }
GitDepTopic class >> new [
	^ self basicNew
		finalized: false;
		parents: Set new;
		children: Set new;
		childConsider: Set new;
		unrelated: Set new;
		parentConsider: Set new
]

{ #category : #creation }
GitDepTopic class >> new: aTopic [
	^ self new topic: aTopic
]

{ #category : #graph }
GitDepTopic >> addChildren: aNode [
	self children addAll: aNode children
]

{ #category : #graph }
GitDepTopic >> addParents: aNode [
	self parents addAll: aNode parents
]

{ #category : #accessing }
GitDepTopic >> childConsider [
	^ childConsider
]

{ #category : #setting }
GitDepTopic >> childConsider: anObject [
	childConsider := anObject
]

{ #category : #accessing }
GitDepTopic >> children [
	^ children
]

{ #category : #setting }
GitDepTopic >> children: anObject [
	children := anObject
]

{ #category : #graph }
GitDepTopic >> computeRelationsWith: depGraph [
	<argument: #depGraph isKindOf: #GitDepGraph>
	| topics cache aNode |
	self finalized ifTrue: [ ^ self ].
	topics := depGraph rawTopics.
	cache := depGraph itemNodeIndex.
	topics
		do: [ :aTopic | 
			aNode := cache at: aTopic.

			aNode finalized
				ifTrue: [  " self learnFinalizedNode: aNode" ]
				ifFalse: [ self learnUnfinalized: aNode withItsTopic: aTopic ] ].
	self finalized: true.
	^ self
]

{ #category : #accessing }
GitDepTopic >> finalized [
	<return: #Boolean>
	^ finalized
]

{ #category : #setting }
GitDepTopic >> finalized: anObject [
	finalized := anObject
]

{ #category : #visualization }
GitDepTopic >> gtCommitsFor: aView [
	<gtView>
	^ aView forward
		title: 'commits';
		priority: 10;
		object: [ self topic ];
		view: #gtCommitsFor:
]

{ #category : #predicates }
GitDepTopic >> inPopulatedChildCache: aNode [
	^ (self childConsider includes: aNode) | self childConsider isEmpty
]

{ #category : #predicates }
GitDepTopic >> inPopulatedParentCache: aNode [
	^ (self parentConsider includes: aNode) | self parentConsider isEmpty
]

{ #category : #graph }
GitDepTopic >> knowsOf: aNode [
	^ ((self children includes: aNode) | (self parents includes: aNode)
		| (self unrelated includes: aNode) | aNode) = self
]

{ #category : #graph }
GitDepTopic >> learnFinalizedNode: aNode [
	"my child"

	(aNode parents includes: self)
		ifTrue: [ self limitParents: aNode.
			self addChildren: aNode.
			^ self ].

	"my parent"
	(aNode children includes: self)
		ifTrue: [ self limitChildren: aNode.
			self addParents: aNode ]
]

{ #category : #graph }
GitDepTopic >> learnUnfinalized: aNode withItsTopic: aTopic [
	| inPopulatedChildCache inPopulatedParentCache |
	(self knowsOf: aNode) ifTrue: [ ^ self ].
	inPopulatedChildCache := self inPopulatedChildCache: aNode.
	inPopulatedParentCache := self inPopulatedParentCache: aNode.

	(inPopulatedParentCache and: [ self topic isParentOf: aTopic ])
		ifTrue: [ self children add: aNode.
			aNode parents add: self.
			^ self ].
	(inPopulatedChildCache and: [ aTopic isParentOf: self topic ])
		ifTrue: [ self parents add: aNode.
			aNode children add: self.
			^ self ].

	self unrelated add: aNode.
	aNode unrelated add: self
]

{ #category : #graph }
GitDepTopic >> limitChildren: aNode [
	self
		childConsider: (self childConsider
				ifEmpty: [ ^ self childConsider: aNode children copy ]
				ifNotEmpty: [ self childConsider intersection: aNode children ])
]

{ #category : #graph }
GitDepTopic >> limitParents: aNode [
	self
		parentConsider: (self parentConsider
				ifEmpty: [ ^ self parentConsider: aNode parents copy ]
				ifNotEmpty: [ self parentConsider intersection: aNode parents ])
]

{ #category : #accessing }
GitDepTopic >> parentConsider [
	^ parentConsider
]

{ #category : #accessing }
GitDepTopic >> parentConsider: anObject [
	parentConsider := anObject
]

{ #category : #accessing }
GitDepTopic >> parents [
	^ parents
]

{ #category : #setting }
GitDepTopic >> parents: anObject [
	parents := anObject
]

{ #category : #accessing }
GitDepTopic >> printOn: stream [
	^ self topic printOn: stream
]

{ #category : #accessing }
GitDepTopic >> topic [
	^ topic
]

{ #category : #setting }
GitDepTopic >> topic: anObject [
	topic := anObject
]

{ #category : #accessing }
GitDepTopic >> unrelated [
	^ unrelated
]

{ #category : #accessing }
GitDepTopic >> unrelated: anObject [
	unrelated := anObject
]
