Class {
	#name : #MJTile,
	#superclass : #Object,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJTile >> asBlElement [
	^ self visualize asBlElement
]

{ #category : #accessing }
MJTile >> image: aView [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJTile >> visualize [
	^ self subclassResponsibility
]
