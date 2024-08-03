"
I am a project board item, which are various `Issues` and `Pull Requests` there may be in a project.


The labels in my {{gtClass:name=GitLabelsMixin}} refers to the labels I am applied with. This is different from {{gtClass:name=GitProjectBoard}} in that those are for exclusive status's while my labels are all the tags that have been placed on me.
"
Class {
	#name : #ProjectBoardItem,
	#superclass : #Object,
	#traits : 'GitLabelsMixin',
	#classTraits : 'GitLabelsMixin classTrait',
	#instVars : [
		'tags',
		'status',
		'itemNumber',
		'projectInfo'
	],
	#category : #'MiscGTScripts-git'
}

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
ProjectBoardItem >> hasProjectInfo [
	^ self projectInfo isNotNil
]

{ #category : #predicates }
ProjectBoardItem >> isTopic [
	^ self subclassResponsibility
]

{ #category : #accessing }
ProjectBoardItem >> itemName [
	^ self subclassResponsibility
]

{ #category : #accessing }
ProjectBoardItem >> itemNumber [
	^ itemNumber
]

{ #category : #accessing }
ProjectBoardItem >> itemNumber: anObject [
	itemNumber := anObject
]

{ #category : #accessing }
ProjectBoardItem >> labelName [
	^ 'current tags'
]

{ #category : #accessing }
ProjectBoardItem >> projectInfo [
	<return: #GitProjectInfo>
	^ projectInfo
]

{ #category : #setting }
ProjectBoardItem >> projectInfo: anObject [
	projectInfo := anObject
]

{ #category : #accessing }
ProjectBoardItem >> status [
	^ status
]

{ #category : #setting }
ProjectBoardItem >> status: anObject [
	status := anObject
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
					items: (self hasProjectInfo ifTrue: [ self projectInfo statuses ] ifFalse: [ {} ]);
					itemDataBinder: [ :statusWidget :aStatus :anIndex | 
						BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude
									+ (self borderStatusColoredAptitudeWithStatus: aStatus);
							margin: (BlInsets all: 5);
							border: aStatus color;
							background: aStatus color;
							label: aStatus name;
							action: [ :aButton | 
								self status: aStatus.
								compute_look value: aStatus.

								aButton fireEvent: BrDropdownHideWish new.
								aButton notifyExtentChanged.
								theButton viewModel request: BrLabelRequest new ] ] ].

	^ theButton
		aptitude: aLabelLook + BrIconAptitude + rectAptitude + glamDropDownStatuses;
		border: self status color;
		icon: BrGlamorousIcons menu
]
