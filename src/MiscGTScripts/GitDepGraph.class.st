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
GitDepGraph class >> freshNodes: topics [
	^ topics collect: [ :aTopic | aTopic -> (GitDepTopic new: aTopic) ]
]

{ #category : #creating }
GitDepGraph class >> new: topics [
	"We try to preserve order"

	<argument: #topics isKindOf: #GitTopicInfo>
	^ self basicNew initalizeWith: (self freshNodes: topics)
]

{ #category : #creating }
GitDepGraph class >> newWithExistingNodes: aNodes [
	^ self new
		initalizeWith: (aNodes collect: [ :aDepTopic | aDepTopic topic -> aDepTopic ])
]

{ #category : #accessing }
GitDepGraph >> computeRelations [
	nodes do: [ :node | node computeRelationsWith: self ]
]

{ #category : #coloring }
GitDepGraph >> decideBackgrondColor: aNode [
	^ aNode topic isKnownCommit
		ifTrue: [ Color white ]
		ifFalse: [ Color veryPaleRed ]
]

{ #category : #visualization }
GitDepGraph >> gtRepositoryDependencies: aView [
	<gtView>
	^ aView mondrian
		title: 'Topic Dependency Graph';
		painting: [ :view | self gtTopicDependencyMorph: view ]
]

{ #category : #visualization }
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
				label: (aValue topic topicShortName , ' #'
						, (aValue topic itemNumber printStringBase: 10)) asRopedText;
				background: (self decideBackgrondColor: aValue);
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

{ #category : #creating }
GitDepGraph >> initalizeWith: aNodes [
	^ self
		rawTopics: (aNodes collect: [ :node | node key ]);
		nodes: (aNodes collect: [ :node | node value ]);
		itemNodeIndex: (aNodes as: Dictionary)
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
