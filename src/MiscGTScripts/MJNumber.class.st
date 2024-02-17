Class {
	#name : #MJNumber,
	#superclass : #MJTile,
	#instVars : [
		'suit',
		'number'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJNumber class >> man: num [
	^ self new suit: 'man' number: num
]

{ #category : #accessing }
MJNumber class >> new: num [
	^ self new new: num
]

{ #category : #accessing }
MJNumber class >> pin: num [
	^ self new suit: 'pin' number: num
]

{ #category : #accessing }
MJNumber class >> wan: num [
	^ self man: num
]

{ #category : #accessing }
MJNumber class >> zhu: num [
	^ self new suit: 'zhu' number: num
]

{ #category : #accessing }
MJNumber class >> 竹: num [
	^ self zhu: num
]

{ #category : #accessing }
MJNumber class >> 萬: num [
	^ self man: num
]

{ #category : #accessing }
MJNumber >> image: aView [
	<gtView>
	^ self visualize image: aView
]

{ #category : #accessing }
MJNumber >> new: num [
	suit := 'pin'.	"random default"
	number := num
]

{ #category : #accessing }
MJNumber >> suit: su number: num [
	number := num.
	suit := su.
	^ self
]

{ #category : #accessing }
MJNumber >> visualize [
	^ MJTileVisualizerSmall suit: suit number: number
]

{ #category : #accessing }
MJNumber >> wan [
	^ self man
]

{ #category : #accessing }
MJNumber >> 竹 [
	^ self class new suit: 'zhu' number: number
]

{ #category : #accessing }
MJNumber >> 萬 [
	^ self man
]
