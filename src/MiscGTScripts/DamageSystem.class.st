Class {
	#name : #DamageSystem,
	#superclass : #Object,
	#category : #'MiscGTScripts-ECSPlayground'
}

{ #category : #accessing }
DamageSystem >> damage: entities [
	entities do: [ :e | e onComponent: HealthComponent do: [ :c | c takeDmg: 10 ] ]
]

{ #category : #accessing }
DamageSystem >> process: entities withEvent: anEvent [

 
]
