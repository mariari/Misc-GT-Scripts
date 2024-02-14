Class {
	#name : #MahjongExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-Examples'
}

{ #category : #accessing }
MahjongExamples >> versitility [
	<gtExample>
	|view tiles pairs img background |
	view := GtMondrian new.
tiles := (1 to: 9) asOrderedCollection.
tiles addFirst: 'honors'.
pairs := {'honors' -> 1.
		'honors' -> 9.
		1 -> 8.
		1 -> 2.
		9 -> 8.
		9 -> 2.
		2 -> 3.
		2 -> 4.
		2 -> 5.
		2 -> 6.
		2 -> 7.
		8 -> 3.
		8 -> 4.
		8 -> 5.
		8 -> 6.
		8 -> 7}.
img := Form
		fromBinaryStream: (FileLocator home / 'Downloads' / 'Tile-1m.png') binaryReadStream.

background := BlImageBackground image: img.
view nodes
	shape: [ :each | 
		BlElement new
			border: (BlBorder paint: Color black);
			geometry: BlRoundedRectangleGeometry new;
			size: 28 @ 39;
			background: background ];
	with: tiles.
view edges connectAssociations: pairs.
view layout tree.
view edges fromCenterBottom.
^ view
]
