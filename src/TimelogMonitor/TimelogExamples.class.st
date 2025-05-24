Class {
	#name : #TimelogExamples,
	#superclass : #Object,
	#category : #'TimelogMonitor-Examples'
}

{ #category : #'as yet unclassified' }
TimelogExamples >> forumReadingCat [
	<gtExample>
	| res again |
	res := TimelogCategories new addAll: #(forums reading).
	again := TimelogCategories fromString: res asString.
	self assert: again equals: res.
	^ res
]

{ #category : #'as yet unclassified' }
TimelogExamples >> threeDays [
	<gtExample>
	| res |
	res := TimelogClocked fromString: '2025-05-20 0:43 -- 2025-05-23 0:43'.
	self assert: res duration equals: 3 days.
	^ res
]

{ #category : #'as yet unclassified' }
TimelogExamples >> threeDaysReading [
	<gtExample>
	| res same |
	res := TimeLogPage new
			clock: self threeDays;
			tags: self forumReadingCat.
	same := TimeLogPage
			fromString: '2025-05-20 00:43:00 -- 2025-05-23 T 00:43:00 -- (forums reading)'.
	self assert: res tags equals: same tags.
	self assert: res clock start equals: same clock start.
	self assert: res clock end equals: same clock end.
	^ res
]
