#!/bin/bash
source "$(dirname "$0")/../scripts/load_env.sh"
echo "AWS 키로 서버에 접속합니다 (키 앞자리: ${AWS_ACCESS_KEY_ID:0:4}****)"
