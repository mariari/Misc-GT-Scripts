Class {
	#name : #MJTileVisualizerTenhou,
	#superclass : #MJTileVisualizer,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJTileVisualizerTenhou class >> fileType [
	^ '.png'
]

{ #category : #accessing }
MJTileVisualizerTenhou >> defaultPath [
	^ (GtGitRepository forClass: Mahjong) icebergRepository repositoryDirectory
		/ 'images' / 'mahjong' / 'tenhou'
]

{ #category : #accessing }
MJTileVisualizerTenhou >> defaultSize [
	^ 168 @ 253
]
