#!/bin/bash
# .env 파일을 읽어 환경변수로 등록하고, 필수값이 비어 있으면 중단
ENV_FILE="$(git rev-parse --show-toplevel)/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "[오류] .env 파일이 없습니다. .env.example을 복사해 만드세요."
  exit 1
fi

set -a; source "$ENV_FILE"; set +a
: "${AWS_ACCESS_KEY_ID:?AWS_ACCESS_KEY_ID가 설정되지 않았습니다}"
