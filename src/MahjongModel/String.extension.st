Extension { #name : #String }

{ #category : #'*MahjongModel' }
String >> asMJGroup [
	^ MJGroup with: self asMJTiles
]

{ #category : #'*MahjongModel' }
String >> asMJHand [
	^ MJHandNP with: self asMJTiles
]

{ #category : #'*MahjongModel' }
String >> asMJHandNP [
	"Like asMJHand, but assume we don't have a pair we wish finish"

	^ MJHandNP with: self asMJTiles
]

{ #category : #'*MahjongModel' }
String >> asMJHandP [
	"Like asMJHand, but assume we have a pair we wish to finish"

	^ MJHandP with: self asMJTiles
]

{ #category : #'*MahjongModel' }
String >> asMJTiles [
	| stringArr indicies |
	stringArr := self asArray.
	indicies := OrderedCollection new.
	self
		splitOn: [ :each | each isLetter ]
		indicesDo: [ :start :end | 
			self size > end
				ifTrue: [ indicies
						add: (self asArray
								collect: [ :ele | MJTile num: ele asString asNumber kind: (self at: end + 1) ]
								from: start
								to: end) ] ].

	^ indicies flatten
]
