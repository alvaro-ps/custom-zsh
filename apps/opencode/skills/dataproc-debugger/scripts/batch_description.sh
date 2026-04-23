#!/usr/bin/env bash
batch_id="$1"
project="${2:-os-pipeline-processing}"
region="${3:-us-central1}"
if [[ -z "$batch_id" ]]
then
  echo "Usage: dataproc_describe <batch_id> [project] [region]"
  echo ""
  echo "  batch_id     Dataproc Serverless batch job ID"
  echo "  project      GCP project (default: os-pipeline-processing)"
  echo "  region       GCP region (default: us-central1)"
  return 1
fi
echo "Fetching description for batch: $batch_id (project=$project, region=$region)..." >&2
gcloud dataproc batches describe "$batch_id" \
  --project="$project" \
  --region="$region" \
  --format=json
