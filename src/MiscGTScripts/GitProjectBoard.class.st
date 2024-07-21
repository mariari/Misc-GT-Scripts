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
		'remoteName'
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
	^ aView mondrian
		title: 'Topic Dependency Graph';
		painting: [ :view | self gtTopicDependencyMorph: view ];
		actionUpdateButton
]

{ #category : #visualization }
GitProjectBoard >> gtRepositoryProjectBoard: aView [
	<gtView>
	| topicName color columned |
	columned := aView columnedList.
	columned
		title: 'Whats Cooking';
		items: [ [ self items ] value asyncSimilarCopy select: [ :anItem | anItem isTopic ] ];
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
					stencil: [ :aValue | 
						BrBreadcrumb new
							aptitude: (BrGlamorousBreadcrumbAptitude new
									separator: [ BrLabel new
											aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
											text: ',';
											margin: (BlInsets left: 5 right: 5) ]);
							addItems: (aValue allLabels
									collect: [ :label | 
										BrLabel new
											text: label name;
											aptitude: (BrGlamorousLabelAptitude new foreground: label color) ]) ];
					width: 300 ].

	^ columned actionUpdateButton
]

{ #category : #visualization }
GitProjectBoard >> gtTopicDependencyMorph: view [
	| color items itemDeps |
	items := [ [ self items ] value asyncSimilarCopy
			select: [ :anItem | anItem isTopic ] ] value toArray wait reverse.
	itemDeps := GitDepGraph new: items.
	itemDeps nodes do: [ :aTopic | aTopic computeRelationsWith: itemDeps ].
	view nodes
		shape: [ :aValue | 
			BrButton new
				fitContent;
				aptitude: BrGlamorousButtonRectangularAptitude
						+ (BrLabelAptitude new
								foreground: Color black;
								glamorousRegularFont;
								fontSize: 10);
				border: aValue status color;
				label: aValue topicShortName asRopedText;
				background: Color white;
				zIndex: 10 ];
		with: items.
	view edges
		shape: [ :x | 
			color := Color blue alpha: 1.0.
			BlLineElement new
				border: (BlBorder paint: (Color black alpha: 0.3) width: 1);
				toHead: (BlArrowheadSimpleArrow new background: color);
				zIndex: -10 ];
		connect: items
			from: [ :aTopic | aTopic ]
			toAll: [ :aTopic | 
				| parentNodes |
				parentNodes := (itemDeps itemNodeIndex at: aTopic) parents.
				parentNodes
					select: [ :oNode | parentNodes noneSatisfy: [ :ooNode | ooNode parents includes: oNode ] ]
					thenCollect: [ :node | node topic ] ].
	view layout
		custom: (GtGradHorizontalDominanceCenteredTreeLayout new
				levelDistance: 60;
				nodeDistance: 5).
	^ view
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
	^ self computeItems
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
