Extension { #name : #DateAndTime }

{ #category : #'*TimelogMonitor' }
DateAndTime >> gtLogTimeElement [
	| container |
	container := BlElement new
			layout: BlLinearLayout horizontal;
			padding: (BlInsets all: 5);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
	container
		addChild: (self
				newLabel: (self year printStringPadded: 4)
				withLegend: 'year'
				primary: true).
	container
		addChild: (self
				newLabel: '-'
				withLegend: nil
				primary: false).
	container
		addChild: (self
				newLabel: (self monthIndex printStringPadded: 2)
				withLegend: 'month'
				primary: true).
	container
		addChild: (self
				newLabel: '-'
				withLegend: nil
				primary: false).
	container
		addChild: (self
				newLabel: (self dayOfMonth printStringPadded: 2)
				withLegend: 'day'
				primary: true).
	"TODO put proper spacing here"
	container
		addChild: (self
				newLabel: ' ' , self dayOfWeekAbbreviation , ' '
				withLegend: nil
				primary: false).
	container
		addChild: (self
				newLabel: (self hours printStringPadded: 2)
				withLegend: 'hours'
				primary: true).
	container
		addChild: (self
				newLabel: ':'
				withLegend: nil
				primary: false).
	^ container
		addChild: (self
				newLabel: (self minutes printStringPadded: 2)
				withLegend: 'minutes'
				primary: true)
]
