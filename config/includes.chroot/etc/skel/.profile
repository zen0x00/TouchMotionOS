# TouchMotion live user profile
export EDITOR=nano
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

if [ -z "${WAYLAND_DISPLAY:-}" ] && [ -z "${DISPLAY:-}" ] && [ "${TOUCHMOTION_KIOSK_STARTED:-0}" != "1" ] && [ "$(tty 2>/dev/null)" = "/dev/tty1" ]; then
    mkdir -p "$HOME/.local/state"
    printf '%s .profile tty1 hook\n' "$(date -u +%FT%TZ)" >> "$HOME/.local/state/touchmotion-kiosk.log"
    export TOUCHMOTION_KIOSK_STARTED=1
    /usr/local/bin/touchmotion-login-start
fi
