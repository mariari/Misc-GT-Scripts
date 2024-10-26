Trait {
	#name : #GitToQueryMixin,
	#category : #'GitProjectBoard-git'
}

{ #category : #accessing }
GitToQueryMixin classSide >> queryClass [
	^ self explicitRequirement
]

{ #category : #accessing }
GitToQueryMixin >> toQueryWith: aContext [
	<argument: #aContext isKindOf: #GtGQLContext>
	^ self explicitRequirement
]
