Class {
	#name : #MJTileVisualizerSmall,
	#superclass : #MJTileVisualizer,
	#category : #'MahjongModel-Graphics'
}

{ #category : #accessing }
MJTileVisualizerSmall class >> fileType [
	^ '.gif'
]

{ #category : #accessing }
MJTileVisualizerSmall >> defaultPath [
	^ (GtGitRepository forClass: MJTile) icebergRepository repositoryDirectory
		/ 'images' / 'mahjong' / 'small'
]

{ #category : #accessing }
MJTileVisualizerSmall >> defaultSize [
	^ 15 @ 21
]
