#!/usr/bin/env bash
set -euo pipefail
table="${1:-}"   # project:dataset.table or project.dataset.table
filter="${2:-}"  # required WHERE clause, e.g. "date = '2025-01-01' AND country = 'US'"
if [[ -z "$table" || -z "$filter" ]]; then
  cat >&2 <<'EOF'
Usage: describe_bq_table.sh <project:dataset.table> <where_filter>
  table         BigQuery table (project:dataset.table or project.dataset.table)
  where_filter  SQL WHERE clause (without the 'WHERE' keyword)
Example:
  describe_bq_table.sh my-proj:ds.events "date = '2025-01-01' AND country = 'US'"
EOF
  exit 1
fi
# Normalise to project.dataset.table for SQL, and extract the project for billing.
sql_table="${table/:/.}"
billing_project="${sql_table%%.*}"
run_or_die() {
  # Runs a command, captures stdout, prints a useful error if it fails or
  # produces non-JSON output. Usage: run_or_die "label" cmd args...
  local label="$1"; shift
  local out rc
  out=$("$@" 2>&1)
  rc=$?
  if [[ $rc -ne 0 ]]; then
    echo "ERROR: $label failed (exit $rc):" >&2
    echo "$out" >&2
    exit $rc
  fi
  # bq sometimes exits 0 while writing an error message to stdout, so we also
  # validate the payload is JSON before returning it.
  if ! jq -e . >/dev/null 2>&1 <<<"$out"; then
    echo "ERROR: $label returned non-JSON output:" >&2
    echo "$out" >&2
    exit 1
  fi
  printf '%s' "$out"
}
metadata_raw=$(run_or_die "bq show $table" \
  bq show --format=prettyjson "$table")
metadata=$(jq '{
    id,
    type,
    numRows,
    numBytes,
    numLongTermBytes,
    creationTime,
    lastModifiedTime,
    timePartitioning,
    rangePartitioning,
    clustering
  }' <<<"$metadata_raw")
filter_raw=$(run_or_die "bq query (project=$billing_project)" \
  bq query \
    --project_id="$billing_project" \
    --nouse_legacy_sql \
    --format=json \
    --quiet \
    "SELECT COUNT(*) AS row_count FROM \`${sql_table}\` WHERE ${filter}")
filter_result=$(jq '.[0]' <<<"$filter_raw")
jq -n \
  --arg table "$table" \
  --arg filter "$filter" \
  --argjson metadata "$metadata" \
  --argjson filter_result "$filter_result" \
  '{
    table: $table,
    filter: $filter,
    metadata: $metadata,
    filter_result: $filter_result
  }'
