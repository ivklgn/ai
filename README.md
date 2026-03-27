# ivklgn

Claude Code plugin with 22 specialized subagents and 3 skills.

## Installation

```bash
# Add the marketplace
/plugin marketplace add ivklgn/ai

# Install the plugin
/plugin install ivklgn
```

Or via `settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "ivklgn-ai": {
      "source": {
        "source": "github",
        "repo": "ivklgn/ai"
      }
    }
  },
  "enabledPlugins": {
    "ivklgn@ivklgn-ai": true
  }
}
```

Local development:

```bash
claude --plugin-dir ./claude
```

## Uninstall

```bash
# Local scope (current project)
claude plugin uninstall ivklgn --scope local

# Project scope
claude plugin uninstall ivklgn --scope project

# User scope (global)
claude plugin uninstall ivklgn --scope user
```

## Agents

| Agent | Description |
| --- | --- |
| [business-analyst](claude/agents/business-analyst.md) | Requirements analysis, user stories, feature specs, and product documentation |
| [cli-developer](claude/agents/cli-developer.md) | CLI tools and terminal applications with cross-platform support and shell completions |
| [css-developer](claude/agents/css-developer.md) | CSS/SCSS specialist for layout, responsive design, animations, theming, and modern CSS features |
| [deployment-engineer](claude/agents/deployment-engineer.md) | CI/CD pipeline design, deployment strategies (blue-green, canary), and GitOps workflows |
| [documentation-developer](claude/agents/documentation-developer.md) | Documentation sites with Astro Starlight, Docusaurus, VitePress, and SEO optimization |
| [frontend-figma-layout-designer](claude/agents/frontend-figma-layout-designer.md) | Convert raw Figma HTML/CSS exports into clean, production-ready React components |
| [golang-pro](claude/agents/golang-pro.md) | High-performance Go systems, concurrent programming, microservices, and idiomatic patterns |
| [instantdb-expert](claude/agents/instantdb-expert.md) | InstantDB realtime database: code generation, reviews, optimizations, and type-safe patterns |
| [js-perf-analyzer](claude/agents/js-perf-analyzer.md) | JS/TS performance analysis: memory leaks, CPU bottlenecks, event loop stalls, V8 internals, and bundle size |
| [llm-architect](claude/agents/llm-architect.md) | LLM systems architecture: inference serving, RAG pipelines, fine-tuning, and multi-model orchestration |
| [mcp-developer](claude/agents/mcp-developer.md) | MCP server and client development for connecting AI systems to external tools and data |
| [npm-updater](claude/agents/npm-updater.md) | Check for package updates, analyze changelogs, run security audits, and create update reports |
| [platform-engineer](claude/agents/platform-engineer.md) | Internal developer platforms, self-service infrastructure, Backstage portals, and golden paths |
| [playwright-e2e](claude/agents/playwright-e2e.md) | Playwright E2E testing: write, review, debug, and optimize tests and page objects |
| [postgres-pro](claude/agents/postgres-pro.md) | PostgreSQL expert for relational database design, normalization, ER modeling, and correctness-focused performance |
| [prompt-engineer](claude/agents/prompt-engineer.md) | Prompt design, optimization, A/B testing, and production prompt management |
| [react-code-optimizer](claude/agents/react-code-optimizer.md) | React performance analysis: fix re-renders, eliminate duplicates, optimize component splitting |
| [react-specialist](claude/agents/react-specialist.md) | React 18+ development with hooks, server components, and production-ready architectures |
| [reatom-guru](claude/agents/reatom-guru.md) | React with Reatom state manager: write, review, and refactor using best practices |
| [security-auditor](claude/agents/security-auditor.md) | Security auditing, vulnerability assessment, OWASP compliance, and threat modeling |
| [security-engineer](claude/agents/security-engineer.md) | DevSecOps automation, zero-trust architecture, compliance programs, and vulnerability management |
| [typescript-pro](claude/agents/typescript-pro.md) | Advanced TypeScript development with full type system mastery, strict mode, generics, and build optimization |

## Skills

| Skill | Description |
| --- | --- |
| [load-branch-changes](claude/skills/load-branch-changes/SKILL.md) | Load current branch changes (diff, commits, changed files) into session context |
| [reset-permissions](claude/skills/reset-permissions/SKILL.md) | Reset accumulated permissions in .claude/settings.local.json (full or keep read-only) |
| [review-go](claude/skills/review-go/SKILL.md) | Go code review on git-changed files using golang-pro agent with Context7 docs |

## Structure

```
├── marketplace.json                # Plugin marketplace manifest
└── claude/
    ├── .claude-plugin/plugin.json  # Plugin metadata
    ├── agents/                     # Subagents (22)
    └── skills/                     # Skills (3)
```
