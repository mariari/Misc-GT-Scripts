Class {
	#name : #GitToolingExamples,
	#superclass : #Object,
	#category : #'MiscGTScripts-Examples'
}

{ #category : #accessing }
GitToolingExamples >> allLabels [
	<gtExample>
	^ self projectBoardDumperCounterPR contents repo allLabels
]

{ #category : #accessing }
GitToolingExamples >> allStatuses [
	<gtExample>
	| json |
	json := NeoJSONReader
			fromString: '[
					{
						"color" : "RED",
						"name" : "Closed",
						"description" : "Topic indefinitely rejected or withdrawn."
					},
					{
						"color" : "ORANGE",
						"name" : "Problem",
						"description" : "Topic is unacceptable or malformed beyond merely needing a reroll."
					},
					{
						"color" : "GRAY",
						"name" : "Blocked",
						"description" : "Not problematic, but blocked for reasons outside its own scope."
					},
					{
						"color" : "GRAY",
						"name" : "WIP",
						"description" : "Topic is advisory/work in progress, and has not been submitted."
					},
					{
						"color" : "PINK",
						"name" : "Triage",
						"description" : "Topic is awaiting some form of triage or retriage."
					},
					{
						"color" : "YELLOW",
						"name" : "Expecting reroll",
						"description" : "Expecting a reroll on this topic"
					},
					{
						"color" : "GREEN",
						"name" : "Next",
						"description" : "Topic is on `next`."
					},
					{
						"color" : "BLUE",
						"name" : "Master",
						"description" : "Topic is on `master`."
					},
					{
						"color" : "PURPLE",
						"name" : "Released",
						"description" : "Topic is in a (non-maintenance) release."
					}
				]'.
	^ json asGtJson collect: [ :x | GitLabelInfo new fromJson: x ]
]

{ #category : #dependencies }
GitToolingExamples >> anomaRepo [
	"TODO use a branch made just for this"

	| anoma |
	anoma := FileLocator home / 'Documents' / 'Work' / 'Repo' / 'anoma'.
	^ IceLibgitRepository new location: anoma
]

{ #category : #accessing }
GitToolingExamples >> branchBase [
	<gtExample>
	| branch topic |
	branch := IceGitRemoteBranch
			named: self remoteName , '/base'
			inRepository: self anomaRepo.
	topic := GitTopicInfo new
			topic: branch;
			allLabels: {self allLabels at: 2};
			projectInfo: self exampleProjectStatus;
			itemNumber: 20;
			status: self statusMaster.
	self assert: [ self branchV16 isParentOf: topic ].
	self assert: [ (topic isParentOf: self branchNifIntegration) not ].
	^ topic
]

{ #category : #accessing }
GitToolingExamples >> branchMerged [
	<gtExample>
	| branch |
	branch := IceGitRemoteBranch
			named: 'anoma/mariari/node-from-base'
			inRepository: self anomaRepo.

	^ GitTopicInfo new
		topic: branch;
		allLabels: {self allLabels at: 7.
				self allLabels at: 12};
		projectInfo: self exampleProjectStatus;
		status: self statusMaster;
		itemNumber: 20;
		yourself
]

{ #category : #accessing }
GitToolingExamples >> branchNifIntegration [
	<gtExample>
	| branch |
	branch := IceGitRemoteBranch
			named: self remoteName , '/attic/mariari/nif-integration'
			inRepository: self anomaRepo.

	^ GitTopicInfo new
		topic: branch;
		allLabels: {self allLabels at: 2};
		projectInfo: self exampleProjectStatus;
		itemNumber: 19;
		status: self statusClosed
]

{ #category : #accessing }
GitToolingExamples >> branchV16 [
	<gtExample>
	| branch |
	branch := IceGitRemoteBranch
			named: self remoteName , '/attic/v0.16.0'
			inRepository: self anomaRepo.

	^ GitTopicInfo new
		topic: branch;
		allLabels: {self allLabels at: 2};
		projectInfo: self exampleProjectStatus;
		itemNumber: 5;
		status: self statusWIP
]

{ #category : #accessing }
GitToolingExamples >> dumperCounterPR [
	<gtExample>
	| item |
	item := GithubPR new fromJson: self dumperCounterPRJSON.
	self assert: item refName equals: 'mariari/dumper-counter'.
	^ item
]

{ #category : #accessing }
GitToolingExamples >> dumperCounterPRJSON [
	<gtExample>
	| json |
	json := NeoJSONReader
			fromString: '{
			"headRefName" : "mariari/dumper-counter",
			"number" : 626,
			"repository" : {
				"labels" : {
					"edges" : [
						{
							"node" : {
								"color" : "e4e669",
								"name" : "invalid"
							}
						},
						{
							"node" : {
								"color" : "1d76db",
								"name" : "execution"
							}
						},
						{
							"node" : {
								"color" : "bfdadc",
								"name" : "cli"
							}
						}
					]
				}
			}
		},
		"labels" : null,
		"status" : {
			"name" : "Next"
		}'.
	^ json asGtJson
]

{ #category : #accessing }
GitToolingExamples >> exampleProjectStatus [
	<gtExample>
	| status |
	status := GitProjectInfo new
			statuses: self allStatuses;
			allLabels: self allLabels.

	^ status
]

{ #category : #accessing }
GitToolingExamples >> exampleReleaseCheck [
	<gtExample>
	| release |
	release := GitProjectBoardByHand new candidateBranch: self rcBranch.
	release
		items: {self branchNifIntegration.
				self branchMerged}.

	^ release
]

{ #category : #accessing }
GitToolingExamples >> executionLabel [
	<gtExample>
	| label |
	label := GitLabelInfo new
			color: (Color fromString: '1D76DB');
			name: 'execution';
			description: 'deals with execution';
			yourself.	"Think what to assert"
	^ label
]

{ #category : #dependencies }
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
GitToolingExamples >> projectBoardDumperCounterPR [
	<gtExample>
	| item |
	item := GithubProjectV2Item new
		fromJson: (self projectBoardDumperCounterPRJSON at: #node).
	self assert: item status name equals: 'Next'.
	^ item
]

{ #category : #accessing }
GitToolingExamples >> projectBoardDumperCounterPRJSON [
	<gtExample>
	| json |
	json := NeoJSONReader
			fromString: '{
	"cursor" : "NDM",
	"node" : {
		"id" : "PVTI_lADOBTOAss4AXf0FzgQpyXM",
		"content" : {
			"headRefName" : "mariari/dumper-counter",
			"number" : 626,
			"repository" : {
				"labels" : {
					"edges" : [
						{
							"node" : {
								"color" : "d73a4a",
								"name" : "bug"
							}
						},
						{
							"node" : {
								"color" : "0075ca",
								"name" : "documentation"
							}
						},
						{
							"node" : {
								"color" : "a2eeef",
								"name" : "enhancement"
							}
						},
						{
							"node" : {
								"color" : "7057ff",
								"name" : "good first issue"
							}
						},
						{
							"node" : {
								"color" : "008672",
								"name" : "help wanted"
							}
						},
						{
							"node" : {
								"color" : "e4e669",
								"name" : "invalid"
							}
						},
						{
							"node" : {
								"color" : "d876e3",
								"name" : "question"
							}
						},
						{
							"node" : {
								"color" : "ffffff",
								"name" : "wontfix"
							}
						},
						{
							"node" : {
								"color" : "FECFF0",
								"name" : "design"
							}
						},
						{
							"node" : {
								"color" : "c2e0c6",
								"name" : "need specs"
							}
						},
						{
							"node" : {
								"color" : "FEFC53",
								"name" : "networking"
							}
						},
						{
							"node" : {
								"color" : "3843A3",
								"name" : "ordering"
							}
						},
						{
							"node" : {
								"color" : "A6F19F",
								"name" : "control"
							}
						},
						{
							"node" : {
								"color" : "5CE26B",
								"name" : "hardware abstraction"
							}
						},
						{
							"node" : {
								"color" : "79E6CD",
								"name" : "nock"
							}
						},
						{
							"node" : {
								"color" : "88CFDF",
								"name" : "identity"
							}
						},
						{
							"node" : {
								"color" : "29BD18",
								"name" : "storage"
							}
						},
						{
							"node" : {
								"color" : "c5def5",
								"name" : "db layout"
							}
						},
						{
							"node" : {
								"color" : "d4c5f9",
								"name" : "rm"
							}
						},
						{
							"node" : {
								"color" : "736335",
								"name" : "refactoring"
							}
						},
						{
							"node" : {
								"color" : "bfdadc",
								"name" : "examples"
							}
						},
						{
							"node" : {
								"color" : "087D91",
								"name" : "attic"
							}
						},
						{
							"node" : {
								"color" : "1d76db",
								"name" : "execution"
							}
						},
						{
							"node" : {
								"color" : "bfdadc",
								"name" : "cli"
							}
						}
					]
				}
			}
		},
		"labels" : {
			"labels" : {
				"edges" : [
					{
						"node" : {
							"color" : "736335",
							"name" : "refactoring",
												"description" : ""
						}
					},
						{
							"node" : {
								"color" : "087D91",
								"name" : "attic",
								"description" : ""
								}
							}
					]
				}
				},
		"status" : {
			"name" : "Next"
		}
	}
}'.
	^ json asGtJson
]

{ #category : #accessing }
GitToolingExamples >> projectStatuses [
	<gtExample>
	^ self projectStatusesJSON collect: [ :x | GitLabelInfo new fromJson: x ]
]

{ #category : #accessing }
GitToolingExamples >> projectStatusesJSON [
	<gtExample>
	| json |
	json := NeoJSONReader
			fromString: '[
					{
						"color" : "RED",
						"name" : "Closed",
						"description" : "Topic indefinitely rejected or withdrawn."
					},
					{
						"color" : "ORANGE",
						"name" : "Problem",
						"description" : "Topic is unacceptable or malformed beyond merely needing a reroll."
					},
					{
						"color" : "GRAY",
						"name" : "Blocked",
						"description" : "Not problematic, but blocked for reasons outside its own scope."
					},
					{
						"color" : "GRAY",
						"name" : "WIP",
						"description" : "Topic is advisory/work in progress, and has not been submitted."
					},
					{
						"color" : "PINK",
						"name" : "Triage",
						"description" : "Topic is awaiting some form of triage or retriage."
					},
					{
						"color" : "YELLOW",
						"name" : "Expecting reroll",
						"description" : "Expecting a reroll on this topic"
					},
					{
						"color" : "GREEN",
						"name" : "Next",
						"description" : "Topic is on `next`."
					},
					{
						"color" : "BLUE",
						"name" : "Master",
						"description" : "Topic is on `master`."
					},
					{
						"color" : "PURPLE",
						"name" : "Released",
						"description" : "Topic is in a (non-maintenance) release."
					}
				]'.
	^ json asGtJson
]

{ #category : #accessing }
GitToolingExamples >> rcBranch [
	<gtExample>
	^ IceGitLocalBranch named: 'v0.17.0-rc1' inRepository: self anomaRepo
]

{ #category : #accessing }
GitToolingExamples >> refactoringLabel [
	<gtExample>
	| label |
	label := GitLabelInfo new
			color: (Color fromString: '736335');
			name: 'refactoring';
			description: 'refactoring the codebase';
			yourself.
	"Think what to assert"
	^ label
]

{ #category : #dependencies }
GitToolingExamples >> remoteName [
	^ 'anoma'
]

{ #category : #accessing }
GitToolingExamples >> skunksGithubProjectBoard [
	<gtExample>
	^ GithubGQLProjectBoard new
		context: self graphQLContext;
		gitLocation: FileLocator home / 'Documents' / 'Work' / 'Repo' / 'anoma';
		organisation: 'anoma';
		board: 20;
		remoteName: 'anoma';
		yourself
]

{ #category : #accessing }
GitToolingExamples >> skunksProjectBoardNext [
	<gtExample>
	^ self skunksGithubProjectBoard candidate: 'next'; computeStatus; yourself
]

{ #category : #accessing }
GitToolingExamples >> skunksProjectBoardRC17 [
	<gtExample>
	^ self skunksGithubProjectBoard candidate: 'v0.17.0-rc1'
]

{ #category : #accessing }
GitToolingExamples >> skunksProjectBoardRC17WithStatus [
	<gtExample>
	^ self skunksProjectBoardRC17 computeStatus; yourself
]

{ #category : #accessing }
GitToolingExamples >> statusClosed [
	<gtExample>
	^ GitLabelInfo new
		name: 'Closed';
		color: (Color fromString: 'red')
]

{ #category : #accessing }
GitToolingExamples >> statusMaster [
	<gtExample>
	^ GitLabelInfo new
		name: 'Master';
		color: (Color fromString: 'blue')
]

{ #category : #accessing }
GitToolingExamples >> statusWIP [
	<gtExample>
	^ GitLabelInfo new
		name: 'WIP';
		color: (Color fromString: 'gray')
]
