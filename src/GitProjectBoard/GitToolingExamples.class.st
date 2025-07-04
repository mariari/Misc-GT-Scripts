Class {
	#name : #GitToolingExamples,
	#superclass : #Object,
	#classVars : [
		'context'
	],
	#category : #'GitProjectBoard-Examples'
}

{ #category : #accessing }
GitToolingExamples >> Atticv021Next [
	<gtExample>
	| branch topic |
	branch := IceGitRemoteBranch
			named: self remoteName , '/Attic/v0.21.0-next'
			inRepository: self anomaRepo.

	topic := self branchMerged
			topic: branch;
			item: self githubProjectV2NIFIntegration.
	^ topic
]

{ #category : #accessing }
GitToolingExamples >> allLabels [
	<gtExample>
	^ self allLabelsJSON
		collect: [ :item | GitLabelInfo new fromJson: (item asGtJson at: #node) ]
]

{ #category : #accessing }
GitToolingExamples >> allLabelsJSON [
	<gtExample>
	| json |
	json := NeoJSONReader
			fromString: '[
	{
		"node" : {
			"color" : "d73a4a",
			"name" : "bug",
			"description" : "Something isnt working",
			"id" : "LA_kwDOJ8kZ3M8AAAABVm7Dfg"
		}
	},
	{
		"node" : {
			"color" : "0075ca",
			"name" : "documentation",
			"description" : "Improvements or additions to documentation",
			"id" : "LA_kwDOJ8kZ3M8AAAABVm7DiA"
		}
	},
	{
		"node" : {
			"color" : "a2eeef",
			"name" : "enhancement",
			"description" : "New feature or request",
			"id" : "LA_kwDOJ8kZ3M8AAAABVm7DlA"
		}
	},
	{
		"node" : {
			"color" : "7057ff",
			"name" : "good first issue",
			"description" : "Good for newcomers",
			"id" : "LA_kwDOJ8kZ3M8AAAABVm7Dlw"
		}
	},
	{
		"node" : {
			"color" : "d876e3",
			"name" : "question",
			"description" : "Further information is requested",
			"id" : "LA_kwDOJ8kZ3M8AAAABVm7Dpg"
		}
	},
	{
		"node" : {
			"color" : "FECFF0",
			"name" : "architecture",
			"description" : "New designs should be drafted for improving the codebase",
			"id" : "LA_kwDOJ8kZ3M8AAAABV0WSOg"
		}
	},
	{
		"node" : {
			"color" : "c2e0c6",
			"name" : "need specs",
			"description" : "Needs Corresponding specs before being able to work",
			"id" : "LA_kwDOJ8kZ3M8AAAABebi8yw"
		}
	},
	{
		"node" : {
			"color" : "FEFC53",
			"name" : "networking",
			"description" : "Router, Transport, etc.",
			"id" : "LA_kwDOJ8kZ3M8AAAABebs1pg"
		}
	},
	{
		"node" : {
			"color" : "3843A3",
			"name" : "ordering",
			"description" : "Consensus, Execution, Mempool",
			"id" : "LA_kwDOJ8kZ3M8AAAABebs2qg"
		}
	},
	{
		"node" : {
			"color" : "A6F19F",
			"name" : "configuration",
			"description" : "Deals with System Configuration",
			"id" : "LA_kwDOJ8kZ3M8AAAABebs3nw"
		}
	},
	{
		"node" : {
			"color" : "79E6CD",
			"name" : "nock",
			"description" : "Deals with the nock VM Environment (interpretation, jam, cue etc.)",
			"id" : "LA_kwDOJ8kZ3M8AAAABebwilw"
		}
	},
	{
		"node" : {
			"color" : "88CFDF",
			"name" : "identity",
			"description" : "Deals with the Identity Machine from Specs",
			"id" : "LA_kwDOJ8kZ3M8AAAABebxsbg"
		}
	},
	{
		"node" : {
			"color" : "29BD18",
			"name" : "storage",
			"description" : "State for our source of truth. We can restore on it etc.",
			"id" : "LA_kwDOJ8kZ3M8AAAABkocYHQ"
		}
	},
	{
		"node" : {
			"color" : "c5def5",
			"name" : "db layout",
			"description" : "Deals  with the layout of our database/storage",
			"id" : "LA_kwDOJ8kZ3M8AAAABn78DqA"
		}
	},
	{
		"node" : {
			"color" : "d4c5f9",
			"name" : "shielded rm",
			"description" : "Deals with Shielded Resource Machine implementation",
			"id" : "LA_kwDOJ8kZ3M8AAAABoDkEHA"
		}
	},
	{
		"node" : {
			"color" : "736335",
			"name" : "refactoring",
			"description" : "Issues and topics dealing with refactoring the codebase",
			"id" : "LA_kwDOJ8kZ3M8AAAABpzJivg"
		}
	},
	{
		"node" : {
			"color" : "bfdadc",
			"name" : "examples",
			"description" : "Deals with creating examples or retrofitting things into examples.",
			"id" : "LA_kwDOJ8kZ3M8AAAABpzJ0AQ"
		}
	},
	{
		"node" : {
			"color" : "087D91",
			"name" : "attic",
			"description" : "There exists a topic with the prefix attic that we ought not to delete.",
			"id" : "LA_kwDOJ8kZ3M8AAAABqZz8sg"
		}
	},
	{
		"node" : {
			"color" : "1d76db",
			"name" : "execution",
			"description" : "Deals with our transaction environment",
			"id" : "LA_kwDOJ8kZ3M8AAAABqoRPkw"
		}
	},
	{
		"node" : {
			"color" : "bfdadc",
			"name" : "cli",
			"description" : "Deals with external shells",
			"id" : "LA_kwDOJ8kZ3M8AAAABqoRboQ"
		}
	},
	{
		"node" : {
			"color" : "f9d0c4",
			"name" : "topics",
			"description" : "Deals with topic related code changes",
			"id" : "LA_kwDOJ8kZ3M8AAAABq8Sicw"
		}
	},
	{
		"node" : {
			"color" : "fbca04",
			"name" : "juvix",
			"description" : "Deals with Juvix integration or anything that is about Juvix.",
			"id" : "LA_kwDOJ8kZ3M8AAAABrcVMqg"
		}
	},
	{
		"node" : {
			"color" : "d93f0b",
			"name" : "event",
			"description" : "Deals with problems around event logging",
			"id" : "LA_kwDOJ8kZ3M8AAAABrd1D0Q"
		}
	},
	{
		"node" : {
			"color" : "006b75",
			"name" : "transparent RM",
			"description" : "Deals with the transparent resource machine.",
			"id" : "LA_kwDOJ8kZ3M8AAAABrd3C7A"
		}
	},
	{
		"node" : {
			"color" : "b60205",
			"name" : "external API",
			"description" : "Deals with trying to setup external APIs or clients etc.",
			"id" : "LA_kwDOJ8kZ3M8AAAABrd7AqQ"
		}
	},
	{
		"node" : {
			"color" : "0052cc",
			"name" : "execution stdlib",
			"description" : "Deals with the standard library for Nock",
			"id" : "LA_kwDOJ8kZ3M8AAAABrd7_Cg"
		}
	},
	{
		"node" : {
			"color" : "3CDEF0",
			"name" : "Top Level",
			"description" : "Contains the dependency graph for major features",
			"id" : "LA_kwDOJ8kZ3M8AAAABr4M_ig"
		}
	}
]'.
	^ json asGtJson
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
	topic := self branchMerged
			item: self githubProjectV2ItemPubSub;
			topic: branch.
	self assert: [ self branchV16 isParentOf: topic ].
	self assert: [ (topic isParentOf: self Atticv021Next) not ].
	^ topic
]

{ #category : #accessing }
GitToolingExamples >> branchMerged [
	<gtExample>
	| branch topic |
	branch := IceGitRemoteBranch
			named: 'anoma/Attic/v0.15.0'
			inRepository: self anomaRepo.


	topic := GitTopicInfo new
			topic: branch;
			repo: self mockGithubToolingRepoAnoma;
			projectBoard: self mockGithubToolingBoard;
			item: self githubProjectV2ItemNodeFromBase.
	^ topic
]

{ #category : #accessing }
GitToolingExamples >> branchMergedPR [
	<gtExample>
	| branch topic |
	branch := IceGitRemoteBranch
			named: 'anoma/Attic/v0.15.0'
			inRepository: self anomaRepo.


	topic := GitTopicInfo new
			topic: branch;
			repo: self mockGithubToolingRepoAnoma;
			projectBoard: self mockGithubToolingBoard;
			item: self githubPRNodeFromBase.
	^ topic
]

{ #category : #accessing }
GitToolingExamples >> branchV16 [
	<gtExample>
	| branch topic |
	branch := IceGitRemoteBranch
			named: self remoteName , '/Attic/v0.16.0'
			inRepository: self anomaRepo.

	topic := self branchMerged
			topic: branch;
			item: self githubPRV16.
	self assert: [ self branchMerged isParentOf: topic ].
	^ topic
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
				"name" : "anoma",
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
GitToolingExamples >> exampleReleaseCheck [
	<gtExample>
	| release |
	release := GitProjectBoardByHand new candidateBranch: self mainBranch.
	release
		items: {self Atticv021Next.
				self branchMerged}.

	self assert: release items size equals: 2.
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

{ #category : #accessing }
GitToolingExamples >> genesisFileIssue [
	<gtExample>
	| item |
	item := GithubProjectV2Item new fromJson: self genesisFileIssueJson.
	self assert: item contents class equals: GithubIssue.
	self assert: item contents itemNumber isNumber.
	^ item
]

{ #category : #accessing }
GitToolingExamples >> genesisFileIssueJson [
	<gtExample>
	| json |
	json := NeoJSONReader
			fromString: '{
	"id" : "PVTI_lADOBTOAss4AXfzfzgLOxko",
	"content" : {
		"id" : "I_kwDOJ8kZ3M55QmU7",
		"number" : 51,
		"closed" : false,
		"title" : "Gensis File",
		"repository" : {
			"labels" : {
				"edges" : [
					{
						"node" : {
							"color" : "d73a4a",
							"name" : "bug",
							"description" : "Something isnt working"
						}
					},
					{
						"node" : {
							"color" : "0075ca",
							"name" : "documentation",
							"description" : "Improvements or additions to documentation"
						}
					},
					{
						"node" : {
							"color" : "a2eeef",
							"name" : "enhancement",
							"description" : "New feature or request"
						}
					},
					{
						"node" : {
							"color" : "7057ff",
							"name" : "good first issue",
							"description" : "Good for newcomers"
						}
					},
					{
						"node" : {
							"color" : "d876e3",
							"name" : "question",
							"description" : "Further information is requested"
						}
					},
					{
						"node" : {
							"color" : "FECFF0",
							"name" : "architecture",
							"description" : "New designs should be drafted for improving the codebase"
						}
					},
					{
						"node" : {
							"color" : "c2e0c6",
							"name" : "need specs",
							"description" : "Needs Corresponding specs before being able to work"
						}
					},
					{
						"node" : {
							"color" : "FEFC53",
							"name" : "networking",
							"description" : "Router, Transport, etc."
						}
					},
					{
						"node" : {
							"color" : "3843A3",
							"name" : "ordering",
							"description" : "Consensus, Execution, Mempool"
						}
					},
					{
						"node" : {
							"color" : "A6F19F",
							"name" : "configuration",
							"description" : "Deals with System Configuration"
						}
					},
					{
						"node" : {
							"color" : "79E6CD",
							"name" : "nock",
							"description" : "Deals with the nock VM Environment (interpretation, jam, cue etc.)"
						}
					},
					{
						"node" : {
							"color" : "88CFDF",
							"name" : "identity",
							"description" : "Deals with the Identity Machine from Specs"
						}
					},
					{
						"node" : {
							"color" : "29BD18",
							"name" : "storage",
							"description" : "State for our source of truth. We can restore on it etc."
						}
					},
					{
						"node" : {
							"color" : "c5def5",
							"name" : "db layout",
							"description" : "Deals  with the layout of our database/storage"
						}
					},
					{
						"node" : {
							"color" : "d4c5f9",
							"name" : "shielded rm",
							"description" : "Deals with Shielded Resource Machine implementation"
						}
					},
					{
						"node" : {
							"color" : "736335",
							"name" : "refactoring",
							"description" : "Issues and topics dealing with refactoring the codebase"
						}
					},
					{
						"node" : {
							"color" : "bfdadc",
							"name" : "examples",
							"description" : "Deals with creating examples or retrofitting things into examples."
						}
					},
					{
						"node" : {
							"color" : "087D91",
							"name" : "attic",
							"description" : "There exists a topic with the prefix attic that we ought not to delete."
						}
					},
					{
						"node" : {
							"color" : "1d76db",
							"name" : "execution",
							"description" : "Deals with our transaction environment"
						}
					},
					{
						"node" : {
							"color" : "bfdadc",
							"name" : "cli",
							"description" : "Deals with external shells"
						}
					},
					{
						"node" : {
							"color" : "f9d0c4",
							"name" : "topics",
							"description" : "Deals with topic related code changes"
						}
					},
					{
						"node" : {
							"color" : "fbca04",
							"name" : "juvix",
							"description" : "Deals with Juvix integration or anything that is about Juvix."
						}
					},
					{
						"node" : {
							"color" : "d93f0b",
							"name" : "event",
							"description" : "Deals with problems around event logging"
						}
					},
					{
						"node" : {
							"color" : "006b75",
							"name" : "transparent RM",
							"description" : "Deals with the transparent resource machine."
						}
					},
					{
						"node" : {
							"color" : "b60205",
							"name" : "external API",
							"description" : "Deals with trying to setup external APIs or clients etc."
						}
					},
					{
						"node" : {
							"color" : "0052cc",
							"name" : "execution stdlib",
							"description" : "Deals with the standard library for Nock"
						}
					},
					{
						"node" : {
							"color" : "3CDEF0",
							"name" : "Top Level",
							"description" : "Contains the dependency graph for major features"
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
						"color" : "a2eeef",
						"name" : "enhancement",
						"description" : "New feature or request"
					}
				},
				{
					"node" : {
						"color" : "A6F19F",
						"name" : "configuration",
						"description" : "Deals with System Configuration"
					}
				}
			]
		}
	},
	"status" : {
		"color" : "RED",
		"name" : "Pending",
		"description" : "This isnt assigned yet. Please take it for yourself!"
	}
}'.

	^ json asGtJson
]

{ #category : #accessing }
GitToolingExamples >> githubPRNifIntegration [
	<gtExample>
	^ GithubPR new
		allLabels: {self allLabels at: 18.
				self allLabels at: 25};
		refName: 'attic/mariari/nif-integration';
		author: 'mariari';
		itemNumber: 25
]

{ #category : #accessing }
GitToolingExamples >> githubPRNodeFromBase [
	<gtExample>
	^ GithubPR new
		allLabels: {self allLabels at: 11.
				self allLabels at: 8.
				self allLabels at: 19};
		refName: 'mariari/node-from-base';
		author: 'mariari';
		itemNumber: 230
]

{ #category : #accessing }
GitToolingExamples >> githubPRPubSub [
	<gtExample>
	^ GithubPR new
		allLabels: {self allLabels at: 27.
				self allLabels at: 6};
		refName: 'pubsub';
		author: 'mariari';
		itemNumber: 762
]

{ #category : #accessing }
GitToolingExamples >> githubPRV16 [
	<gtExample>
	^ GithubPR new
		allLabels: {self allLabels at: 18.
				self allLabels at: 20.
				self allLabels at: 5};
		refName: 'Attic/v0.16.0';
		itemNumber: 200
]

{ #category : #accessing }
GitToolingExamples >> githubProjectBoardSkunksNoItems [
	<gtExample>
	^ GithubProjectBoard new
		board: 20;
		items: {};
		org: 'anoma';
		title: 'Skunks Issue overview';
		allLabels: self allStatuses
]

{ #category : #accessing }
GitToolingExamples >> githubProjectV2ItemNodeFromBase [
	<gtExample>
	^ GithubProjectV2Item new
		contents: self githubPRNodeFromBase;
		status: self statusMaster
]

{ #category : #accessing }
GitToolingExamples >> githubProjectV2ItemPubSub [
	<gtExample>
	^ GithubProjectV2Item new
		contents: self githubPRPubSub;
		status: self statusWIP
]

{ #category : #accessing }
GitToolingExamples >> githubProjectV2ItemV016 [
	<gtExample>
	^ GithubProjectV2Item new
		contents: self githubPRV16;
		status: self statusMaster
]

{ #category : #accessing }
GitToolingExamples >> githubProjectV2NIFIntegration [
	<gtExample>
	^ GithubProjectV2Item new
		contents: self githubPRNifIntegration;
		status: self statusClosed
]

{ #category : #accessing }
GitToolingExamples >> githubRepoAnoma [
	<gtExample>
	^ GithubRepo new
		name: 'anoma';
		owner: 'anoma';
		allLabels: self allLabels
]

{ #category : #accessing }
GitToolingExamples >> graphQLContext [
	"There ought to be a better way than this"

	"Look at GhTokenHolder if the assertion fails"

	<gtExample>
	| aContext |
	context ifNotNil: [^ context].
	self assert: GtGitHubTokenHolder hasToken.
	aContext := GtGQLContext new
			url: 'https://api.github.com/graphql';
			bearerToken: GtGitHubTokenHolder token;
			buildSchema.

	aContext reportClass: GhGQLReport.
	context := aContext.	
	^ aContext
]

{ #category : #accessing }
GitToolingExamples >> mainBranch [
	<gtExample>
	^ IceGitLocalBranch named: 'main' inRepository: self anomaRepo
]

{ #category : #accessing }
GitToolingExamples >> mockGithubToolingBoard [
	<gtExample>
	^ GithubToolingBoard new projectBoard: self githubProjectBoardSkunksNoItems
]

{ #category : #accessing }
GitToolingExamples >> mockGithubToolingRepoAnoma [
	<gtExample>
	"I represent a mock version of the anoma tooling repo, without the ability to query"
	^ GithubToolingRepo new repository: self githubRepoAnoma
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

{ #category : #querying }
GitToolingExamples >> queryGithubToolingProjectBoardSkunks [
	<gtExample>
	^ GithubToolingBoard new
		context: self graphQLContext;
		board: 19;
		organization: 'anoma'
]

{ #category : #accessing }
GitToolingExamples >> queryGithubToolingProjectBoardWhatsCooking [
	<gtExample>
	^ self queryGithubToolingProjectBoardSkunks board: 20
]

{ #category : #accessing }
GitToolingExamples >> queryRepoAnoma [
	<gtExample>
	^ GithubToolingRepo new
		context: self graphQLContext;
		organization: 'anoma';
		repoName: 'anoma'
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
		gitLocation: {'anoma' ->( FileLocator home / 'Documents' / 'Work' / 'Repo' / 'anoma')}
				asDictionary;
		organization: 'anoma';
		board: 20;
		yourself
]

{ #category : #accessing }
GitToolingExamples >> skunksProjectBoardNext [
	<gtExample>
	^ self skunksGithubProjectBoard candidate: 'anoma' ->'next'; computeStatus; yourself
]

{ #category : #accessing }
GitToolingExamples >> skunksProjectBoardRC17 [
	<gtExample>
	^ self skunksGithubProjectBoard candidate: 'anoma' -> 'v0.17.0-rc1'
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
