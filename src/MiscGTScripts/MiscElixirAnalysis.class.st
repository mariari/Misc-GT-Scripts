Class {
	#name : #MiscElixirAnalysis,
	#superclass : #Object,
	#instVars : [
		'groups'
	],
	#category : #'MiscGTScripts-Elixir'
}

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
			aMondrian layout rectanglePack ]
]
