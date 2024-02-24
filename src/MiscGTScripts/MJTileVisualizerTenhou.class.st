Class {
	#name : #MJTileVisualizerTenhou,
	#superclass : #MJTileVisualizer,
	#category : #'MiscGTScripts-Graphics'
}

{ #category : #accessing }
MJTileVisualizerTenhou class >> fileType [
	^ '.png'
]

{ #category : #accessing }
MJTileVisualizerTenhou >> defaultPath [
	^ (GtGitRepository forClass: MJTile) icebergRepository repositoryDirectory
		/ 'images' / 'mahjong' / 'tenhou'
]

{ #category : #accessing }
MJTileVisualizerTenhou >> defaultSize [
	^ 168 @ 254
]
