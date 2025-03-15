Class {
	#name : #MiscElixirAnalysisFile,
	#superclass : #Object,
	#instVars : [
		'rawAst'
	],
	#category : #'MiscGTScripts-Elixir'
}

{ #category : #printing }
MiscElixirAnalysisFile >> basename [
	^ rawAst
		ifNil: [ 'MiscElixirAnalysisFile' ]
		ifNotNil: [ self fileName asFileReference basename withoutPeriodSuffix ]
]

{ #category : #accessing }
MiscElixirAnalysisFile >> docs [
	^ rawAst
		ifNotNil: [ ((rawAst // 'expr') @ 'ops' <- '@') // 'doc' \\ 'noParens' \\ 'matched' ]
		ifNil: [ {} ]
]

{ #category : #accessing }
MiscElixirAnalysisFile >> editableDocs [
	^ self docs
		collect: [ :aDoc | 
			MiscElixirEditableSnippet new
				file: self fileName asFileReference;
				section: aDoc ]
]

{ #category : #accessing }
MiscElixirAnalysisFile >> fileName [
	^ rawAst filename
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtBoundingBox [
	^ BrVerticalPane new
		alignTopCenter;
		fitContent;
		border: (BlBorder paint: Color gray width: 1);
		padding: (BlInsets left: 1 right: 1);
		margin: (BlInsets all: 3);
		addChildren: {BrLabel new
					aptitude: (BrGlamorousLabelAptitude new fontSize: 10);
					text: self basename.
				BlElement new
					in: [ :e | e graph beChildrenContainer: #default ];
					border: Color black;
					constraintsDo: [ :c | c margin: (BlInsets all: 5) ]}
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtCodeFor: aView [
	<gtView>
	rawAst ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Code';
		priority: 15;
		object: [ self fileName asFileReference ];
		view: #gtStyledCodeFor:
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtDocumentationBoundingBox [
	self docs asCollection ifEmpty: [ ^ BlElement new ].
	^ self gtBoundingBox
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtDocumentationFor: aView [
	<gtView>
	self docs asCollection isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Short Documentation View';
		priority: 13;
		painting: [ :mondrian | 
			mondrian nodes
				shape: [ self gtDocumentationBoundingBox ];
				with: {self};
				forEach: [ :_ | self gtShortDocumentationWith: mondrian ] ];
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Reparse the file'
			action: [ :aButton :aTab | 
				self parseAST.
				aTab viewContentElement phlow update ]
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtHighlightedNodes: aMondrian with: nodes [
	aMondrian nodes
		shape: [ :node | 
			BlElement new
				margin: (BlInsets all: 7);
				size: 15 asPoint;
				background: Color gray ];
		with: (nodes
				collect: [ :aDoc | 
					MiscElixirEditableSnippet new
						file: self fileName asFileReference;
						section: aDoc ]).
	^ aMondrian layout grid
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtShortDocumentationWith: aMondrian [
	aMondrian nodes
		shape: [ :node | 
			| length |
			length := node section source lines size - 2.
			BlElement new
				margin: (BlInsets all: 7);
				size: 15 asPoint;
				background: (length > 3
						ifTrue: [ length > 5 ifTrue: [ Color gray ] ifFalse: [ Color fromHexString: '#ffa73b' ] ]
						ifFalse: [ Color fromHexString: '#ff453b' ]) ];
		with: self editableDocs.
	^ aMondrian layout grid
]

{ #category : #accessing }
MiscElixirAnalysisFile >> modules [
	^ ((rawAst // 'dot') @ 'identifier' <- 'defmodule') \\ 'expr'
		collect: [ :x | x call source ]
]

{ #category : #loading }
MiscElixirAnalysisFile >> parseAST [
	| fileName |
	fileName := self fileName.
	rawAst := (ElixirParser parseWithErrors: fileName asFileReference contents)
			filename: fileName;
			yourself
]

{ #category : #printing }
MiscElixirAnalysisFile >> printOn: aStream [
	aStream nextPutAll: self basename
]

{ #category : #accessing }
MiscElixirAnalysisFile >> rawAst [
	^ rawAst
]

{ #category : #accessing }
MiscElixirAnalysisFile >> rawAst: anObject [
	rawAst := anObject
]

{ #category : #accessing }
MiscElixirAnalysisFile >> referencedModules [
	^ self referencedModulesAST collect: #source
]

{ #category : #parsing }
MiscElixirAnalysisFile >> referencedModulesAST [
	^ ((rawAst // 'dotIdentifier') @ 'identifier' <- 'alias'
		| ((rawAst // 'dotIdentifier') @ 'identifier' <- 'require')
		| ((rawAst // 'dotIdentifier') @ 'identifier' <- 'use')
		select: [ :y | 
			| source |
			source := y source.
			source = 'require' | (source = 'use') | (source = 'alias') ])
		collect: [ :x | 
			((x parent // 'dot') asOrderedCollection
				sort: [ :x1 :x2 | 
					x1 startPosition = x2 startPosition
						ifTrue: [ x1 stopPosition > x2 stopPosition ]
						ifFalse: [ x1 startPosition < x2 startPosition ] ]) second ]
]
