#Requires -Version 7.0
<#
ssh-pja.ps1 — Bastion을 경유해 Private 서버의 셸을 연다 (공개키 방식)

    .\ssh-pja.ps1 10.0.101.6
    .\ssh-pja.ps1 root@10.0.101.6
    .\ssh-pja.ps1 10.0.101.6 uptime
    .\ssh-pja.ps1 root@10.0.101.6 uptime

─────────────────────────────────────────────────────────────────
준비 — 한 번만 한다

  ① 키가 없으면 만든다

       ssh-keygen -t ed25519 -C "ncp-lab"

     물어보는 것을 모두 기본값으로 두면 $HOME\.ssh\id_ed25519 (비밀키)와
     $HOME\.ssh\id_ed25519.pub (공개키)이 생긴다.

  ② Bastion에 공개키를 등록한다. 관리자 비밀번호를 한 번 입력한다

       Get-Content $HOME\.ssh\id_ed25519.pub |
         ssh root@223.130.xxx.xxx "mkdir -p ~/.ssh; chmod 700 ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"

     Windows에는 ssh-copy-id가 없어서 같은 일을 손으로 한다.

  ③ 비밀번호 없이 들어가지는지 확인한다

       ssh root@223.130.xxx.xxx

  Bastion을 반납하고 다시 만들면 ①은 건너뛰고 ②부터 다시 한다.
─────────────────────────────────────────────────────────────────

~/.ncp-lab.env — bash 판(ssh-pj.sh, ssh-pja.sh)과 같은 파일을 쓴다

    NCP_BASTION_HOST=223.130.xxx.xxx
    NCP_BASTION_USER=root                  생략하면 root
    #NCP_BASTION_PW='관리자 비밀번호'        이 스크립트는 읽지 않는다

비밀번호를 저장해서 자동으로 넣는 방식(bash의 ssh-pj.sh)은 PowerShell에
옮기지 않았다. Win32-OpenSSH가 SSH_ASKPASS를 제대로 지원하지 않는다.
Windows에서는 공개키 방식을 쓴다.
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string] $Target,

    [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
    [string[]] $Command,

    [Alias('h')]
    [switch] $Help
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Prog = Split-Path -Leaf $PSCommandPath
$EnvFile = if ($env:NCP_LAB_ENV) { $env:NCP_LAB_ENV } else { Join-Path $HOME '.ncp-lab.env' }

function Show-Usage {
    param([int] $ExitCode = 1)
    $host_ = if ($env:NCP_BASTION_HOST) { $env:NCP_BASTION_HOST } else { '223.130.xxx.xxx' }
    $user_ = if ($env:NCP_BASTION_USER) { $env:NCP_BASTION_USER } else { 'root' }
    @"
$Prog — Bastion을 경유해 Private 서버의 셸을 연다 (공개키 방식)

사용법
  .\$Prog [user@]host [명령...]

  host    목적지 사설 IP (예: 10.0.101.6)
  user    생략하면 root
  명령    주면 그 명령만 실행하고 끝난다

$EnvFile

  NCP_BASTION_HOST=$host_
  NCP_BASTION_USER=$user_                  생략 가능

준비 — 한 번만 한다
  ssh-keygen -t ed25519 -C "ncp-lab"          키가 없을 때만
  Get-Content `$HOME\.ssh\id_ed25519.pub | ssh $user_@$host_ "mkdir -p ~/.ssh; chmod 700 ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"
  ssh $user_@$host_                           확인
"@ -split "`n" | ForEach-Object { [Console]::Error.WriteLine($_) }
    exit $ExitCode
}

function Stop-WithError {
    param([string] $Message, [int] $ExitCode = 1)
    [Console]::Error.WriteLine("${Prog}: $Message")
    exit $ExitCode
}

# ── ~/.ncp-lab.env 읽기 ───────────────────────────────────────────
# bash의 `set -a; . file` 과 같게 동작한다. 파일 값이 기존 환경변수를 덮는다.
if (Test-Path -LiteralPath $EnvFile) {
    foreach ($line in Get-Content -LiteralPath $EnvFile) {
        $t = $line.Trim()
        if ($t -eq '' -or $t.StartsWith('#')) { continue }
        $i = $t.IndexOf('=')
        if ($i -lt 1) { continue }
        $k = $t.Substring(0, $i).Trim()
        $v = $t.Substring($i + 1).Trim()
        if ($v.Length -ge 2) {
            $q = $v[0]
            if (($q -eq "'" -or $q -eq '"') -and $v[-1] -eq $q) {
                $v = $v.Substring(1, $v.Length - 2)
            }
        }
        Set-Item -LiteralPath "Env:$k" -Value $v
    }
}

$BastionHost = if ($env:NCP_BASTION_HOST) { $env:NCP_BASTION_HOST } else { '' }
$BastionUser = if ($env:NCP_BASTION_USER) { $env:NCP_BASTION_USER } else { 'root' }

if ($Help)    { Show-Usage 0 }
if (-not $Target) { Show-Usage 1 }

if (-not $BastionHost) {
    Stop-WithError "NCP_BASTION_HOST가 없다. $EnvFile 에 적거나 환경변수로 넘긴다."
}

if (-not (Get-Command ssh -CommandType Application -ErrorAction SilentlyContinue)) {
    Stop-WithError "ssh를 찾을 수 없다. Windows 기능에서 OpenSSH 클라이언트를 설치한다." 127
}

if ($Target -notmatch '@') { $Target = "$BastionUser@$Target" }

# 실습 서버를 반납하고 다시 만들면 같은 사설 IP에 다른 호스트 키가 온다.
$NullDevice = if ($IsWindows) { 'NUL' } else { '/dev/null' }
$SshOpts = @(
    '-o', 'StrictHostKeyChecking=no'
    '-o', "UserKnownHostsFile=$NullDevice"
    '-o', 'LogLevel=ERROR'
)

# 공개키가 등록되지 않았으면 여기서 걸린다.
# BatchMode를 켜 두어 비밀번호를 묻지 않고 바로 실패하게 한다.
& ssh @SshOpts '-o' 'BatchMode=yes' '-o' 'ConnectTimeout=10' "$BastionUser@$BastionHost" 'true' 2>$null
if ($LASTEXITCODE -ne 0) {
    Stop-WithError @"
Bastion에 공개키 인증이 되지 않는다. 먼저 등록한다.
    ssh-keygen -t ed25519 -C "ncp-lab"      (키가 없을 때만)
    Get-Content `$HOME\.ssh\id_ed25519.pub | ssh $BastionUser@$BastionHost "mkdir -p ~/.ssh; chmod 700 ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"
"@
}

$ProxyCommand = 'ssh -W %h:%p -o BatchMode=yes ' + ($SshOpts -join ' ') + " $BastionUser@$BastionHost"

if ($Command) {
    & ssh @SshOpts '-o' "ProxyCommand=$ProxyCommand" $Target @Command
} else {
    & ssh @SshOpts '-o' "ProxyCommand=$ProxyCommand" $Target
}
exit $LASTEXITCODE
