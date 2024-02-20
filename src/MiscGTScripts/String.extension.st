Extension { #name : #String }

{ #category : #'*MiscGTScripts' }
String >> asMJHand [
	| stringArr indicies |
	stringArr := self asArray.
	indicies := OrderedCollection new.
	self
		splitOn: [ :each | each isLetter ]
		indicesDo: [ :start :end | 
			end > start
				ifTrue: [ indicies
						add: (self asArray
								collect: [ :ele | MJTile num: ele asString asNumber kind: (self at: end + 1) ]
								from: start
								to: end) ] ].

	^ MJHand hand: indicies flatten
]
