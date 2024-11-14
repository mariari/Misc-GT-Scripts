Trait {
	#name : #GitLabelsMixin,
	#instVars : [
		'allLabels'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GitLabelsMixin >> allLabels [
	<return: #GitLabelInfo>
	^ allLabels
]

{ #category : #setting }
GitLabelsMixin >> allLabels: anObject [
	allLabels := anObject
]

{ #category : #visualization }
GitLabelsMixin >> gtLabelView: aView [
	<gtView>
	self allLabels ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: self labelName;
		priority: 12;
		items: self allLabels;
		column: 'Col'
			stencil: [ :label | BlElement new addChild: label smallVerticalColor ]
			width: 30;
		column: 'status' stencil: [ :label | label fullDescription ]
]

{ #category : #accessing }
GitLabelsMixin >> labelName [
	^ self explicitRequirement
]

{ #category : #accessing }
GitLabelsMixin >> labelsCrumbList [
	^ BrBreadcrumb new
		aptitude: (BrGlamorousBreadcrumbAptitude new
				separator: [ BrLabel new
						aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
						text: ',';
						margin: (BlInsets left: 5 right: 5) ]);
		addItems: (self allLabels
				collect: [ :label | 
					BrLabel new
						text: label name;
						aptitude: (BrGlamorousLabelAptitude new foreground: label color) ])
]
