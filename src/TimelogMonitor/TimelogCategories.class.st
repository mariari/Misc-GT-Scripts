Class {
	#name : #TimelogCategories,
	#superclass : #Object,
	#instVars : [
		'tags'
	],
	#category : #'TimelogMonitor-Tags'
}

{ #category : #parsing }
TimelogCategories class >> asPParser [
	^ ($( asPParser , self parseWord star , $) asPParser trim)
		==> [ :words | self new tags: (words at: 2) asSet ]
]

{ #category : #factory }
TimelogCategories class >> fromString: aString [
	^ self asPParser parse: aString
]

{ #category : #parsing }
TimelogCategories class >> parseWord [
	^ (#space asPParser / $) asPParser / $( asPParser) negate plus flatten trim
]

{ #category : #adding }
TimelogCategories >> add: anItem [ 
	self tags add: anItem.
]

{ #category : #adding }
TimelogCategories >> addAll: aCollection [
	tags addAll: aCollection
]

{ #category : #views }
TimelogCategories >> gtTagsFor: aView [
	<gtView>
	tags ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Tags';
		items: [ tags asOrderedCollection ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #initialization }
TimelogCategories >> initialize [
	super initialize.
	tags := Set new
]

{ #category : #printing }
TimelogCategories >> printOn: aStream [
	aStream
		parenthesize: [ self tags
				do: [ :anItem | anItem putOn: aStream ]
				separatedBy: [ aStream space ] ]
]

{ #category : #accessing }
TimelogCategories >> tags [
	^ tags
]

{ #category : #accessing }
TimelogCategories >> tags: anObject [
	tags := anObject
]
