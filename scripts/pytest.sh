#!/usr/bin/env bash
# Run pytest inside the scheduled_modules container
# Usage: ./scripts/pytest.sh [pytest-args...]
# Example: ./scripts/pytest.sh --live

set -euo pipefail

# Resolve project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${PROJECT_ROOT}/docker-compose.yaml"

# Script help
if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  echo "Usage: $(basename "$0") [pytest-args]"
  echo "  Runs 'pytest -q' inside the 'scheduled_modules' Docker container."
  echo "  Any arguments provided are forwarded to pytest (e.g. --live)."
  echo "  Uses docker-compose.yaml from project root: $PROJECT_ROOT"
  exit 0
fi

echo "Running pytest in scheduled_modules container..."
# Pass all provided arguments to pytest; include -q by default
docker compose -f "$COMPOSE_FILE" run --rm scheduled_modules pytest -q "$@"
