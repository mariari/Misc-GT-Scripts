"
I am an MiscElixirAnalysisGroup, my main function is to parse a direcotry and offer analysis.


Note to refactor: Remove any mix fields and make a mix object we populate information with, it is cleaner
"
Class {
	#name : #MiscElixirAnalysisGroup,
	#superclass : #Object,
	#instVars : [
		'asts',
		'dir',
		'mixName',
		'mixUmbrella'
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

{ #category : #mix }
MiscElixirAnalysisGroup >> computeMixName [
	| deps listUmbreallaDeps elixirDeps |
	listUmbreallaDeps := 'mix run -e "IO.inspect(Mix.Project.get.project()[:app])"'.
	deps := self runMixCommand: listUmbreallaDeps.
	elixirDeps := ElixirParser parse: deps.
	^ mixName := (elixirDeps // 'atomNode') anyOne source
]

{ #category : #mix }
MiscElixirAnalysisGroup >> computeMixUmbrellaDeps [
	| listUmbreallaDeps deps elixirDeps |
	listUmbreallaDeps := 'mix run -e "IO.inspect(Mix.Project.get.project()[:deps] |> Enum.filter(fn {_, info} when is_list(info) -> List.keymember?(info, :in_umbrella, 0); _ -> false end) |> Enum.map(fn {a, _} -> a end))"'.
	deps := self runMixCommand: listUmbreallaDeps.
	elixirDeps := ElixirParser parse: deps.
	^ mixUmbrella := elixirDeps // 'atomNode' collect: #source
]

{ #category : #accessing }
MiscElixirAnalysisGroup >> dir [
	^ dir
]

{ #category : #accessing }
MiscElixirAnalysisGroup >> dir: anObject [
	dir := anObject
]

{ #category : #path }
MiscElixirAnalysisGroup >> fullPath [
	| path |
	path := self dir fullName.
	^ path
]

{ #category : #visualization }
MiscElixirAnalysisGroup >> gtDocumentationFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Short Documentation View';
		priority: 15;
		painting: [ :aMondrian | self gtShortDocumentationWith: aMondrian ];
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Reparse the directories'
			action: [ :aButton :aTab | 
				self repopulateFromDir.
				aTab viewContentElement phlow update ];
		actionButtonIcon: BrGlamorousVectorIcons play
			tooltip: 'Refresh'
			action: [ :aButton :aTab | aTab viewContentElement phlow update ]
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
							ifTrue: [ Color fromHexString: '#d80b00' ]
							ifFalse: [ Color fromHexString: '#d87700' ]) ];
		column: 'Number of Docs' text: [ :aValue | aValue docs asCollection size ]
]

{ #category : #visualization }
MiscElixirAnalysisGroup >> gtShortDocumentationWith: aMondrian [
	aMondrian nodes
		shape: [ :anAnalysisFile | anAnalysisFile gtDocumentationBoundingBox ];
		with: asts;
		forEach: [ :anAnalysisFile | anAnalysisFile gtShortDocumentationWith: aMondrian ].
	^ aMondrian layout rectanglePack
]

{ #category : #accessing }
MiscElixirAnalysisGroup >> mixName [
	^ mixName ifNil: [ self computeMixName ]
]

{ #category : #accessing }
MiscElixirAnalysisGroup >> mixUmbrella [
	^ mixUmbrella ifNil: [ self computeMixUmbrellaDeps ]
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

{ #category : #mix }
MiscElixirAnalysisGroup >> runMixCommand: string [
	^ OSPlatform current resultOfCommand: 'cd ' , self fullPath , '&& ' , string
]
