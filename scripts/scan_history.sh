#!/bin/bash
# 전체 커밋 기록에서 시크릿 패턴을 찾는 스크립트
PATTERNS='AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{36}'
found=0

for commit in $(git rev-list --all); do
  keys=$(git show "$commit" | grep -E '^\+' | grep -oE "$PATTERNS")
  if [ -n "$keys" ]; then
    echo "[발견] 커밋 $(git log -1 --format='%h %s' "$commit")"
    echo "       $keys"
    found=1
  fi
done

if [ $found -eq 0 ]; then
  echo "[결과] 시크릿이 발견되지 않았습니다."
fi
exit $found
