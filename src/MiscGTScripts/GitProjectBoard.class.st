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
		'remoteName',
		'items'
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

{ #category : #accessing }
GitProjectBoard >> computeItems [
	"Computes the project board items"
	^ self subclassResponsibility
]

{ #category : #setting }
GitProjectBoard >> gitLocation: aPath [
	<argument: #aPath isKindOf: #FileLocator>
	repo := IceLibgitRepository new location: aPath
]

{ #category : #visualization }
GitProjectBoard >> gtRepositoryDependencies: aView [
	<gtView>
	| depGraph itemFunc nodes |
	itemFunc := [ :itemList | (itemList select: [ :anItem | anItem isTopic ]) reverse ].
	depGraph := GitDepGraph new: (itemFunc value: self items).
	^ aView forward
		title: 'Topic Dependency Graph';
		priority: 10;
		object: [ depGraph computeRelations.
			depGraph ];
		view: #gtRepositoryDependencies:;
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Update'
			action: [ :aButton :aTab | 
				nodes := GitDepGraph freshNodes: (itemFunc value: self computeItems).
				depGraph initalizeWith: nodes.
				depGraph computeRelations.
				aTab viewContentElement phlow update ]
]

{ #category : #visualization }
GitProjectBoard >> gtRepositoryProjectBoard: aView [
	<gtView>
	| topicName color columned |
	columned := aView columnedList.
	columned
		title: 'Whats Cooking';
		items: [ self computeItems select: [ :anItem | anItem isTopic ] ];
		priority: 10;
		column: 'Index'
			text: [ :aValue :anIndex | anIndex asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
			width: 40;
		column: 'Topic Name'
			text: [ :aValue | 
				color := self isInReleaseColor: aValue.
				topicName := aValue topicName asRopedText.
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
					stencil: [ :aValue | aValue labelsCrumbList ];
					width: 300 ].

	^ columned actionUpdateButton
]

{ #category : #accessing }
GitProjectBoard >> hasReleaseCandidate [
	^ candidate isNotNil
]

{ #category : #accessing }
GitProjectBoard >> isInReleaseColor: aValue [
	<argument: #aValue isKindOf: #GitTopicInfo>
	^ self hasReleaseCandidate
		ifTrue: [ (self candidate commit isParentOf: aValue topic commit)
				ifTrue: [ Color fromHexString: '087D91' ]
				ifFalse: [ Color fromHexString: '911c08' ] ]
		ifFalse: [ Color black ]
]

{ #category : #accessing }
GitProjectBoard >> items [
	"Returns a closure of the items"

	<return: #Collection of: #ProjectBoardItem>
	items isNil ifTrue: [ ^ self computeItems ].
	^ items
]

{ #category : #accessing }
GitProjectBoard >> labelName [
	^ 'Project Statuses'
]

{ #category : #accessing }
GitProjectBoard >> remoteName [
	^ remoteName
]

{ #category : #accessing }
GitProjectBoard >> remoteName: anObject [
	remoteName := anObject
]

{ #category : #accessing }
GitProjectBoard >> repo [
	^ repo
]

{ #category : #accessing }
GitProjectBoard >> repo: anObject [
	repo := anObject
]
