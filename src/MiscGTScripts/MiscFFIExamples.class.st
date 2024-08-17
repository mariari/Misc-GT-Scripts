Class {
	#name : #MiscFFIExamples,
	#superclass : #Object,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MiscFFIExamples class >> clock [
	^ LibC uniqueInstance ffiCall: #( uint clock())
]

{ #category : #accessing }
MiscFFIExamples class >> clockByHand [
	"This is worse than using the standard library mechanism but shows it can be done"

	^ self new ffiCall: #(uint clock #()) library: 'libc.so.6'
]

{ #category : #accessing }
MiscFFIExamples class >> indirectSqrt: aNumber [
	^ MiscFFIDynamicLib uniqueInstance indirectSqrt: aNumber
]

{ #category : #accessing }
MiscFFIExamples class >> sayHello [
	^ MiscFFIDynamicLib uniqueInstance sayHello
]

{ #category : #accessing }
MiscFFIExamples class >> sqrt: aNumber [
	"I should create a libm"
	^ self new ffiCall: #(double sqrt #(double aNumber)) library: 'libm.so.6'
]
