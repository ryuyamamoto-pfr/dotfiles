# config.fish

# ROS 2 argument completion
if command -v register-python-argcomplete > /dev/null
    register-python-argcomplete --shell fish ros2 | source
end

# --- ROS 2 Setup Function ---
# Usage: rosset [ID] (e.g., rosset 31) / rosset (for local)
function rosset
    if test -z "$argv[1]"
        echo "🔄 Setting ROS 2 to LOCAL mode (Domain: 0)"
        set -gx ROS_DOMAIN_ID 0
        set -gx RMW_IMPLEMENTATION rmw_zenoh_cpp
        set -e ROS_STATIC_PEERS
        set -e ZENOH_CONFIG_OVERRIDE
    else
        set -l ID $argv[1]
        set -l TARGET_HOST "sr$ID.local"

        set -gx ROS_DOMAIN_ID $ID
        set -gx RMW_IMPLEMENTATION rmw_zenoh_cpp
        set -gx ROS_STATIC_PEERS "tcp/$TARGET_HOST:7447"
        set -gx ZENOH_CONFIG_OVERRIDE "mode=\"client\";connect/endpoints=[\"tcp/$TARGET_HOST:7447\"]"

        echo "🤖 Connected to Robot: $TARGET_HOST"
        echo "📌 ROS_DOMAIN_ID: $ROS_DOMAIN_ID"
        echo "🔗 Peer: $ROS_STATIC_PEERS"
    end
end

if status is-interactive
    rosset
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
