If you want to apply as a Ruby on Rails Developer at WizVille you are in the right spot!

<img src="https://cdn-images.welcometothejungle.com/DRfnXtN9bgVLITKSI8SRILIK9XmLlA6-4kNo9rZsKVg/rs:auto:2000::/q:85/czM6Ly93dHRqLXByb2R1Y3Rpb24vdXBsb2Fkcy9pbWFnZS9maWxlLzEwMzAvMTY1MzkwLzg1MTQyNTBiLWFlMTEtNGFiZi1hOTI4LTUxMTRhOGEzNDkxNi5qcGc" width="500" height="332"></a>

WizVille want to create a WizVille Academy to train its customers and collaborators into the usage of the platform and the understanding of all the concepts underlying it.

For that we have created a list of educational activities that will help the person doing them (the student) understanding the platform with an adapted progression.

The goal here is to provide the student the most relevant activities, so that each student can learn at the right pace.

## Problem definition

To achieve this goal, you will be working on an API point:

GET api/students/:id/next_activity

Given a student ID in params, this API point should return the most relevant activity taking into account pedagogical rules, the student progress, and other domain-related constraints.

An **activity** is defined with the following attributes:

- `id`: A unique identifier (uuid)

- `language`: The language of the activity's content. `fr` or `en`

- `activity_type`: The type of the activity. Our types of activity and skills are very complexes and must remain secret this is why they are named in this exercise with an old druidic code supposedly indecryptable.

- `skill`: The skill that will be developed in the activity

- `level`: 0 is an easy activity, 1 a bit harder, ...

`activities.json` contains the list of all the activities available, the file can be use for database seed or not.

A **student** is defined by:

- `language`: the student’s working language. A student learning in french will have the `fr` value.

- `traces`: A list of traces corresponding to the activities the student previously finished. Traces are chronologically ordered, the first one being the latest. Each trace contains:

  - `activity_id`: An activity id.

  - `score`: The student's score for this activity. If an activity contains 4 questions and the student is right only for the first one, this score will be 0.25.

This test is split in a few levels. For each level, a new constraint is added to the choice algorithm.

You should start at level 1 and work your way up to higher levels. We expect you to work a couple of hours maximum on this exercise. You can propose unfinished work.

### Level 1: Simple progression

For now, we'll just follow the default activities progression.

- _If a student answered perfectly to the last activity, the next activity is the next one in the activities list._
- _Otherwise, try to find another activity with a lower level._
- _If it doesn’t exist, return the last finished activity._

### Level 2: Avoid repetitions

Giving the same activity many times in a row is not a good way to keep students engaged.

_Make sure a student never gets a given activity_type twice in a row.
If no activity matches this constraint, ignore it and fallback to the level 1 algorithm_

### Level 3: Handling microphones

Some activities require a microphone but some users don't have a microphone.

A new property in student objects now tells you if the student has a microphone or not.

_Make sure only students with a microphone can get an actitity with an activity_type containing `reading`. If no activity matches this constraint, throw an exception. This rule should be a priority over all other rules_

### Level 4: Discoveries

We provide discovery activities. They allow students to discover new skills they never worked on.

- Discovery activities only exist on activities which activity_type is `discovery_trelambbra`, `discovery_gretodnempplapuisdry` or `discovery_glepemponrklapuiccla`.
- Some skills have no discovery.
- Discoveries always result in a trace with a 1 score.

_When a student works for the first time on a given skill, make sure that, if this skill has a discovery activity, the discovery is given to the student first, and, right after the discovery, another activity with the same skill is given._

### Level 5: Assignments

We want to allow WizVille employees to assign a skill to students.

- Student objects now have an assigned skill property
- When a student has an assignment, an activity matching the assignment should be given
- To validate an assignment, a student should finish 3 activities in a row with the right skill.
- If a discovery is necessary for an assigned skill, 4 activities instead of 3 are required to validate the assignment (the discovery + 3 other activities)

## The results
- You will be evaluated on several things:
  - Your understanding of the problematic and your capacity to ask the good questions (you are invited to ask questions and we will be pleased to answer them)
  - Your design choices and your reasons behind them
  - The quality and readability of your code, don't focus on finishing all of the levels
  - The stability of the code and your ability to find and resolve potential edge-cases
- Use the Rails project to answer to this test
- Students, activities and all others models that you find useful should be stored in DB using Active Record.
- This is just an API point, no visual interface is required and no authentification
- You are free to use whatever Gem that you find usefull
- No need to deploy the project, we just need the code.
- Create a pull request
- Create at least one commit per level
- In `report.md`, explain your design choices, the time you spent working on the project, what issues you had/what took you longer than expected
