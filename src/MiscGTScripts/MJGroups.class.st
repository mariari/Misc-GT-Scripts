Class {
	#name : #MJGroups,
	#superclass : #MJTiles,
	#category : #MiscGTScripts
}

{ #category : #creating }
MJGroups class >> new [
	^ super new new
]

{ #category : #accessing }
MJGroups class >> with: aCollection [
	| instance |
	instance := self new.
	aCollection do: [ :tile | instance add: tile ].
	^ instance
]

{ #category : #accessing }
MJGroups >> accepts [
	| set |
	set := PluggableSet new.
	set equalBlock: [ :a :b | a sameAs: b ].
	set hashBlock: [:ele | ele uniqueHash].
	tiles do: [ :group | group acceptsTiles tiles do: [ :tile | set add: tile ] ].
	^ set
]

{ #category : #accessing }
MJGroups >> add: tile [
	^ tiles
		detect: [ :obj | obj accepts: tile ]
		ifOne: [ :obj | obj add: tile ]
		ifNone: [ tiles addLast: (MJGroup new add: tile) ]
]

{ #category : #accessing }
MJGroups >> naturalLayout: view [
	view nodes
		shape: [ :each | each asBlElement padding: (BlInsets all: 15) ];
		with: tiles.
	^ view
]

{ #category : #accessing }
MJGroups >> new [
	tiles := OrderedCollection new.
	^ self
]

{ #category : #accessing }
MJGroups >> visualizeAccepts: view [
	tiles do: [ :group | group visualizeAccepts: view ].
	^ view
]

{ #category : #accessing }
MJGroups >> visualizeAcceptsView: aView [
	<gtView>
	^ aView mondrian
		title: 'Accepts';
		painting: [ :view | self visualizeAccepts: view ]
]
