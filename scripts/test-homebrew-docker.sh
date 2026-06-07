#!/usr/bin/env bash

set -euo pipefail

IMAGE="${HOMEBREW_DOCKER_IMAGE:-homebrew/brew}"
TAP_DIR="${TAP_DIR:-$(pwd)}"

usage() {
  cat <<'EOF'
Usage:
  scripts/test-homebrew-docker.sh [formula...]

Examples:
  scripts/test-homebrew-docker.sh
  scripts/test-homebrew-docker.sh lucli
  scripts/test-homebrew-docker.sh markspresso
  scripts/test-homebrew-docker.sh lucli markspresso

Environment overrides:
  HOMEBREW_DOCKER_IMAGE   Docker image to use (default: homebrew/brew)
  TAP_DIR                 Path to tap repository to mount in container (default: current directory)
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker is required but was not found in PATH." >&2
  exit 1
fi

if [[ ! -d "${TAP_DIR}/Formula" ]]; then
  echo "Error: ${TAP_DIR}/Formula was not found. Run this script from the tap root or set TAP_DIR." >&2
  exit 1
fi

if [[ "$#" -eq 0 ]]; then
  formulas=(lucli markspresso)
else
  formulas=("$@")
fi

for formula in "${formulas[@]}"; do
  if [[ ! -f "${TAP_DIR}/Formula/${formula}.rb" ]]; then
    echo "Error: formula file not found: ${TAP_DIR}/Formula/${formula}.rb" >&2
    exit 1
  fi
done

for formula in "${formulas[@]}"; do
  echo "==> Testing formula: ${formula}"
  docker run --rm -t \
    -v "${TAP_DIR}:/tap" \
    -w /tap \
    "${IMAGE}" \
    bash -lc "brew update && brew install --build-from-source ./Formula/${formula}.rb && brew test --verbose ${formula} && brew audit --strict --online ${formula}"
done
