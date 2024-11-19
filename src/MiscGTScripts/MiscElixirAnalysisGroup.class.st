Class {
	#name : #MiscElixirAnalysisGroup,
	#superclass : #Object,
	#instVars : [
		'asts',
		'dir'
	],
	#category : #'MiscGTScripts-Elixir'
}

{ #category : #instantiation }
MiscElixirAnalysisGroup class >> parseFromDir: aDirectory [
	^ self new
		dir: aDirectory;
		repopulateFromDir
]

{ #category : #accessing }
MiscElixirAnalysisGroup >> basename [
	^ dir basename
]

{ #category : #accessing }
MiscElixirAnalysisGroup >> dir [
	^ dir
]

{ #category : #accessing }
MiscElixirAnalysisGroup >> dir: anObject [
	dir := anObject
]

{ #category : #visualization }
MiscElixirAnalysisGroup >> gtDocumentationFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Short Documentation View';
		priority: 15;
		painting: [ :aMondrian | self gtShortDocumentationWith: aMondrian ]
]

{ #category : #'as yet unclassified' }
MiscElixirAnalysisGroup >> gtMissingDocumentationViewFor: aView [
	<gtView>
	| topicName |
	^ aView columnedList
		items: [ asts select: [ :ast | ast docs asCollection size < 3 ] ];
		title: 'Low Documentation Count';
		priority: 20;
		column: 'File'
			text: [ :aValue | 
				topicName := aValue basename asRopedText.
				topicName
					foreground: (aValue docs asCollection size = 0
							ifTrue: [ Color fromHexString: '911c08' ]
							ifFalse: [ Color lightBrown ]) ];
		column: 'Amount of Docs' text: [ :aValue | aValue docs asCollection size ]
]

{ #category : #visualization }
MiscElixirAnalysisGroup >> gtShortDocumentationWith: aMondrian [
	aMondrian nodes
		shape: [ :anAnalysisFile | anAnalysisFile gtDocumentationBoundingBox ];
		with: asts;
		forEach: [ :anAnalysisFile | anAnalysisFile gtShortDocumentationWith: aMondrian ].
	^ aMondrian layout rectanglePack
]

{ #category : #instantiation }
MiscElixirAnalysisGroup >> repopulateFromDir [
	asts := (ElixirParser sourceFilesIn: dir)
			collect: [ :each | 
				MiscElixirAnalysisFile new
					rawAst: ((ElixirParser parseWithErrors: each contents)
							filename: each pathString;
							yourself) ]
]
