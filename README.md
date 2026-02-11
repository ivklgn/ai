# AI Tools

Personal collection of AI tools and configurations.

## Claude

Custom subagents for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

### Subagents

Subagents are specialized AI assistants that Claude Code can delegate tasks to. Each operates in its own context, preventing pollution of the main conversation. See [official docs](https://docs.anthropic.com/en/docs/claude-code/sub-agents).

| Agent                                                                             | Description                                                                                                  |
| --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| [business-analyst](claude/agents/business-analyst.md)                             | Requirements analysis, user stories, feature specs, and product documentation                                |
| [css-developer](claude/agents/css-developer.md)                                   | CSS/SCSS specialist for layout, responsive design, animations, theming, and modern CSS features              |
| [frontend-figma-layout-designer](claude/agents/frontend-figma-layout-designer.md) | Convert raw Figma HTML/CSS exports into clean, production-ready React components                             |
| [golang-pro](claude/agents/golang-pro.md)                                         | High-performance Go systems, concurrent programming, microservices, and idiomatic patterns                   |
| [instantdb-expert](claude/agents/instantdb-expert.md)                             | InstantDB realtime database: code generation, reviews, optimizations, and type-safe patterns                 |
| [js-perf-analyzer](claude/agents/js-perf-analyzer.md)                             | JS/TS performance analysis: memory leaks, CPU bottlenecks, event loop stalls, V8 internals, and bundle size |
| [npm-updater](claude/agents/npm-updater.md)                                       | Check for package updates, analyze changelogs, run security audits, and create update reports                |
| [playwright-e2e](claude/agents/playwright-e2e.md)                                 | Playwright E2E testing: write, review, debug, and optimize tests and page objects                            |
| [postgres-pro](claude/agents/postgres-pro.md)                                     | PostgreSQL administration, query optimization, replication, and high availability                            |
| [react-code-optimizer](claude/agents/react-code-optimizer.md)                     | React performance analysis: fix re-renders, eliminate duplicates, optimize component splitting               |
| [react-specialist](claude/agents/react-specialist.md)                             | React 18+ development with hooks, server components, and production-ready architectures                      |
| [reatom-guru](claude/agents/reatom-guru.md)                                       | React with Reatom state manager: write, review, and refactor using best practices                            |
| [typescript-pro](claude/agents/typescript-pro.md)                                 | Advanced TypeScript development with full type system mastery, strict mode, generics, and build optimization |

### Installation

```bash
# Remote (from any machine)
curl -fsSL https://raw.githubusercontent.com/ivklgn/ai/main/claude/install.sh | bash -s -- [OPTIONS] [AGENTS...]

# Local (from cloned repo)
./claude/install.sh [OPTIONS] [AGENTS...]
```

**Options:**

| Flag                 | Description                             |
| -------------------- | --------------------------------------- |
| `-g, --global`       | Install to `~/.claude/agents` (default) |
| `-p, --project PATH` | Install to `PATH/.claude/agents`        |
| `-l, --link`         | Symlink files (local mode only)         |
| `-c, --copy`         | Copy files                              |
| `-a, --all`          | Install all agents                      |
| `-L, --list`         | List available agents                   |

**Examples:**

```bash
# All agents globally
curl -fsSL https://raw.githubusercontent.com/ivklgn/ai/main/claude/install.sh | bash -s -- --all

# Specific agents to current project
curl -fsSL https://raw.githubusercontent.com/ivklgn/ai/main/claude/install.sh | bash -s -- -p . typescript-pro golang-pro
```
