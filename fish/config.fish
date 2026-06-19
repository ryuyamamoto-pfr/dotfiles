# config.fish

fish_add_path --global ~/.local/bin

# ROS 2 argument completion
if command -v register-python-argcomplete > /dev/null
    register-python-argcomplete --shell fish ros2 | source
end

# --- ROS 2 Setup Function ---
# Usage:
#   rosset                              (local mode)
#   rosset <ID>                         (e.g., rosset 31           -> sr31.local:7447)
#   rosset <ID>:<PORT>                  (e.g., rosset 31:8447      -> sr31.local:8447)
#   rosset <IP> [ID]                    (e.g., rosset 192.168.1.100 31)
#   rosset <IP>:<PORT> [ID]             (e.g., rosset 192.168.1.100:8447 31)
function rosset
    if test -z "$argv[1]"
        echo "🔄 Setting ROS 2 to LOCAL mode (Domain: 0)"
        set -gx ROS_DOMAIN_ID 0
        set -gx RMW_IMPLEMENTATION rmw_zenoh_cpp
        set -e ROS_STATIC_PEERS
        set -gx ZENOH_CONFIG_OVERRIDE
    else
        set -l INPUT $argv[1]
        set -l DEFAULT_PORT 7447

        # 末尾の :PORT を分離（あれば）
        set -l PORT $DEFAULT_PORT
        set -l HOST_OR_ID $INPUT
        if string match -rq '^(?<h>.+):(?<p>\d+)$' $INPUT
            set HOST_OR_ID $h
            set PORT $p
        end

        # IPアドレス形式かどうかを判定
        set -l TARGET_HOST
        set -l ID
        if string match -rq '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$' $HOST_OR_ID
            # IPアドレスの場合: ドメインIDはargv[2]があればそれを使い、なければ0
            set TARGET_HOST $HOST_OR_ID
            set ID 0
            if test -n "$argv[2]"
                set ID $argv[2]
            end
        else
            # 数値IDの場合（従来動作）
            set ID $HOST_OR_ID
            set TARGET_HOST "sr$ID.local"
        end

        set -gx ROS_DOMAIN_ID $ID
        set -gx RMW_IMPLEMENTATION rmw_zenoh_cpp
        set -gx ROS_STATIC_PEERS "tcp/$TARGET_HOST:$PORT"
        set -gx ZENOH_CONFIG_OVERRIDE "mode=\"client\";connect/endpoints=[\"tcp/$TARGET_HOST:$PORT\"]"

        echo "🤖 Connected to Robot: $TARGET_HOST:$PORT"
        echo "📌 ROS_DOMAIN_ID: $ROS_DOMAIN_ID"
        echo "🔗 Peer: $ROS_STATIC_PEERS"
    end
end

if status is-interactive
    rosset
end

# ROS2/zenoh setup
if test -f $HOME/workspace/ros2_ws/install/setup.bash
    bass source $HOME/workspace/ros2_ws/install/setup.bash
end

# Configure Jump
status --is-interactive; and source (jump shell fish | psub)

# Fish syntax highlighting
set -g fish_color_autosuggestion '555' 'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow' '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow' '--background=brblack'
set -g fish_color_selection 'white' '--bold' '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# Install Starship
starship init fish | source

# Google Cloud SDK
if test -f '/home/pfr-ryu/Downloads/google-cloud-sdk/path.fish.inc'
    source '/home/pfr-ryu/Downloads/google-cloud-sdk/path.fish.inc'
end
