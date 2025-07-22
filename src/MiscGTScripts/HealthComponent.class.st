Class {
	#name : #HealthComponent,
	#superclass : #Object,
	#instVars : [
		'health'
	],
	#category : #'MiscGTScripts-ECSPlayground'
}

{ #category : #accessing }
HealthComponent >> health [
	^ health
]

{ #category : #accessing }
HealthComponent >> health: anObject [
	health := anObject
]

{ #category : #'as yet unclassified' }
HealthComponent >> takeDmg: amount [
	health - amount max: 0
]
