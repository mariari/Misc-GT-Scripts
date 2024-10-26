Class {
	#name : #GitLabelInfo,
	#superclass : #GithubGQL,
	#traits : 'GithubJSON',
	#classTraits : 'GithubJSON classTrait',
	#instVars : [
		'color',
		'name',
		'description'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GitLabelInfo >> color [
	<return: #Color>
	^ color
]

{ #category : #accessing }
GitLabelInfo >> color: anObject [
	color := anObject
]

{ #category : #setting }
GitLabelInfo >> colorFromJson: ajson [
	self color: (Color fromString: (ajson at: #color) jsonObject)
]

{ #category : #accessing }
GitLabelInfo >> description [
	^ description
]

{ #category : #accessing }
GitLabelInfo >> description: anObject [
	description := anObject
]

{ #category : #setting }
GitLabelInfo >> descriptionFromJson: ajson [
	self description: (ajson at: #description) jsonObject
]

{ #category : #setting }
GitLabelInfo >> fromJson: ajson [
	self
		nameFromJson: ajson;
		colorFromJson: ajson;
		descriptionFromJson: ajson.
	^ self
]

{ #category : #visualization }
GitLabelInfo >> fullDescription [
	| list |
	list := BrColumnedList new.
	list margin: (BlInsets top: 10 bottom: 10).
	list
		items: {self name.
				self description}.
	list column
		title: 'text';
		stencil: [ :text | BrColumnCellLabelStencil fitContent: text asRopedText glamorousRegularFont ].
	^ list
]

{ #category : #visualization }
GitLabelInfo >> gtPreviewCard: aView [
	<gtView>
	^ aView explicit
		title: 'Issue Card';
		stencil: [ | list |
			list := self fullDescription margin: (BlInsets all: 10).
			BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (BlElement new
						aptitude: BrShadowAptitude new;
						background: Color white;
						constraintsDo: [ :c | 
							c frame horizontal alignCenter.
							c frame vertical alignCenter.
							c horizontal fitContent.
							c vertical fitContent ];
						layout: BlLinearLayout horizontal;
						addChild: self smallVerticalColor;
						addChild: list) ]
]

{ #category : #accessing }
GitLabelInfo >> name [
	^ name
]

{ #category : #accessing }
GitLabelInfo >> name: anObject [
	name := anObject
]

{ #category : #setting }
GitLabelInfo >> nameFromJson: ajson [
	self name: (ajson at: #name) jsonObject
]

{ #category : #accessing }
GitLabelInfo >> printOn: stream [
	^ stream nextPutAll: self name
]

{ #category : #visualization }
GitLabelInfo >> smallVerticalColor [
	^ BlElement new
		background: self color;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal exact: 30 ]
]
