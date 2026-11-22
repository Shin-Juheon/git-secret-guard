# git-secret-guard

셸 스크립트를 이용한 Git 시크릿 유출 탐지와 차단

## 구성

| 파일 | 역할 |
|---|---|
| `scripts/scan_history.sh` | 전체 커밋 기록에서 시크릿 탐지 |
| `hooks/pre-commit` | 시크릿이 들어간 커밋 차단 |
| `scripts/install_hooks.sh` | 훅 설치 (`core.hooksPath` 설정) |
| `scripts/load_env.sh` | `.env` 로드와 필수값 검증 |
| `.github/workflows/gitleaks.yml` | 푸시할 때 gitleaks로 서버 측 검사 |

## 내 저장소에 적용하기

1. 이 저장소를 클론해서 가져온다.

       git clone https://github.com/Shin-Juheon/git-secret-guard.git

2. `hooks` 폴더와 `scripts` 폴더를 내 저장소 최상위에 복사한다.

3. 내 저장소 폴더에서 훅을 설치한다. 이후 탐지 조건에 맞는 키가 들어간 커밋은 차단된다.

       bash scripts/install_hooks.sh

4. 지금까지의 커밋 기록에 시크릿이 남아 있는지 검사한다.

       bash scripts/scan_history.sh

5. 키는 코드에 적지 말고 `.env`에 두고, `.env`는 Git에 올리지 않는다.

       echo '.env' >> .gitignore

   `load_env.sh`의 마지막 줄에서 검사할 변수 이름을 내 프로젝트에 맞게 바꿔 쓰면 된다.

## 탐지 범위와 한계

- `AKIA`로 시작하는 AWS 액세스 키와 `ghp_`로 시작하는 깃허브 토큰, 두 형식만 찾을 수 있다.
- 단순한 비밀번호는 찾지 못했고 gitleaks도 같은 결과를 보였다.
- 키가 이미 유출됐다면 커밋 기록을 지우는 것보다 해당 서비스에서 키를 폐기하고 새로 발급하는 것이 좋은 방법이다.

## 참고 문헌

- Palo Alto Networks Unit 42, "EleKtra-Leak: Malicious Operations of Exposed IAM Keys" (2023): 공개 저장소에 커밋한 뒤 지운 AWS 키가 5분 안에 악용된 실험
  https://unit42.paloaltonetworks.com/malicious-operations-of-exposed-iam-keys-cryptojacking/
- Git, githooks 문서: https://git-scm.com/docs/githooks
- PIEinc, "CWE-798 (하드코딩된 자격증명 사용) 뜻과 위험성," PIEinc 위협 정보. https://pieinc.co.kr/threat-intel/glossary/cwe-798
- gitleaks: https://github.com/gitleaks/gitleaks
