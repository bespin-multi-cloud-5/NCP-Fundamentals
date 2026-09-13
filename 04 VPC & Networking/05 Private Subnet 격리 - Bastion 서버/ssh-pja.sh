#!/usr/bin/env bash
#
# ssh-pja.sh — Bastion을 경유해 Private 서버의 셸을 연다 (공개키 방식)
#
#   ./ssh-pja.sh 10.0.101.6
#   ./ssh-pja.sh root@10.0.101.6
#   ./ssh-pja.sh 10.0.101.6 uptime
#   ./ssh-pja.sh root@10.0.101.6 uptime
#
# ─────────────────────────────────────────────────────────────────
# 준비 — 한 번만 한다
#
#   ① 키가 없으면 만든다
#
#        ssh-keygen -t ed25519 -C "ncp-lab"
#
#      물어보는 것을 모두 기본값으로 두면 ~/.ssh/id_ed25519 (비밀키)와
#      ~/.ssh/id_ed25519.pub (공개키)이 생긴다.
#
#   ② Bastion에 공개키를 등록한다. 관리자 비밀번호를 한 번 입력한다
#
#        ssh-copy-id root@223.130.xxx.xxx
#
#      NCP 서버는 비밀번호 인증이 켜져 있어 이 명령이 그대로 동작한다.
#      키가 여러 개면 어느 것을 올릴지 지정한다.
#
#        ssh-copy-id -i ~/.ssh/id_ed25519.pub root@223.130.xxx.xxx
#
#   ③ 비밀번호 없이 들어가지는지 확인한다
#
#        ssh root@223.130.xxx.xxx
#
#   Bastion을 반납하고 다시 만들면 ①은 건너뛰고 ②부터 다시 한다.
# ─────────────────────────────────────────────────────────────────
#
# ~/.ncp-lab.env — ssh-pj.sh와 같은 파일을 쓴다
#
#   NCP_BASTION_HOST=223.130.xxx.xxx
#   NCP_BASTION_USER=root                  생략하면 root
#   #NCP_BASTION_PW='관리자 비밀번호'        이 스크립트는 읽지 않는다
#
#   chmod 600 ~/.ncp-lab.env
#
# 두 스크립트의 차이는 NCP_BASTION_PW 하나다.
# 비밀번호를 저장해서 쓰려면 주석을 풀고 ssh-pj.sh 를 쓴다.
#
set -euo pipefail

ENV_FILE="${NCP_LAB_ENV:-$HOME/.ncp-lab.env}"
if [[ -f "$ENV_FILE" ]]; then
  set -a; . "$ENV_FILE"; set +a
fi

BASTION_HOST="${NCP_BASTION_HOST:-}"
BASTION_USER="${NCP_BASTION_USER:-root}"

PROG="$(basename "$0")"

usage() {
  local host="${BASTION_HOST:-223.130.xxx.xxx}"
  cat >&2 <<EOF
$PROG — Bastion을 경유해 Private 서버의 셸을 연다 (공개키 방식)

사용법
  $PROG [user@]host [명령...]

  host    목적지 사설 IP (예: 10.0.101.6)
  user    생략하면 root
  명령    주면 그 명령만 실행하고 끝난다

$ENV_FILE

  NCP_BASTION_HOST=223.130.xxx.xxx
  NCP_BASTION_USER=root                  생략 가능

준비 — 한 번만 한다
  ssh-keygen -t ed25519 -C "ncp-lab"          키가 없을 때만
  ssh-copy-id ${BASTION_USER}@${host}
  ssh ${BASTION_USER}@${host}                 확인

비밀번호를 저장해서 쓰려면 NCP_BASTION_PW를 넣고 ssh-pj.sh 를 쓴다.
EOF
  exit "${1:-1}"
}

die() { echo "$PROG: $1" >&2; exit "${2:-1}"; }

[[ $# -ge 1 ]] || usage
case "$1" in -h|--help) usage 0 ;; esac

[[ -n "$BASTION_HOST" ]] || die "NCP_BASTION_HOST가 없다. $ENV_FILE 에 적거나 환경변수로 넘긴다."

TARGET="$1"; shift
[[ -n "$TARGET" ]] || die "목적지 주소가 비어 있다."
[[ "$TARGET" == *@* ]] || TARGET="${BASTION_USER}@${TARGET}"

# 실습 서버를 반납하고 다시 만들면 같은 사설 IP에 다른 호스트 키가 온다.
SSH_OPTS=(
  -o StrictHostKeyChecking=no
  -o UserKnownHostsFile=/dev/null
  -o LogLevel=ERROR
)

# 공개키가 등록되지 않았으면 여기서 걸린다.
# BatchMode를 켜 두어 비밀번호를 묻지 않고 바로 실패하게 한다.
if ! ssh "${SSH_OPTS[@]}" -o BatchMode=yes -o ConnectTimeout=10 \
        "${BASTION_USER}@${BASTION_HOST}" true 2>/dev/null; then
  die "Bastion에 공개키 인증이 되지 않는다. 먼저 등록한다.
    ssh-keygen -t ed25519 -C \"ncp-lab\"      (키가 없을 때만)
    ssh-copy-id ${BASTION_USER}@${BASTION_HOST}"
fi

status=0
ssh "${SSH_OPTS[@]}" \
  -o ProxyCommand="ssh -W %h:%p -o BatchMode=yes ${SSH_OPTS[*]} ${BASTION_USER}@${BASTION_HOST}" \
  "$TARGET" "$@" || status=$?
exit "$status"
