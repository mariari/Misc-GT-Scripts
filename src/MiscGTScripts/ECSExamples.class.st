Class {
	#name : #ECSExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-ECSPlayground'
}

{ #category : #'as yet unclassified' }
ECSExamples >> basicEntityMoved [
	<gtExample>
	| entity |
	entity := self basicMoveableEntity.

	MovementSystem new
		move: {entity.
				ECSEntity new}.
	entity
		onComponent: PositionComponent
		do: [ :pos | 
			self assert: pos x equals: self basicPosition x + self goForwardAndBack dx.
			self assert: pos y equals: self basicPosition y + self goForwardAndBack dy ].
	^ entity
]

{ #category : #'as yet unclassified' }
ECSExamples >> basicMoveableEntity [
	<gtExample>
	| entity |
	entity := ECSEntity new.
	entity add: self basicPosition.
	entity add: self goForwardAndBack.
	entity
		onComponent: VelocityComponent
		do: [ :vel | self assert: vel dx equals: 1 ].
	^ entity
]

{ #category : #'as yet unclassified' }
ECSExamples >> basicPosition [
	<gtExample>
	^ PositionComponent new
		x: 10;
		y: 5
]

{ #category : #'as yet unclassified' }
ECSExamples >> damangeHPEntity [
	<gtExample>
	| ret |
	ret := self twentyHPEntity.
	DamageSystem new
		damage: {ret.
				ECSEntity new}.
	ret onComponent: HealthComponent do: [ :h | self assert: h health equals: 10 ].
	^ ret
]

{ #category : #'as yet unclassified' }
ECSExamples >> goForwardAndBack [
	<gtExample>
	^ VelocityComponent new
		dx: 1;
		dy: -1
]

{ #category : #'as yet unclassified' }
ECSExamples >> twentyHPEntity [
	<gtExample>
	^ ECSEntity new add: (HealthComponent new health: 20)
]
