Class {
	#name : #BlNatoBaseElement,
	#superclass : #BlElement,
	#instVars : [
		'bounding'
	],
	#category : #'NatoSymbols-Graphics'
}

{ #category : #accessing }
BlNatoBaseElement >> bounding [
	<return: #BlElement>
	^ bounding
]

{ #category : #accessing }
BlNatoBaseElement >> bounding: anElement [
	<argument: #anElement isKindOf: #BlElement>
	bounding ifNotNil: [ self removeChild: bounding ].
	bounding := anElement.
	self addChild: anElement
]

{ #category : #initialization }
BlNatoBaseElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'api - look' }
BlNatoBaseElement >> frame: aFrame [
	self geometry: aFrame
]

{ #category : #'api - look' }
BlNatoBaseElement >> friendly [
	self background: (Color fromHexString: '#80E0FF') asBlBackground
]

{ #category : #accessing }
BlNatoBaseElement >> fullWidthBoundingOctagon [
	self notYetImplemented
]

{ #category : #'api - adding' }
BlNatoBaseElement >> horizontalBoundingOctagon [
	self
		bounding: (BlHorizontalOctagon new
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal fitContent.
					c frame vertical alignCenter.
					c frame horizontal alignCenter ])
]

{ #category : #'api - look' }
BlNatoBaseElement >> hostile [
	self background: (Color red asBlBackground opacity: 0.5)
]

{ #category : #'api - look' }
BlNatoBaseElement >> neutral [
	self background: (Color green asBlBackground opacity: 0.335)
]

{ #category : #'api - look' }
BlNatoBaseElement >> unknown [
	self background: ((Color fromHexString: '#FFFF80' ) asBlBackground)
]

{ #category : #'api - adding' }
BlNatoBaseElement >> verticalBoundingOctagon [
	self
		bounding: (BlVerticalOctagon new
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal fitContent.
					c frame vertical alignCenter.
					c frame horizontal alignCenter ])
]
