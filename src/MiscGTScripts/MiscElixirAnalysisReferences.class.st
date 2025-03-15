Class {
	#name : #MiscElixirAnalysisReferences,
	#superclass : #Object,
	#instVars : [
		'group',
		'modules'
	],
	#category : #'MiscGTScripts-Elixir'
}

{ #category : #accessing }
MiscElixirAnalysisReferences >> allReferences [
	| referenced dict |
	dict := Dictionary new.
	referenced := self group referencedModulesASTMap.
	referenced
		associationsDo: [ :a | 
			(modules intersection: (a value collect: #source))
				ifNotEmpty: [ dict at: a key put: (a value select: [ :x | modules includes: x source ]) ] ].
	^ dict
]

{ #category : #accessing }
MiscElixirAnalysisReferences >> group [
	^ group
]

{ #category : #accessing }
MiscElixirAnalysisReferences >> group: anObject [
	group := anObject
]

{ #category : #view }
MiscElixirAnalysisReferences >> gtMissingDepsView: aView [
	<gtView>
	| references |
	^ aView mondrian
		title: 'Dependencies';
		painting: [ :aMondrian | 
			references := self allReferences.
			aMondrian nodes
				shape: [ :analysis | analysis gtBoundingBox ];
				with: self allReferences keys;
				forEach: [ :analysis | analysis gtHighlightedNodes: aMondrian with: (references at: analysis) ].
			aMondrian layout rectanglePack ]
]

{ #category : #accessing }
MiscElixirAnalysisReferences >> modules [
	^ modules
]

{ #category : #accessing }
MiscElixirAnalysisReferences >> modules: anObject [
	modules := anObject
]
