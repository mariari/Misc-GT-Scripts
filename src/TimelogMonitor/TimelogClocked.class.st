Class {
	#name : #TimelogClocked,
	#superclass : #Object,
	#instVars : [
		'start',
		'end'
	],
	#category : #TimelogMonitor
}

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

{ #category : #accessing }
TimelogClocked >> start [
	^ start
]

{ #category : #accessing }
TimelogClocked >> start: anObject [
	start := anObject
]
