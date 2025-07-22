Class {
	#name : #MovementSystem,
	#superclass : #Object,
	#category : #'MiscGTScripts-ECSPlayground'
}

{ #category : #'as yet unclassified' }
MovementSystem >> move: entities [
	entities
		do: [ :e | 
			e
				onComponent: PositionComponent
				do: [ :pos | 
					e
						onComponent: VelocityComponent
						do: [ :vel | 
							pos x: pos x + vel dx.
							pos y: pos y + vel dy ] ] ]
]
