Extension { #name : #String }

{ #category : #'*Urbit-Core' }
String >> asNock [
	^ NockBinaryAtom newFromArray: self asByteArray
]
