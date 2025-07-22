Class {
	#name : #ECSEntity,
	#superclass : #Object,
	#instVars : [
		'components'
	],
	#category : #'MiscGTScripts-ECSPlayground'
}

{ #category : #ecs }
ECSEntity >> add: aComponent [
	components at: aComponent class put: aComponent
]

{ #category : #ecs }
ECSEntity >> component: componentClass [
	^ components at: componentClass ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
ECSEntity >> gtComponentsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Components';
		priority: 15;
		items: [ components associations asArray ];
		column: 'Type' text: [ :assoc | assoc key name ];
		column: 'Component' text: [ :assoc | assoc value ]
]

{ #category : #views }
ECSEntity >> gtComponentsTreeFor: aView [
	"redo this to be nicer"

	<gtView>
	^ aView tree
		title: 'Components (Expandable)';
		priority: 10;
		items: [ components associations asArray ];
		children: [ :assoc | 
			assoc value class allInstVarNames
				collect: [ :ivar | ivar -> (assoc value instVarNamed: ivar) ] ];
		itemText: [ :assocOrSlot | assocOrSlot key printString , ':' , assocOrSlot value printString ];
		expandUpTo: 1
]

{ #category : #ecs }
ECSEntity >> hasComponent: componentClass [
	^ components includesKey: componentClass
]

{ #category : #initialization }
ECSEntity >> initialize [
	components := Dictionary new
]

{ #category : #ecs }
ECSEntity >> onComponent: component do: closure [
	"TODO refactor to handle inheritance of components"

	(self component: component) ifNotNil: [ :c | closure value: c ]
]
