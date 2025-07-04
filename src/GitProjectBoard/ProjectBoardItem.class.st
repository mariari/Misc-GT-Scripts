"
I am a project board item, which are various `Issues` and `Pull Requests` there may be in a project.


The labels in my {{gtClass:name=GitLabelsMixin}} refers to the labels I am applied with. This is different from {{gtClass:name=GitProjectBoard}} in that those are for exclusive status's while my labels are all the tags that have been placed on me.
"
Class {
	#name : #ProjectBoardItem,
	#superclass : #Object,
	#instVars : [
		'item',
		'projectBoard',
		'repo'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
ProjectBoardItem >> author [
	^ item author
]

{ #category : #accessing }
ProjectBoardItem >> borderStatusColoredAptitude [
	^ self borderStatusColoredAptitudeWithStatus: self status
]

{ #category : #accessing }
ProjectBoardItem >> borderStatusColoredAptitudeWithStatus: aStatus [
	^ BrStyleCommonAptitude new
		default: [ :aStyle | aStyle border:  aStatus color ]
]

{ #category : #accessing }
ProjectBoardItem >> currentLabels [
	^ item allLabels
]

{ #category : #accessing }
ProjectBoardItem >> gitRepository: aRepo [
	^ self subclassResponsibility
]

{ #category : #accessing }
ProjectBoardItem >> gtCurrentLabelsView: aView [
	<gtView>
	self item ifNil: [ ^ aView empty ].
	self currentLabels ifNil: [ ^ aView empty ].
	^ aView forward
		object: [ item ];
		priority: 12;
		title: 'Current Labels';
		view: #gtLabelView:
]

{ #category : #accessing }
ProjectBoardItem >> gtLabelsView: aView [
	<gtView>
	self repo ifNil: [ ^ aView empty ].
	^ aView forward
		object: [ repo ];
		priority: 13;
		title: 'Repository labels';
		view: #gtLabelView:
]

{ #category : #accessing }
ProjectBoardItem >> gtStatusView: aView [
	<gtView>
	self projectBoard ifNil: [ ^ aView empty ].
	^ aView forward
		object: [ projectBoard ];
		priority: 13;
		title: 'Statuses';
		view: #gtLabelView:
]

{ #category : #accessing }
ProjectBoardItem >> hasProjectBoard [
	^ self projectBoard isNotNil
]

{ #category : #predicates }
ProjectBoardItem >> isTopic [
	^ self subclassResponsibility
]

{ #category : #accessing }
ProjectBoardItem >> item [
	^ item
]

{ #category : #accessing }
ProjectBoardItem >> item: anObject [
	item := anObject
]

{ #category : #accessing }
ProjectBoardItem >> itemName [
	^ self subclassResponsibility
]

{ #category : #accessing }
ProjectBoardItem >> itemNumber [
	^ item itemNumber
]

{ #category : #accessing }
ProjectBoardItem >> labelName [
	^ 'current tags'
]

{ #category : #accessing }
ProjectBoardItem >> printOn: stream [
	stream
		nextPutAll: self itemName;
		nextPutAll: ' #'.

	self itemNumber printOn: stream base: 10.
	^ stream
]

{ #category : #accessing }
ProjectBoardItem >> projectBoard [
	^ projectBoard
]

{ #category : #accessing }
ProjectBoardItem >> projectBoard: anObject [
	projectBoard := anObject
]

{ #category : #accessing }
ProjectBoardItem >> repo [
	^ repo
]

{ #category : #accessing }
ProjectBoardItem >> repo: anObject [
	repo := anObject
]

{ #category : #accessing }
ProjectBoardItem >> status [
	^ item status
]

{ #category : #accessing }
ProjectBoardItem >> updateStatusButton [
	| aLabelLook theButton rectAptitude compute_look glamDropDownStatuses |
	aLabelLook := BrLabelAptitude new.
	aLabelLook
		fontName: 'Source Sans Pro';
		fontSize: 15;
		foreground: Color black;
		text: 'help'.

	theButton := BrButton new.
	rectAptitude := BrGlamorousButtonRectangularAptitude new.

	compute_look := [ :aStatus | 
		theButton border: self status color.
		theButton label: aStatus name ].

	compute_look value: self status.

	glamDropDownStatuses := BrGlamorousWithDropdownAptitude
			handle: [ BrButton new
					aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousToggleWithLabelAptitude;
					icon: BrGlamorousIcons menu ]
			content: [ BrSimpleList new
					items: (self hasProjectBoard ifTrue: [ self projectBoard statuses ] ifFalse: [ {} ]);
					itemDataBinder: [ :statusWidget :aStatus :anIndex | 
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude
									+ (self borderStatusColoredAptitudeWithStatus: aStatus);
							margin: (BlInsets all: 5);
							border: aStatus color;
							background: aStatus color;
							label: aStatus name;
							action: [ :aButton | 
								self item status: aStatus.
								compute_look value: aStatus.

								aButton fireEvent: BrDropdownHideWish new.
								aButton notifyExtentChanged.
								theButton viewModel request: BrLabelRequest new ] ] ].

	^ theButton
		aptitude: aLabelLook + BrIconAptitude + rectAptitude + glamDropDownStatuses;
		border: self status color;
		icon: BrGlamorousIcons menu
]
