Extension { #name : #Integer }

{ #category : #'*Urbit-Core' }
Integer >> asNock [
	^ NockIntegerAtom new data: self
]
