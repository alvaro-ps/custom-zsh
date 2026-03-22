---
name: dag-output-tracking
description: Track where the output of a requested DAG is being used
---

# DAG output tracking

Find where the output of a given Airflow DAG is used

## When to Use This Skill

Whenever you are asked to see/find/track where the artifacts produced by a given DAG are used.
These can be BigQuery tables, files in cloud storage or any kind of database.

## Core Concepts

- Look for dependencies in things like:
    - Airflow DAGs (wait tasks on DAGs or on the data itself)
    - Inputs to jobs (for instance spark/beam script arguments)
    - SQL queries (in `FROM` or `JOIN` clauses)
- Dependencies can live in any company repo, not just in the one where the requested DAG is.
- Whenever you are using this skill, mention it to the user.
