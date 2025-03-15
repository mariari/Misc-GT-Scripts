Class {
	#name : #MiscElixirAnalysis,
	#superclass : #Object,
	#instVars : [
		'groups'
	],
	#category : #'MiscGTScripts-Elixir'
}

{ #category : #'as yet unclassified' }
MiscElixirAnalysis >> declaredDepdencyMap [
	| mixDeps |
	mixDeps := Dictionary new.
	self groups do: [ :x | mixDeps at: x mixName put: x ].
	^ mixDeps
]

{ #category : #instantiation }
MiscElixirAnalysis >> groupBy: directories [
	groups := directories
			collect: [ :each | MiscElixirAnalysisGroup parseFromDir: each ]
]

{ #category : #accessing }
MiscElixirAnalysis >> groups [
	^ groups
]

{ #category : #accessing }
MiscElixirAnalysis >> groups: anObject [
	groups := anObject
]

{ #category : #'as yet unclassified' }
MiscElixirAnalysis >> gtDocumentationFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Short Documentation View';
		painting: [ :aMondrian | 
			aMondrian nodes
				shape: [ :folder | 
					BrVerticalPane new
						alignTopCenter;
						fitContent;
						cellSpacing: 10;
						border: (BlBorder paint: Color gray width: 1);
						padding: (BlInsets left: 20 right: 20);
						margin: (BlInsets all: 10);
						clipChildren: true;
						addChildren: {BrLabel new
									aptitude: (BrGlamorousLabelAptitude new fontSize: 20);
									text: folder basename.
								BlElement new
									in: [ :e | e graph beChildrenContainer: #default ];
									constraintsDo: [ :c | 
										c horizontal fitContent.
										c vertical fitContent ]} ];
				with: groups
					forEach: [ :group | group gtShortDocumentationWith: aMondrian ].
			aMondrian layout rectanglePack ];
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Reparse the directories'
			action: [ :aButton :aTab | 
				groups do: #repopulateFromDir.
				aTab viewContentElement phlow update ];
		actionButtonIcon: BrGlamorousVectorIcons play
			tooltip: 'Refresh'
			action: [ :aButton :aTab | aTab viewContentElement phlow update ]
]

{ #category : #'as yet unclassified' }
MiscElixirAnalysis >> gtMissingDepsView: aView [
	<gtView>
	^ aView mondrian
		title: 'Dependency Structure';
		painting: [ :mondrian | 
			| mixDeps implicitDeps |
			mixDeps := self declaredDepdencyMap.
			implicitDeps := self implicitMixReferences.
			mondrian nodes
				stencil: #brModuleNamePane;
				with: groups.
			mondrian edges
				stencil: [ :ele :fromElement :toElement | 
					| lineEle color references |
					references := MiscElixirAnalysisReferences new
							modules: toElement graph model modules asSet;
							group: ele.
					lineEle := BlParabollaArcElement new
							zIndex: 0;
							curvatureFraction: 0.08;
							toHead: (BlArrowheadSimpleArrow new background: Color black).
					color := ((implicitDeps at: ele) includes: toElement graph model)
							ifFalse: [ references allReferences
									ifEmpty: [ BlBorder paint: (Color colorFrom: '#0a6f4a') ]
									ifNotEmpty: [ BlBorder paint: (Color gray alpha: 0.5) ] ]
							ifTrue: [ BlBorder paint: (Color red alpha: 0.5) ].
					lineEle border: color.
					lineEle
						when: BlMouseEnterEvent
						do: [ :anEvent | lineEle border: (BlBorder paint: (Color blue alpha: 0.5)) ].
					lineEle when: BlMouseLeaveEvent do: [ :anEvent | lineEle border: color ].

					lineEle
						when: BlClickEvent
						do: [ :anEvent | 
							anEvent consumed: true.
							anEvent currentTarget phlow spawnObject: references ] ];
				connectFrom: #yourself
					toAll: [ :x | (x mixUmbrella collect: [ :dep | mixDeps at: dep ]) union: (implicitDeps at: x) ].
			mondrian layout force charge: -5000.
			mondrian ]
]

{ #category : #views }
MiscElixirAnalysis >> gtViewFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Explicit Mix Dependency Structure';
		painting: [ :mondrian | 
			| deps |
			deps := self declaredDepdencyMap.
			mondrian nodes
				stencil: #brModuleNamePane;
				with: groups.
			mondrian edges
				toCenterTop;
				connectFrom: #yourself
					toAll: [ :x | x mixUmbrella collect: [ :dep | deps at: dep ] ].
			mondrian layout sugiyama.
			mondrian ]
]

{ #category : #accessing }
MiscElixirAnalysis >> implicitMixReferences [
	| mixDeps useageDeps |
	mixDeps := self declaredDepdencyMap.
	useageDeps := self useageDependncyMap.
	self groups
		do: [ :item | 
			useageDeps
				at: item
				update: [ :set | set difference: (item mixUmbrella collect: [ :dep | mixDeps at: dep ]) ] ].
	^ useageDeps
]

{ #category : #'as yet unclassified' }
MiscElixirAnalysis >> useageDependncyMap [
	| useageDeps |
	useageDeps := Dictionary new.
	self groups
		do: [ :current | 
			| modules set |
			modules := current allReferencedModules.
			set := Set new.
			self groups
				do: [ :other | 
					(other modules asSet includesAny: modules) & (other ~= current)
						ifTrue: [ set add: other ].
					useageDeps at: current put: set ] ].
	^ useageDeps
]
