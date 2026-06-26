#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 <init|plan|apply|destroy> components=<component> [env=<env>]

Examples:
  $0 init   components=storage        # defaults to env=dev
  $0 plan   components=storage  env=stg
  $0 apply  components=compute  env=prod
EOF
  exit 1
}

# must have at least 2 args (command + components)
if [ $# -lt 2 ]; then
  usage
fi

# first arg is the command
CMD=$1; shift

# set default
ENV="dev"

# parse the rest as key=value
for arg in "$@"; do
  case $arg in
    components=*) COMPONENT="${arg#*=}" ;;
    env=*)        ENV="${arg#*=}"        ;;
    *)
      echo "Unknown argument: $arg"
      usage
      ;;
  esac
done

# validate
if [ -z "${COMPONENT:-}" ]; then
  echo "Error: components must be set."
  usage
fi

COMP_DIR="terraform/components/${COMPONENT}"
BACKEND_FILE="${COMP_DIR}/backend/${ENV}.tfvars"

if [ ! -d "$COMP_DIR" ]; then
  echo "Error: component dir not found: $COMP_DIR"
  exit 1
fi
if [ "$CMD" = "init" ] && [ ! -f "$BACKEND_FILE" ]; then
  echo "Error: backend file not found: $BACKEND_FILE"
  exit 1
fi

# dispatch
case $CMD in
  init)
    docker-compose run --rm terraform \
      -chdir="$COMP_DIR" init \
      -backend-config="backend/${ENV}.tfvars"
    ;;
  plan)
    docker-compose run --rm terraform \
      -chdir="$COMP_DIR" plan \
      -var-file="../../environments/${ENV}.tfvars"
    ;;
  apply)
    docker-compose run --rm terraform \
      -chdir="$COMP_DIR" apply \
      -var-file="../../environments/${ENV}.tfvars" -auto-approve
    ;;
      destroy)
    docker-compose run --rm terraform \
      -chdir="$COMP_DIR" destroy \
      -var-file="../../environments/${ENV}.tfvars" -auto-approve
    ;;
  *)
    echo "Unknown command: $CMD"
    usage
    ;;
esac
