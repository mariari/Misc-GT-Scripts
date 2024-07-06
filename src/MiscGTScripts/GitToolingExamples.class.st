Class {
	#name : #GitToolingExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-Examples'
}

{ #category : #accessing }
GitToolingExamples >> anomaRepo [
	"TODO use a branch made just for this"

	| anoma |
	anoma := FileLocator home / 'Documents' / 'Work' / 'Repo' / 'anoma'.
	^ IceLibgitRepository new location: anoma
]

{ #category : #accessing }
GitToolingExamples >> exampleClosedIssue [
	<gtExample>
	| branch |
	branch := IceGitRemoteBranch
			named: 'anoma/mariari/node-from-base'
			inRepository: self anomaRepo.

	^ GitTopicInfo new
		topic: branch tags: {};
		status: 'Closed';
		yourself
]

{ #category : #accessing }
GitToolingExamples >> exampleNockBranch [
	<gtExample>
	| branch |
	branch := IceGitRemoteBranch
			named: 'anoma/mariari/example-nock'
			inRepository: self anomaRepo.

	^ GitTopicInfo new
		topic: branch tags: {};
		status: 'WIP';
		yourself
]

{ #category : #accessing }
GitToolingExamples >> exampleReleaseCheck [
	<gtExample>
	| release |
	release := GitReleaseStatus new releaseBranch: self rcBranch.
	release
		topics: {self exampleNockBranch.
				self exampleClosedIssue}.
	^ release
]

{ #category : #accessing }
GitToolingExamples >> githubAccessKey [
	"There ought to be better ways to do this"

	| githubAccessKeyFile |
	githubAccessKeyFile := FileLocator home / '.emacs.d' / 'gh-key.txt'.
	^ githubAccessKeyFile contents trimBoth
]

{ #category : #accessing }
GitToolingExamples >> graphQLContext [
	"There ought to be a better way than this"

	<gtExample>
	| aContext |
	aContext := GtGQLContext new
			url: 'https://api.github.com/graphql';
			bearerToken: self githubAccessKey;
			buildSchema.

	aContext reportClass: GhGQLReport.
	^ aContext
]

{ #category : #accessing }
GitToolingExamples >> rcBranch [
	<gtExample>
	^ IceGitLocalBranch named: 'v0.17.0-rc1' inRepository: self anomaRepo
]

{ #category : #accessing }
GitToolingExamples >> skunksProjectBoard [
	<gtExample>
	^ GitProjectBoard new
		context: self graphQLContext;
		gitLocation: FileLocator home / 'Documents' / 'Work' / 'Repo' / 'anoma';
		organization: 'anoma';
		board: 20;
		remoteName: 'anoma';
		yourself
]

{ #category : #accessing }
GitToolingExamples >> skunksProjectBoardRC17 [
	<gtExample>
	^ self skunksProjectBoard releaseCandidate: 'v0.17.0-rc1'
]
