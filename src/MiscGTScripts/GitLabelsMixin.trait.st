Trait {
	#name : #GitLabelsMixin,
	#instVars : [
		'allLabels'
	],
	#category : #'MiscGTScripts-git'
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
		priority: 11;
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
