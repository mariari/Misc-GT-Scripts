"
I am a project board, which has project relevant information.


The labels in my {{gtClass:name=GitLabelsMixin}} refers to the status my {{gtMethod:name=GitProjectBoard>>items}}can have. This is different from {{gtClass:name=GitProjectBoard}} in that those are for exclusive status's while my labels are all the tags that have been placed on me.
"
Class {
	#name : #GitProjectBoard,
	#superclass : #Object,
	#traits : 'GitLabelsMixin',
	#classTraits : 'GitLabelsMixin classTrait',
	#instVars : [
		'repo',
		'candidate',
		'items',
		'depCache'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitProjectBoard >> candidate [
	^ candidate
]

{ #category : #accessing }
GitProjectBoard >> candidate: aString [
	candidate := IceGitLocalBranch named: aString inRepository: self repo
]

{ #category : #accessing }
GitProjectBoard >> candidateBranch: aBranch [
	<argument: #aBranch isKindOf: #IceGitLocalBranch>
	candidate := aBranch
]

{ #category : #visualization }
GitProjectBoard >> computeDepCache [
	self loadAllItems.
	depCache := GitDepGraph new: self itemTopics
]

{ #category : #accessing }
GitProjectBoard >> computeItems [
	"Computes the project board items"
	^ self subclassResponsibility
]

{ #category : #accessing }
GitProjectBoard >> depCache [
	^ depCache ifNil: [ self computeDepCache ]
]

{ #category : #setting }
GitProjectBoard >> gitLocation: aPath [
	<argument: #aPath isKindOf: #FileLocator>
	repo := IceLibgitRepository new location: aPath
]

{ #category : #visualization }
GitProjectBoard >> gtRepositoryDependencies: aView [
	<gtView>
	^ aView forward
		title: 'Topic Dependency Graph';
		priority: 10;
		object: [ self depCache ];
		view: #gtRepositoryDependencies:;
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Update'
			action: [ :aButton :aTab | 
				self computeItems.
				self computeDepCache.
				aTab viewContentElement phlow update ]
]

{ #category : #visualization }
GitProjectBoard >> gtRepositoryProjectBoard: aView [
	<gtView>
	^ self gtRepositoryProjectBoard: aView withItems: [ self computeItems ]
]

{ #category : #visualization }
GitProjectBoard >> gtRepositoryProjectBoard: aView withItems: itemGen [
	| topicName color columned |
	columned := aView columnedList.
	columned
		title: 'Whats Cooking';
		items: itemGen;
		priority: 10;
		column: 'Index'
			text: [ :aValue :anIndex | anIndex asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
			width: 40;
		column: 'Topic Name'
			text: [ :aValue | 
				color := self isInReleaseColor: aValue.
				topicName := aValue itemName asRopedText.
				topicName foreground: color ]
			width: 300;
		column: 'State'
			do: [ :aColumn | 
				aColumn
					stencil: [ :eachTopic | eachTopic updateStatusButton ];
					width: 130 ];
		column: 'Tags'
			do: [ :aColumn | 
				aColumn
					stencil: [ :aValue | aValue item contents labelsCrumbList ];
					width: 300 ].

	^ columned actionUpdateButton
]

{ #category : #accessing }
GitProjectBoard >> hasReleaseCandidate [
	^ candidate isNotNil
]

{ #category : #accessing }
GitProjectBoard >> isInReleaseColor: anItem [
	<argument: #aValue isKindOf: #GitTopicInfo>
	anItem isTopic & anItem isKnownCommit ifFalse: [ ^ Color lightBrown ].
	self hasReleaseCandidate & anItem isTopic
		ifTrue: [ (self candidate commit isParentOf: anItem topic commit)
				ifTrue: [ ^ Color fromHexString: '087D91' ]
				ifFalse: [ ^ Color fromHexString: '911c08' ] ].
	anItem isTopic not ifTrue: [ ^ Color fromHexString: '378b74' ].
	^ Color black
]

{ #category : #visualization }
GitProjectBoard >> itemTopics [
	^ self items select: [ :anItem | anItem isTopic ]
]

{ #category : #accessing }
GitProjectBoard >> items [
	"Returns a closure of the items"

	<return: #Collection of: #ProjectBoardItem>
	items isNil ifTrue: [ ^ self computeItems ].
	items isAsyncStream ifFalse: [ items isEmpty ifTrue: [ ^ self computeItems ] ].
	^ items
]

{ #category : #accessing }
GitProjectBoard >> labelName [
	^ 'Project Statuses'
]

{ #category : #initalization }
GitProjectBoard >> loadAllItems [
	"Load all items from an asynchronous stream into an array if items is an asynchronous stream."

	self items isAsyncStream ifTrue: [ items := self items toArray wait ]
]

{ #category : #accessing }
GitProjectBoard >> repo [
	^ repo
]

{ #category : #accessing }
GitProjectBoard >> repo: anObject [
	repo := anObject
]
