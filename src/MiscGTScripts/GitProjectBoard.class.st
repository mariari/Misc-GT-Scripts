Class {
	#name : #GitProjectBoard,
	#superclass : #Object,
	#instVars : [
		'repo',
		'statuses',
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

{ #category : #accessing }
GitProjectBoard >> dropDownStatusFrom: eachTopic [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAndIconAptitude
				+ (BrGlamorousWithDropdownAptitude
						handle: [ BrButton new
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
								icon: BrGlamorousIcons menu ]
						content: [ BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude;
								margin: (BlInsets all: 20);
								label: 'Close';
								action: [ :aButton | aButton fireEvent: BrDropdownHideWish new ] ]);
		label: eachTopic status;
		icon: BrGlamorousIcons menu;
		yourself
]

{ #category : #setting }
GitProjectBoard >> gitLocation: aPath [
	<argument: #aPath isKindOf: #FileLocator>
	repo := IceLibgitRepository new location: aPath
]

{ #category : #accessing }
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
					stencil: [ :eachTopic | self dropDownStatusFrom: eachTopic ];
					width: 130 ];
		column: 'Tags'
			text: [ :aValue | aValue tags asString asRopedText foreground: BrGlamorousColors darkBorderColor ]
			width: 500.
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
	^ self computeItems
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

{ #category : #accessing }
GitProjectBoard >> statuses [
	^ statuses
]

{ #category : #accessing }
GitProjectBoard >> statuses: anObject [
	statuses := anObject
]
