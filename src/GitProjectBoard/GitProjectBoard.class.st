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
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GitProjectBoard >> candidate [
	^ candidate
]

{ #category : #accessing }
GitProjectBoard >> candidate: anAssoc [
	candidate := IceGitLocalBranch
			named: anAssoc value
			inRepository: (self repo at: anAssoc key)
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
	^ depCache
		ifNil: [ self computeDepCache.
			depCache ]
]

{ #category : #setting }
GitProjectBoard >> gitLocation: paths [
	<argument: #paths isKindOf: #Dictionary>
	repo := paths collect: [ :aPath | IceLibgitRepository new location: aPath ]
]

{ #category : #visualization }
GitProjectBoard >> gtRepositoryDependencies: aView [
    <gtView>
    ^ aView mondrian
        title: 'Topic Dependency Graph';
        priority: 10;
        painting: [ :view |  self depCache gtTopicDependencyMorph: view ];
        in: [:view | self gtUpdateDepCache: view]
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
		priority: 11;
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

{ #category : #visualization }
GitProjectBoard >> gtUpdateDepCache: aView [
	^ aView
		actionButtonIcon: BrGlamorousVectorIcons refresh
		tooltip: 'Update'
		action: [ :aButton :aTab | 
			self computeItems.
			self computeDepCache.
			aTab viewContentElement phlow update ]
]

{ #category : #accessing }
GitProjectBoard >> hasReleaseCandidate [
	^ candidate isNotNil
]

{ #category : #accessing }
GitProjectBoard >> isInReleaseColor: anItem [
	<argument: #aValue isKindOf: #GitTopicInfo>
	anItem isTopic not ifTrue: [ ^ Color fromHexString: '378b74' ].
	anItem isTopic & anItem isKnownCommit ifFalse: [ ^ Color lightBrown ].
	self hasReleaseCandidate & anItem isTopic
		ifTrue: [ (self candidate commit isParentOf: anItem topic commit)
				ifTrue: [ ^ Color fromHexString: '087D91' ]
				ifFalse: [ ^ Color fromHexString: '911c08' ] ].
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
