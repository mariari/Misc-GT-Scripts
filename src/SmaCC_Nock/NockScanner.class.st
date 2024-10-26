Class {
	#name : #NockScanner,
	#superclass : #SmaCCScanner,
	#category : #'SmaCC_Nock'
}

{ #category : #generated }
NockScanner >> emptySymbolTokenId [
	^ 11
]

{ #category : #generated }
NockScanner >> errorTokenId [
	^ 12
]

{ #category : #generated }
NockScanner >> scanForToken [
	self step.
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(1).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(2).
			self step.
			currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
NockScanner >> tokenActions [
	^ #(nil #whitespace)
]
