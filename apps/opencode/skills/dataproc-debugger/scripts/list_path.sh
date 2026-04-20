#!/usr/bin/env bash
gcs_path="$1"
if [[ -z "$gcs_path" ]]
then
  echo "Usage: gcs_ls <gs://bucket/path>"
  return 1
fi
# Strip trailing slash, ensure recursive listing
gcs_path="${gcs_path%/}"
gcloud storage ls --recursive --long "$gcs_path/**" \
  --format="value(size,name)"
