Class {
	#name : #TimeLogPage,
	#superclass : #Object,
	#instVars : [
		'tags',
		'clock'
	],
	#category : #TimelogMonitor
}

{ #category : #parsing }
TimeLogPage class >> asPParser [
	^ (TimelogClocked asPParser , TimelogClocked dateSeperator trim
		, TimelogCategories asPParser)
		==> [ :col | 
			self new
				clock: (col at: 1);
				tags: (col at: 3) ]
]

{ #category : #factory }
TimeLogPage class >> fromString: aString [
	^ self asPParser parse: aString
]

{ #category : #accessing }
TimeLogPage >> addTag: anItem [
	self tags add: anItem
]

{ #category : #accessing }
TimeLogPage >> addTags: aCollection [
	self tags addAll: aCollection
]

{ #category : #accessing }
TimeLogPage >> clock [
	^ clock
]

{ #category : #accessing }
TimeLogPage >> clock: anObject [
	clock := anObject
]

{ #category : #views }
TimeLogPage >> gtViewDurationFor: aView [
	<gtView>
	^ aView forward
		priority: 7;
		title: 'Duration';
		object: [ self clock ];
		view: #gtDurationView:
]

{ #category : #views }
TimeLogPage >> gtViewEditFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Edit' translated;
		priority: 9;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self asString ];
		fontSize: 20;
		actionButtonIcon: BrGlamorousVectorIcons play
			action: [ :aButton :aTab | 
				| string result |
				string := aButton phlow textViewContent asString.
				result := [ self reparseFromString: string ] on: Error do: [ :ex | ex emit ].
				aTab viewContentElement phlow update ]
]

{ #category : #views }
TimeLogPage >> gtViewPreviewFor: aView [
	<gtView>
	^ aView forward
		priority: 10;
		title: 'Preview';
		object: [ self clock ];
		view: #gtPreview:
]

{ #category : #views }
TimeLogPage >> gtViewTagsFor: aView [
	<gtView>
	^ aView forward
		priority: 16;
		title: 'Tags';
		object: [ self tags ];
		view: #gtTagsFor:
]

{ #category : #printing }
TimeLogPage >> printOn: aStream [
	self clock printOn: aStream.
	aStream << ' -- '.
	self tags printOn: aStream
]

{ #category : #'as yet unclassified' }
TimeLogPage >> reparseFromString: aString [
	| other |
	other := self class fromString: aString.

	self tags: other tags.
	self clock: other clock
]

{ #category : #accessing }
TimeLogPage >> tags [
	^ tags
]

{ #category : #accessing }
TimeLogPage >> tags: anObject [
	tags := anObject
]
