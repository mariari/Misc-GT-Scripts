"
The `.so` file on linux was gotten from my [Misc C Scripts](https://github.com/mariari/Misc-c-scripts).

We do not vendor in the dependency for now, so if you are using windows or OSX you'll have to compile your own.
"
Class {
	#name : #MiscFFIDynamicLib,
	#superclass : #FFILibrary,
	#category : #MiscGTScripts
}

{ #category : #'api - accessing' }
MiscFFIDynamicLib >> indirectSqrt: x [
	"call sqrt from libm"

	^ self ffiCall: #(double indirect_sqrt #(double x))
]

{ #category : #'api - accessing' }
MiscFFIDynamicLib >> sayHello [
	^ self ffiCall: #(void say_hello #(void))
]

{ #category : #'accessing - platform' }
MiscFFIDynamicLib >> unix32LibraryName [
	^ FFIUnix32LibraryFinder findLibrary: self unixPath resolve fullName
]

{ #category : #'accessing - platform' }
MiscFFIDynamicLib >> unix64LibraryName [
	^ FFIUnix64LibraryFinder findLibrary: self unixPath resolve fullName
]

{ #category : #'accessing - platform' }
MiscFFIDynamicLib >> unixPath [
	^ MiscFFIExamples repository repository repositoryDirectory / 'deps' / 'unix'
		/ 'libshared.so'
]
