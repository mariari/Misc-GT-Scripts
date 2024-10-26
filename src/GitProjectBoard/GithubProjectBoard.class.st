Class {
	#name : #GithubProjectBoard,
	#superclass : #GithubGQL,
	#traits : 'GitLabelsMixin + GithubJSON + GitToQueryMixin',
	#classTraits : 'GitLabelsMixin classTrait + GithubJSON classTrait + GitToQueryMixin classTrait',
	#instVars : [
		'items',
		'org',
		'title',
		'id',
		'board'
	],
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GithubProjectBoard class >> queryClass [
	^ GithubToolingBoard
]

{ #category : #accessing }
GithubProjectBoard >> board [
	^ board
]

{ #category : #accessing }
GithubProjectBoard >> board: anObject [
	board := anObject
]

{ #category : #'setting - json' }
GithubProjectBoard >> boardFromJson: jsonData [
	self board: (jsonData at: #number) jsonObject
]

{ #category : #'setting - json' }
GithubProjectBoard >> fromJson: jsonData [
	"We initialize all but the items and repos, as those have to be paginated"

	self orgFromJson: jsonData.
	self titleFromJson: jsonData.
	self boardFromJson: jsonData.
	self idFromJson: jsonData
]

{ #category : #visualization }
GithubProjectBoard >> gtProjectView: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Project View';
		items: [ self items ];
		priority: 10;
		column: 'Index'
			text: [ :aValue :anIndex | anIndex asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
			width: 40;
		column: 'Item Name'
			text: [ :aValue | aValue itemName asRopedText foreground: Color black ];
		column: 'State'
			do: [ :aColumn | 
				aColumn
					stencil: [ :aValue | 
						BrButton new
							aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousToggleWithLabelAptitude;
							border: aValue status color;
							label: aValue status name ] ];
		column: 'Tags'
			do: [ :aColumn | 
				aColumn
					stencil: [ :aValue | aValue contents labelsCrumbList ];
					width: 300 ]
]

{ #category : #accessing }
GithubProjectBoard >> id [
	^ id
]

{ #category : #accessing }
GithubProjectBoard >> id: anObject [
	id := anObject
]

{ #category : #setting }
GithubProjectBoard >> idFromJson: ajson [ 
	self id: (ajson at: #id) jsonObject
]

{ #category : #accessing }
GithubProjectBoard >> items [
	^ items
]

{ #category : #accessing }
GithubProjectBoard >> items: anObject [
	items := anObject
]

{ #category : #accessing }
GithubProjectBoard >> labelName [
	^ 'Statuses'
]

{ #category : #accessing }
GithubProjectBoard >> org [
	^ org
]

{ #category : #accessing }
GithubProjectBoard >> org: anObject [
	org := anObject
]

{ #category : #'setting - json' }
GithubProjectBoard >> orgFromJson: ajson [
	self org: (ajson atPath: #(owner name)) jsonObject
]

{ #category : #accessing }
GithubProjectBoard >> title [
	^ title
]

{ #category : #accessing }
GithubProjectBoard >> title: anObject [
	title := anObject
]

{ #category : #'setting - json' }
GithubProjectBoard >> titleFromJson: ajson [
	self title: (ajson at: #title) jsonObject
]

{ #category : #accessing }
GithubProjectBoard >> toQueryWith: aContext [
	<argument: #aContext isKindOf: #GtGQLContext>
	^ self class queryClass new
		context: aContext;
		organization: self org;
		board: self board
]
