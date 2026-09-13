#!/usr/bin/env bash
#
# ssh-pj.sh — Bastion을 경유해 Private 서버의 셸을 연다 (비밀번호 방식)
#
# Bastion의 공인 IP와 관리자 비밀번호를 ~/.ncp-lab.env 에서 읽는다.
# Bastion 구간의 비밀번호는 스크립트가 대신 넣고, 목적지 비밀번호만 입력한다.
#
#   ./ssh-pj.sh 10.0.101.6
#   ./ssh-pj.sh root@10.0.101.6
#   ./ssh-pj.sh 10.0.101.6 uptime
#   ./ssh-pj.sh root@10.0.101.6 uptime
#
# ~/.ncp-lab.env — ssh-pja.sh와 같은 파일을 쓴다. 저장소 밖에 둔다
#
#   NCP_BASTION_HOST=223.130.xxx.xxx
#   NCP_BASTION_USER=root                  생략하면 root
#   NCP_BASTION_PW='관리자 비밀번호'           이 스크립트에는 반드시 있어야 한다
#
#   chmod 600 ~/.ncp-lab.env
#
# 두 스크립트의 차이는 NCP_BASTION_PW 하나다.
# 주석 처리하면 공개키 방식인 ssh-pja.sh 를 쓴다.
#
# 비밀번호 입력에는 OpenSSH의 SSH_ASKPASS를 쓴다. 별도 도구가 필요 없다.
# SSH_ASKPASS_REQUIRE=force 는 OpenSSH 8.4 이상에서 동작한다.
#
set -euo pipefail

ENV_FILE="${NCP_LAB_ENV:-$HOME/.ncp-lab.env}"
if [[ -f "$ENV_FILE" ]]; then
  set -a; . "$ENV_FILE"; set +a
fi

BASTION_HOST="${NCP_BASTION_HOST:-}"
BASTION_USER="${NCP_BASTION_USER:-root}"
BASTION_PW="${NCP_BASTION_PW:-}"

PROG="$(basename "$0")"

usage() {
  cat >&2 <<EOF
$PROG — Bastion을 경유해 Private 서버의 셸을 연다 (비밀번호 방식)

사용법
  $PROG [user@]host [명령...]

  host    목적지 사설 IP (예: 10.0.101.6)
  user    생략하면 root
  명령    주면 그 명령만 실행하고 끝난다

$ENV_FILE

  NCP_BASTION_HOST=223.130.xxx.xxx
  NCP_BASTION_PW='관리자 비밀번호'
  NCP_BASTION_USER=root            생략 가능

Bastion 비밀번호는 스크립트가 넣는다. 목적지 비밀번호만 입력한다.
공개키를 등록해서 쓰려면 ssh-pja.sh 를 쓴다.
EOF
  exit "${1:-1}"
}

die() { echo "$PROG: $1" >&2; exit "${2:-1}"; }

[[ $# -ge 1 ]] || usage
case "$1" in -h|--help) usage 0 ;; esac

[[ -n "$BASTION_HOST" ]] || die "NCP_BASTION_HOST가 없다. $ENV_FILE 에 적거나 환경변수로 넘긴다."
[[ -n "$BASTION_PW" ]] || die "NCP_BASTION_PW가 없다. 공개키 방식은 ssh-pja.sh 를 쓴다."

perm="$(stat -f '%Lp' "$ENV_FILE" 2>/dev/null || stat -c '%a' "$ENV_FILE" 2>/dev/null || echo '')"
case "$perm" in
  ''|600|400) ;;
  *) echo "$PROG: 경고 — $ENV_FILE 권한이 $perm 이다. chmod 600 을 권한다." >&2 ;;
esac

TARGET="$1"; shift
[[ -n "$TARGET" ]] || die "목적지 주소가 비어 있다."
[[ "$TARGET" == *@* ]] || TARGET="${BASTION_USER}@${TARGET}"

# 실습 서버를 반납하고 다시 만들면 같은 사설 IP에 다른 호스트 키가 온다.
SSH_OPTS=(
  -o StrictHostKeyChecking=no
  -o UserKnownHostsFile=/dev/null
  -o LogLevel=ERROR
)

# 비밀번호를 명령줄에 두지 않는다. 인자는 ps에 보인다.
# 권한 600 임시 파일에 담고 askpass 도우미가 그것을 읽게 한다.
TMPDIR_PJ="$(mktemp -d)"
chmod 700 "$TMPDIR_PJ"
trap 'rm -rf "$TMPDIR_PJ"' EXIT INT TERM HUP

PW_FILE="$TMPDIR_PJ/pw"
ASKPASS="$TMPDIR_PJ/askpass"
umask 077
printf '%s\n' "$BASTION_PW" > "$PW_FILE"
printf '#!/bin/sh\nexec cat %q\n' "$PW_FILE" > "$ASKPASS"
chmod 700 "$ASKPASS"

# askpass를 ProxyCommand 안에서만 켠다.
# 바깥 ssh까지 켜지면 목적지 비밀번호에도 Bastion 것이 들어간다.
status=0
ssh "${SSH_OPTS[@]}" \
  -o ProxyCommand="env SSH_ASKPASS=$ASKPASS SSH_ASKPASS_REQUIRE=force ssh -W %h:%p ${SSH_OPTS[*]} ${BASTION_USER}@${BASTION_HOST}" \
  "$TARGET" "$@" || status=$?
exit "$status"
