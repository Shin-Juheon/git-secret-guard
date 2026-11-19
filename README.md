# git-secret-guard

셸 스크립트를 이용한 Git 시크릿 유출 탐지와 차단

> "Add demo app" 커밋에는 시연을 위해 가짜 키를 일부러 넣었습니다. 실제로 동작하지 않는 값입니다.

## 구성
- `scripts/scan_history.sh` : 전체 커밋 기록에서 시크릿 탐지
- `hooks/pre-commit` : 시크릿이 포함된 커밋 차단
- `scripts/install_hooks.sh` : 훅 설치
- `scripts/load_env.sh` : .env 로드 및 필수값 검증
- `.github/workflows/gitleaks.yml` : 푸시할 때 gitleaks로 서버 측 검사

## 사용법
    bash scripts/install_hooks.sh
    cp .env.example .env   # 값 입력
    bash scripts/scan_history.sh
    bash demo/app.sh
