# AI Tools

Personal collection of AI tools and configurations.

## Claude

Custom subagents for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

### Installation

```bash
# Remote (from any machine)
curl -fsSL https://raw.githubusercontent.com/ivklgn/ai/main/claude/install.sh | bash -s -- [OPTIONS] [AGENTS...]

# Local (from cloned repo)
./claude/install.sh [OPTIONS] [AGENTS...]
```

**Options:**

| Flag | Description |
|------|-------------|
| `-g, --global` | Install to `~/.claude/agents` (default) |
| `-p, --project PATH` | Install to `PATH/.claude/agents` |
| `-l, --link` | Symlink files (local mode only) |
| `-c, --copy` | Copy files |
| `-a, --all` | Install all agents |
| `-L, --list` | List available agents |

**Examples:**

```bash
# All agents globally
curl -fsSL https://raw.githubusercontent.com/ivklgn/ai/main/claude/install.sh | bash -s -- --all

# Specific agents to current project
curl -fsSL https://raw.githubusercontent.com/ivklgn/ai/main/claude/install.sh | bash -s -- -p . typescript-pro golang-pro
```

### Subagents

Subagents are specialized AI assistants that Claude Code can delegate tasks to. Each operates in its own context, preventing pollution of the main conversation. See [official docs](https://docs.anthropic.com/en/docs/claude-code/sub-agents).

| Agent | Description |
|-------|-------------|
| [typescript-pro](claude/agents/typescript-pro.md) | Advanced TypeScript development with full type system mastery, strict mode, generics, and build optimization |
| [golang-pro](claude/agents/golang-pro.md) | High-performance Go systems, concurrent programming, microservices, and idiomatic patterns |
| [react-specialist](claude/agents/react-specialist.md) | React 18+ development with hooks, server components, and production-ready architectures |
| [react-code-optimizer](claude/agents/react-code-optimizer.md) | React performance analysis: fix re-renders, eliminate duplicates, optimize component splitting |
| [postgres-pro](claude/agents/postgres-pro.md) | PostgreSQL administration, query optimization, replication, and high availability |
| [business-analyst](claude/agents/business-analyst.md) | Requirements analysis, user stories, feature specs, and product documentation |
