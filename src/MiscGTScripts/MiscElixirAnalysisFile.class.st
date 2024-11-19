Class {
	#name : #MiscElixirAnalysisFile,
	#superclass : #Object,
	#instVars : [
		'rawAst'
	],
	#category : #'MiscGTScripts-Elixir'
}

{ #category : #'as yet unclassified' }
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
MiscElixirAnalysisFile >> fileName [
	^ rawAst filename
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtDocumentationBoundingBox [
	self docs asCollection ifEmpty: [ ^ BlElement new ].
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
MiscElixirAnalysisFile >> gtDocumentationFor: aView [
	<gtView>
	self docs asCollection isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Short Documentation View';
		painting: [ :mondrian | 
			mondrian nodes
				shape: [ self gtDocumentationBoundingBox ];
				with: {self};
				forEach: [ :_ | self gtShortDocumentationWith: mondrian ].
			mondrian ]
]

{ #category : #visualization }
MiscElixirAnalysisFile >> gtShortDocumentationWith: aMondrian [
	aMondrian nodes
		shape: [ :node | 
			| length |
			length := node source lines size - 2.
			BlElement new
				margin: (BlInsets all: 7);
				size: 15 asPoint;
				background: (length > 3
						ifTrue: [ length > 5 ifTrue: [ Color gray ] ifFalse: [ Color fromHexString: '#ffa73b' ] ]
						ifFalse: [ Color fromHexString: '#ff453b' ]) ];
		with: self docs.
	^ aMondrian layout grid
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
