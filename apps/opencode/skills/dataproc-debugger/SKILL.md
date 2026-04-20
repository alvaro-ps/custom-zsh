---
name: dataproc-debugger
description: Debug dataproc batches and figure out their cause of failure
---

# Dataproc batches debugger

Figure out the cause why a specific dataproc batch failed.

## When to Use This Skill

Whenever you are asked to debug a dataproc batch

## Core Concepts

- You should receive a batch id.
- The production project is `os-pipeline-processing`
- The staging project is `os-stag-pipeline-processing`
- Unless specified, the project will be production
- Unless specified, the region will be `us-central1`

## Available scripts

- Use the script `scripts/batch_description.sh` to fetch information about the job configuration.
- Use the script `scripts/dataproc_logs.sh` to fetch the logs  
- Use the script `scripts/list_path.sh` to take a look at the input data if specified in the CLI args as a GCS path. This should help you see data size
- Use the script `scripts/describe_bq_table.sh` to take a look at the input data if specified in the input data as a BQ table. Make sure to always pass a filter to limit the table checking, use the input arguments to do this, selecting the dates/partitions/countries/... required only
