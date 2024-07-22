Class {
	#name : #GitDepGraph,
	#superclass : #Object,
	#instVars : [
		'itemNodeIndex',
		'nodes',
		'rawTopics'
	],
	#category : #'MiscGTScripts-git  - graph'
}

{ #category : #creating }
GitDepGraph class >> new: topics [
	"We try to preserve order"

	<argument: #topics isKindOf: #GitTopicInfo>
	| nodes |
	nodes := topics collect: [ :aTopic | aTopic -> (GitDepTopic new: aTopic) ].
	^ self basicNew
		rawTopics: topics copy;
		nodes: (nodes collect: [ :node | node value ]);
		itemNodeIndex: (nodes as: Dictionary)
]

{ #category : #visualization }
GitDepGraph >> gtRepositoryDependencies: aView [
	<gtView>
	^ aView mondrian
		title: 'Topic Dependency Graph';
		painting: [ :view | self gtTopicDependencyMorph: view ]
]

{ #category : #accessing }
GitDepGraph >> gtTopicDependencyMorph: view [
	| color items |
	items := self nodes.
	view nodes
		shape: [ :aValue | 
			BrButton new
				fitContent;
				aptitude: BrGlamorousButtonRectangularAptitude
						+ (BrLabelAptitude new
								foreground: Color black;
								glamorousRegularFont;
								fontSize: 10);
				border: aValue topic status color;
				label: aValue topic topicShortName asRopedText;
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
			toAll: [ :aNode | 
				| parentNodes |
				parentNodes := aNode parents.
				parentNodes
					select: [ :oNode | parentNodes noneSatisfy: [ :ooNode | ooNode parents includes: oNode ] ] ].
	view layout
		custom: (GtGradHorizontalDominanceCenteredTreeLayout new
				levelDistance: 60;
				nodeDistance: 5).
	^ view
]

{ #category : #accessing }
GitDepGraph >> itemNodeIndex [
	^ itemNodeIndex
]

{ #category : #accessing }
GitDepGraph >> itemNodeIndex: anObject [
	itemNodeIndex := anObject
]

{ #category : #accessing }
GitDepGraph >> nodes [
	^ nodes
]

{ #category : #accessing }
GitDepGraph >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
GitDepGraph >> rawTopics [
	^ rawTopics
]

{ #category : #accessing }
GitDepGraph >> rawTopics: anObject [
	rawTopics := anObject
]
