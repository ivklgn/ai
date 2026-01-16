#!/bin/bash
set -e

GITHUB_USER="ivklgn"
GITHUB_REPO="ai"
GITHUB_BRANCH="main"
GITHUB_RAW="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$GITHUB_BRANCH"
AGENTS_PATH="claude/agents"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" 2>/dev/null)" && pwd 2>/dev/null || echo "")"
if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/agents" ]; then
    LOCAL_MODE=true
    AGENTS_DIR="$SCRIPT_DIR/agents"
else
    LOCAL_MODE=false
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

KNOWN_AGENTS=(
    "business-analyst"
    "css-developer"
    "frontend-figma-layout-designer"
    "golang-pro"
    "instantdb-expert"
    "npm-updater"
    "playwright-e2e"
    "postgres-pro"
    "react-code-optimizer"
    "react-specialist"
    "reatom-guru"
    "typescript-pro"
)

usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [AGENTS...]

Install Claude Code agents globally or to a project.

Options:
    -g, --global          Install to ~/.claude/agents (default)
    -p, --project PATH    Install to PATH/.claude/agents
    -l, --link            Create symlinks (local mode only, default when local)
    -c, --copy            Copy/download files (default when remote)
    -a, --all             Install all agents
    -L, --list            List available agents
    -h, --help            Show this help

Remote usage (like npx):
    curl -fsSL $GITHUB_RAW/$AGENTS_PATH/../install.sh | bash -s -- --all
    curl -fsSL $GITHUB_RAW/$AGENTS_PATH/../install.sh | bash -s -- -p . typescript-pro

Examples:
    $(basename "$0") --global --all
    $(basename "$0") -g typescript-pro golang-pro
    $(basename "$0") -p ./myproject --all --copy
    $(basename "$0") -p . react-specialist

Available agents:
EOF
    list_agents
}

list_agents() {
    for agent in "${KNOWN_AGENTS[@]}"; do
        printf "    ${BLUE}%-25s${NC}\n" "$agent"
    done
}

fetch_agent() {
    local agent="$1"
    local dst="$2"

    if $LOCAL_MODE; then
        local src="$AGENTS_DIR/$agent.md"
        if [ ! -f "$src" ]; then
            return 1
        fi
        if [ "$MODE" = "link" ]; then
            ln -sf "$src" "$dst"
        else
            cp "$src" "$dst"
        fi
    else
        local url="$GITHUB_RAW/$AGENTS_PATH/$agent.md"
        if ! curl -fsSL "$url" -o "$dst" 2>/dev/null; then
            return 1
        fi
    fi
    return 0
}

MODE=""
SCOPE="global"
TARGET_DIR="$HOME/.claude/agents"
INSTALL_ALL=false
AGENTS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -g|--global)
            SCOPE="global"
            TARGET_DIR="$HOME/.claude/agents"
            shift
            ;;
        -p|--project)
            SCOPE="project"
            TARGET_DIR="$2/.claude/agents"
            shift 2
            ;;
        -l|--link)
            MODE="link"
            shift
            ;;
        -c|--copy)
            MODE="copy"
            shift
            ;;
        -a|--all)
            INSTALL_ALL=true
            shift
            ;;
        -L|--list)
            echo "Available agents:"
            list_agents
            exit 0
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        -*)
            echo -e "${RED}Unknown option: $1${NC}" >&2
            usage
            exit 1
            ;;
        *)
            AGENTS+=("$1")
            shift
            ;;
    esac
done

if [ -z "$MODE" ]; then
    if $LOCAL_MODE; then
        MODE="link"
    else
        MODE="copy"
    fi
fi

if ! $LOCAL_MODE && [ "$MODE" = "link" ]; then
    echo -e "${YELLOW}Warning: Symlinks not available in remote mode, using copy${NC}"
    MODE="copy"
fi

if $INSTALL_ALL; then
    AGENTS=("${KNOWN_AGENTS[@]}")
fi

if [ ${#AGENTS[@]} -eq 0 ]; then
    echo -e "${RED}Error: No agents specified. Use --all or list agent names.${NC}" >&2
    echo ""
    usage
    exit 1
fi

mkdir -p "$TARGET_DIR"

if $LOCAL_MODE; then
    echo -e "${BLUE}Mode:${NC} local ($MODE)"
else
    echo -e "${BLUE}Mode:${NC} remote (downloading from GitHub)"
fi
echo -e "${BLUE}Target:${NC} $TARGET_DIR"
echo ""

SUCCESS=0
FAILED=0

for agent in "${AGENTS[@]}"; do
    dst="$TARGET_DIR/$agent.md"

    [ -e "$dst" ] || [ -L "$dst" ] && rm -f "$dst"

    if fetch_agent "$agent" "$dst"; then
        if $LOCAL_MODE && [ "$MODE" = "link" ]; then
            echo -e "${GREEN}✓${NC} $agent ${YELLOW}(linked)${NC}"
        else
            echo -e "${GREEN}✓${NC} $agent ${YELLOW}(downloaded)${NC}"
        fi
        ((SUCCESS++))
    else
        echo -e "${RED}✗${NC} $agent ${RED}(not found)${NC}"
        ((FAILED++))
    fi
done

echo ""
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}Done!${NC} $SUCCESS agent(s) installed."
else
    echo -e "${YELLOW}Completed with errors:${NC} $SUCCESS installed, $FAILED failed."
fi
