Class {
	#name : #GitReleaseStatus,
	#superclass : #Object,
	#instVars : [
		'releaseBranch',
		'topics'
	],
	#category : #'MiscGTScripts-git'
}

{ #category : #accessing }
GitReleaseStatus >> gtRepositoryProjectBoard: aView [
	<gtView>
	| topicName color |
	^ aView columnedList
		title: 'Project Board';
		items: [ self topics ];
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
			text: [ :aValue | aValue status ]
			width: 200;
		column: 'Tags'
			text: [ :aValue | aValue tags asString asRopedText foreground: BrGlamorousColors darkBorderColor ]
			width: 500
]

{ #category : #accessing }
GitReleaseStatus >> hasReleaseCandidate [
	^ self releaseCandidate isNotNil
]

{ #category : #accessing }
GitReleaseStatus >> isInReleaseColor: aValue [
	<argument: #aValue isKindOf: #GitTopicInfo>
	^ self hasReleaseCandidate
		ifTrue: [ (self releaseCandidate commit isParentOf: aValue topic commit)
				ifTrue: [ Color fromHexString: '087D91' ]
				ifFalse: [ Color fromHexString: '911c08' ] ]
		ifFalse: [ Color black ]
]

{ #category : #accessing }
GitReleaseStatus >> releaseBranch [
	<return: #IceBranch>
	^ releaseBranch
]

{ #category : #setter }
GitReleaseStatus >> releaseBranch: aTopic [
	releaseBranch := aTopic
]

{ #category : #accessing }
GitReleaseStatus >> releaseCandidate [
	^ releaseBranch
]

{ #category : #accessing }
GitReleaseStatus >> topics [
	^ topics
]

{ #category : #setter }
GitReleaseStatus >> topics: anObject [
	topics := anObject
]
