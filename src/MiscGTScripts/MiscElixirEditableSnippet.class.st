Class {
	#name : #MiscElixirEditableSnippet,
	#superclass : #Object,
	#instVars : [
		'section',
		'file'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MiscElixirEditableSnippet >> file [
	<return: #FileReference>
	^ file
]

{ #category : #accessing }
MiscElixirEditableSnippet >> file: anObject [
	file := anObject
]

{ #category : #visualization }
MiscElixirEditableSnippet >> gtEditViewFor: aView [
	<gtView>
	| aColor styler pane |
	^ aView explicit
		title: 'File Edit';
		priority: 12;
		stencil: [ aColor := BrGlamorousColors textHighlightColor.
			styler := section parserClass ifNotNil: [ :class | class gtStyler ].
			pane := section topParent filename asFileReference gtEditorView.
			pane
				childNamed: #editor
				ifFound: [ :editor | 
					| aText |
					editor aptitude: BrGlamorousCodeEditorAptitude.
					aText := editor text.
					section stopPosition isZero
						ifFalse: [ (aText from: section startPosition to: section stopPosition)
								attributes: {BlTextHighlightAttribute new
											beNotOverwritableByStyler;
											paint: aColor} ].
					editor editor styler: styler.

					section class
						gtScroll: aText
						toPosition: section startPosition
						inEditor: editor ].

			pane ]
]

{ #category : #'as yet unclassified' }
MiscElixirEditableSnippet >> gtExploreFor: aView [
	<gtView>
	^ aView forward
		title: 'Explore';
		priority: 13;
		object: [ section ];
		view: #gtExploreFor:
]

{ #category : #'as yet unclassified' }
MiscElixirEditableSnippet >> gtOriginalSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Parsed Source';
		priority: 15;
		object: [ section ];
		view: #gtSourceFor:
]

{ #category : #accessing }
MiscElixirEditableSnippet >> section [
	<return: #SmaCCParseNode>
	^ section
]

{ #category : #accessing }
MiscElixirEditableSnippet >> section: anObject [
	section := anObject
]
