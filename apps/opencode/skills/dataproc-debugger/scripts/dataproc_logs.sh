batch_id="$1"
project="${2:-os-pipeline-processing}"
region="${3:-us-central1}"

if [[ -z "$batch_id" ]]
then
  echo "Usage: dataproc_logs <batch_id> [project] [region]"
  echo ""
  echo "  batch_id     Dataproc Serverless batch job ID"
  echo "  project      GCP project (default: os-pipeline-processing)"
  echo "  region       GCP region (default: us-central1)"
  return 1
fi
echo "Fetching logs for batch: $batch_id (project=$project, region=$region)..."
gcloud logging read "resource.type=\"cloud_dataproc_batch\" AND resource.labels.batch_id=\"$batch_id\" AND resource.labels.location=\"$region\" AND log_name=\"projects/$project/logs/dataproc.googleapis.com%2Foutput\"" --project="$project" --format="value(jsonPayload.message)" --order=asc
