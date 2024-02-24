Class {
	#name : #MJGroupCache,
	#superclass : #Object,
	#classInstVars : [
		'cache'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJGroupCache class >> at: set [
	^ cache at: set ifAbsent: #()
]

{ #category : #accessing }
MJGroupCache class >> includesKey: set [
	^ cache includesKey: set
]

{ #category : #accessing }
MJGroupCache class >> initialize [
	cache := self table
]

{ #category : #accessing }
MJGroupCache class >> table [
	| arr |
	arr := {{1} -> #(1 2 3) asSet.
			{2} -> #(1 2 3 4) asSet.
			{3} -> #(1 2 3 4 5) asSet.
			{4} -> #(2 3 4 5 6) asSet.
			{5} -> #(3 4 5 6 7) asSet.
			{6} -> #(4 5 6 7 8) asSet.
			{7} -> #(5 6 7 8 9) asSet.
			{8} -> #(6 7 8 9) asSet.
			{9} -> #(7 8 9) asSet.
			#(1 3) -> #(2) asSet.
			#(2 4) -> #(3) asSet.
			#(3 5) -> #(4) asSet.
			#(4 6) -> #(5) asSet.
			#(5 7) -> #(6) asSet.
			#(6 8) -> #(7) asSet.
			#(7 9) -> #(8) asSet.
			#(1 2) -> #(3) asSet.
			#(2 3) -> #(1 4) asSet.
			#(3 4) -> #(2 5) asSet.
			#(4 5) -> #(3 6) asSet.
			#(5 6) -> #(4 7) asSet.
			#(6 7) -> #(5 8) asSet.
			#(7 8) -> #(6 9) asSet.
			#(8 9) -> #(7) asSet.
			#(north) -> #(north) asSet.
			#(west) -> #(west) asSet.
			#(south) -> #(south) asSet.
			#(east) -> #(east) asSet.
			#(red) -> #(red) asSet.
			#(green) -> #(green) asSet.
			#(white) -> #(white) asSet.
			#(north north) -> #(north) asSet.
			#(west west) -> #(west) asSet.
			#(south south) -> #(south) asSet.
			#(east east) -> #(east) asSet.
			#(red red) -> #(red) asSet.
			#(green green) -> #(green) asSet.
			#(white white) -> #(white) asSet.
			#(north north north) -> #(north) asSet.
			#(west west west) -> #(west) asSet.
			#(south south south) -> #(south) asSet.
			#(east east east) -> #(east) asSet.
			#(red red red) -> #(red) asSet.
			#(green green green) -> #(green) asSet.
			#(white white white) -> #(white) asSet.
			#(1 1) -> #(1) asSet.
			#(2 2) -> #(2) asSet.
			#(3 3) -> #(3) asSet.
			#(4 4) -> #(4) asSet.
			#(5 5) -> #(5) asSet.
			#(6 6) -> #(6) asSet.
			#(7 7) -> #(7) asSet.
			#(8 8) -> #(8) asSet.
			#(9 9) -> #(9) asSet.
			#(3 1) -> #(2) asSet.
			#(4 2) -> #(3) asSet.
			#(5 3) -> #(4) asSet.
			#(6 4) -> #(5) asSet.
			#(7 5) -> #(6) asSet.
			#(8 6) -> #(7) asSet.
			#(9 7) -> #(8) asSet.
			#(2 1) -> #(3) asSet.
			#(3 2) -> #(1 4) asSet.
			#(4 3) -> #(2 5) asSet.
			#(5 4) -> #(3 6) asSet.
			#(6 5) -> #(4 7) asSet.
			#(7 6) -> #(5 8) asSet.
			#(8 7) -> #(6 9) asSet.
			#(9 8) -> #(7) asSet.
			#(1 1 1) -> #(1) asSet.
			#(2 2 2) -> #(2) asSet.
			#(3 3 3) -> #(3) asSet.
			#(4 4 4) -> #(4) asSet.
			#(5 5 5) -> #(5) asSet.
			#(6 6 6) -> #(6) asSet.
			#(7 7 7) -> #(7) asSet.
			#(8 8 8) -> #(8) asSet.
			#(9 9 9) -> #(9) asSet}.
	^ Dictionary newFrom: arr
]
