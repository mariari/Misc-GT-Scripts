Class {
	#name : #GitTopicInfo,
	#superclass : #ProjectBoardItem,
	#instVars : [
		'topic'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #queries }
GitTopicInfo >> allChildrenIn: topics andCache: aDictionary [
	"We check what topics in the topics list is our parent .
	
	Along the way we call ourselves on any parent of ours to compute their parents, 
	as their parents are our parents.
	
	Along the way we cache all of these results in our Dictionary.
	If we have already been computed, then we simply return."

	"The childSet represents our set. The ignore set, is a good shorthand for 
	checking if some branch and their children we can ignore"

	<argument: #topics isKindOf: #Collection>
	<argument: #itemDeps isKindOf: #Dictionary>
	<return: #OrderedCollection of: #GitTopicInfo>
	^ self
		allChildrenIn: topics
		andCache: aDictionary
		andIgnore: Set new
]

{ #category : #queries }
GitTopicInfo >> allChildrenIn: topics andCache: aDictionary andIgnore: ignoreSet [
	"We check what topics in the topics list is our parent .
	
	Along the way we call ourselves on any parent of ours to compute their parents, 
	as their parents are our parents.
	
	Along the way we cache all of these results in our Dictionary.
	If we have already been computed, then we simply return."

	"The childSet represents our set. The ignore set, is a good shorthand for 
	checking if some branch and their children we can ignore"

	<argument: #topics isKindOf: #Collection>
	<argument: #itemDeps isKindOf: #Dictionary>
	<return: #OrderedCollection of: #GitTopicInfo>
	| childSet |
	^ (aDictionary includesKey: self)
		ifTrue: [ aDictionary at: self ]
		ifFalse: [ childSet := Set new.
			topics
				do: [ :oTopic | 
					(childSet includes: oTopic) | (self = oTopic) | (ignoreSet includes: oTopic)
						ifFalse: [ (self isParentOf: oTopic)
								ifTrue: [ childSet
										add: oTopic;
										addAll: (oTopic
												allChildrenIn: topics
												andCache: aDictionary
												andIgnore: ignoreSet copy) ]
								ifFalse: [ ignoreSet add: oTopic ] ] ].
			aDictionary at: self put: childSet.
			childSet ]
]

{ #category : #accessing }
GitTopicInfo >> gitRepository: aRepo [
	| possibleRemotes res |
	possibleRemotes := aRepo remotes
			collect: [ :remote | 
				IceGitRemoteBranch
					named: remote name , '/' , self item contents refName
					inRepository: aRepo ].
	res := possibleRemotes
			detect: [ :remote | (aRepo lookupCommit: remote fullname ifAbsent: [ false ]) isBoolean not ]
			ifNone: [ possibleRemotes first ].
	self topic: res
]

{ #category : #accessing }
GitTopicInfo >> gtCommitsFor: aView [
	<gtView>
	topic ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'commits';
		priority: 10;
		object: [ topic ];
		view: #gtCommitsFor:
]

{ #category : #accessing }
GitTopicInfo >> isKnownCommit [
	^ self topic
		ifNil: [ false ]
		ifNotNil: [ :aTop | (aTop repositoryHandle lookupRemoteBranch: aTop name ifAbsent: [ nil ]) isNotNil ]
]

{ #category : #predicates }
GitTopicInfo >> isParentOf: anotherTopic [
	<argument: #anotherTopic isKindOf: #GitTopicInfo>
	<return: #Boolean>
	^ self topic repository location = anotherTopic topic repository location
		ifFalse: [ false ]
		ifTrue: [ [ self topic commit id
				= (self topic repository
						mergeBaseBetween: self topic commit id
						and: anotherTopic topic commit id) ] on: Error do: [ :ex | false ] ]
]

{ #category : #accessing }
GitTopicInfo >> isTopic [
	^ true
]

{ #category : #accessing }
GitTopicInfo >> itemName [
	^ self topicShortName
]

{ #category : #printing }
GitTopicInfo >> printOn: stream [
	stream
		nextPutAll: self topicName;
		nextPutAll: ' #'.

	self itemNumber printOn: stream base: 10.
	^ stream
]

{ #category : #accessing }
GitTopicInfo >> topic [
	^ topic
]

{ #category : #setting }
GitTopicInfo >> topic: atopic [
	topic := atopic
]

{ #category : #accessing }
GitTopicInfo >> topicName [
	^ self topic ifNil: [ item itemName ] ifNotNil: [ :top | top name ]
]

{ #category : #accessing }
GitTopicInfo >> topicShortName [
	^ self topic ifNil: [ item itemName ] ifNotNil: [ :top | top shortName ]
]
