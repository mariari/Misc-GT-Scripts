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
MJGroups >> new [
	tiles := OrderedCollection new.
	^ self
]
