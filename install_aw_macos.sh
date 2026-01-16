#!/usr/bin/env bash
set -e

# ================= CONFIG =================
AW_VERSION="v0.13.2"
SERVER_URL="https://activitywatch.invmarg.com"
INSTALL_DIR="$HOME/.activitywatch"
CONFIG_DIR="$HOME/.config/activitywatch"
HOSTNAME="$(scutil --get LocalHostName)"

# ================= DEPENDENCIAS =================
if ! command -v unzip &> /dev/null; then
    echo "Instalando unzip..."
    brew install unzip
fi
if ! command -v curl &> /dev/null; then
    echo "Instalando curl..."
    brew install curl
fi

# ================= DESCARGA =================
mkdir -p "$INSTALL_DIR"
cd /tmp
curl -L -o aw.zip "https://github.com/ActivityWatch/activitywatch/releases/download/$AW_VERSION/activitywatch-$AW_VERSION-macos-x86_64.zip"
unzip -o aw.zip
mv activitywatch/* "$INSTALL_DIR"

# ================= CONFIGURACIÓN =================
mkdir -p "$CONFIG_DIR"

# aw-server.toml
cat > "$CONFIG_DIR/aw-server.toml" <<EOF
[sync]
server = "$SERVER_URL"
hostname = "$HOSTNAME"
EOF

# aw-watcher-afk.toml
cat > "$CONFIG_DIR/aw-watcher-afk.toml" <<EOF
timeout = 300
poll_time = 5
EOF

# aw-watcher-window.toml
cat > "$CONFIG_DIR/aw-watcher-window.toml" <<EOF
poll_time = 5
exclude_title = true
strategy_macos = "swift"
EOF

# ================= SCRIPT DE ARRANQUE =================
STARTUP_SCRIPT="$INSTALL_DIR/start_aw.sh"
cat > "$STARTUP_SCRIPT" <<EOF
#!/usr/bin/env bash
# Lanza ActivityWatch en background
"$INSTALL_DIR/aw-server-rust/aw-server-rust" &
"$INSTALL_DIR/aw-watcher-afk/aw-watcher-afk" &
"$INSTALL_DIR/aw-watcher-window/aw-watcher-window" &
EOF
chmod +x "$STARTUP_SCRIPT"

# ================= AUTOSTART =================
PLIST="$HOME/Library/LaunchAgents/com.activitywatch.client.plist"
cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.activitywatch.client</string>
  <key>ProgramArguments</key>
  <array>
    <string>$STARTUP_SCRIPT</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
</dict>
</plist>
EOF

# Carga el LaunchAgent
launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"

echo "✅ ActivityWatch instalado y corriendo en macOS"
echo "    Watchers apuntando a: $SERVER_URL"
