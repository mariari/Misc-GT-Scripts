Class {
	#name : #BlOctagon,
	#superclass : #BlElement,
	#category : #'NatoSymbols-Graphics'
}

{ #category : #initialization }
BlOctagon >> defaultGeometry [
	| vertices angle |
	angle := Float pi * 2 / 8.
	vertices := (0 to: 8)
			collect: [ :i | ((i * angle) cos + 1) @ ((i * angle) sin + 1) / 2.0 ].
	^ BlNormalizedPolygon vertices: vertices
]

{ #category : #initalization }
BlOctagon >> defaultLayout [
	^ BlSquaredLayout new
]

{ #category : #'as yet unclassified' }
BlOctagon >> defaultOutskirts [
	^ BlOutskirts centered
]

{ #category : #initialization }
BlOctagon >> initialize [
	super initialize.
	self
		geometry: self defaultGeometry;
		outskirts: self defaultOutskirts
]
