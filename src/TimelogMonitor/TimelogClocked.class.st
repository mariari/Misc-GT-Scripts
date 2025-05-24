Class {
	#name : #TimelogClocked,
	#superclass : #Object,
	#instVars : [
		'start',
		'end'
	],
	#category : #TimelogMonitor
}

{ #category : #'parsing - private' }
TimelogClocked class >> asBasePParser [
	^ self datePParser , self dateSeperator trim , self datePParser
]

{ #category : #'parsing - private' }
TimelogClocked class >> asPParser [
	^ self asBasePParser
		==> [ :collection | 
			self new
				start: (collection at: 1);
				end: (collection at: 3) ]
]

{ #category : #parsing }
TimelogClocked class >> datePParser [
	^ self dateSeperator negate star flatten ==> [ :date | date asDateAndTime ]
]

{ #category : #parsing }
TimelogClocked class >> dateSeperator [
	| seperator |
	seperator := '--' asPParser.
	^ seperator
]

{ #category : #parsing }
TimelogClocked class >> fromString: aString [
	^ self asPParser parse: aString
]

{ #category : #accessing }
TimelogClocked >> duration [
	^ self end - self start
]

{ #category : #accessing }
TimelogClocked >> end [
	^ end
]

{ #category : #accessing }
TimelogClocked >> end: anObject [
	end := anObject
]

{ #category : #views }
TimelogClocked >> gtDurationView: aView [
	<gtView>
	^ aView forward
		title: 'Duration';
		object: [ self duration ];
		view: #gtPreviewFor:
]

{ #category : #'as yet unclassified' }
TimelogClocked >> gtEditviewFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Edit' translated;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self asString ];
		priority: 10;
		fontSize: 20;
		actionButtonIcon: BrGlamorousVectorIcons play
			action: [ :aButton :aTab | 
				| string result |
				string := aButton phlow textViewContent asString.
				result := [ self reparseFromString: string ] on: Error do: [ :ex | ex emit ].
				aTab viewContentElement phlow update ]
]

{ #category : #'as yet unclassified' }
TimelogClocked >> gtPreview: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 12;
		stencil: [ | container |
			container := BlElement new
					layout: BlLinearLayout horizontal;
					padding: (BlInsets all: 5);
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ].
			container addChild: start gtLogTimeElement.
			container
				addChild: (BrLabel new
						text: '——';
						aptitude: (BrGlamorousLabelAptitude new
								foreground: Color gray;
								fontSize: 32);
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent ]).
			container addChild: end gtLogTimeElement.
			container ]
]

{ #category : #printing }
TimelogClocked >> printOn: aStream [

	self start printOn: aStream.
	aStream space.
	aStream << '--'.
	aStream space.
	self end printOn: aStream
]

{ #category : #parsing }
TimelogClocked >> reparseFromString: aString [
	| identifier |
	identifier := self class asBasePParser
			==> [ :collection | 
				self
					start: (collection at: 1);
					end: (collection at: 3) ].
	identifier parse: aString
]

{ #category : #accessing }
TimelogClocked >> start [
	^ start
]

{ #category : #accessing }
TimelogClocked >> start: anObject [
	start := anObject
]
