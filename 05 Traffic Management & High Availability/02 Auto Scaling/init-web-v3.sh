#!/bin/bash
# install apache
dnf install -y httpd
# generate index.html
ZONE=$(curl -s http://169.254.169.254/latest/meta-data/zoneCode)
echo "[$(hostname)]-[Init-V3.0] on [Zone ${ZONE}]" > /var/www/html/index.html
# register service httpd & start
systemctl enable --now httpd
# deploy cpu load tool
cat > /usr/local/bin/cpuload.sh <<'EOF'
#!/bin/bash
set -uo pipefail

WORKERS="${1:-$(nproc)}"
DURATION="${2:-600}"
pids=()
trap 'kill "${pids[@]}" 2>/dev/null; wait 2>/dev/null' EXIT INT TERM

echo "load with ${WORKERS} worker(s) for ${DURATION}s (Total Cores: $(nproc))"

for ((i=0; i<WORKERS; i++)); do
  sha1sum /dev/zero &
  pids+=("$!")
done

sleep "$DURATION"
EOF
chmod +x /usr/local/bin/cpuload.sh
