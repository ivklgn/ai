---
name: review-and-release
description: Sync README with current agents/skills, validate plugin conventions, bump version, and commit. Use when the user says "/review-and-release" or wants to prepare a release after adding, removing, or changing agents or skills.
model: sonnet
---

# Review and Release

Synchronize README.md with the current set of agents and skills, validate files follow plugin conventions, bump the patch version, and create a release commit.

## Step 1: Inventory Agents and Skills

Scan the filesystem to build the current state.

**Agents:**
```bash
ls claude/agents/*.md
```

For each `.md` file, read the YAML frontmatter and extract `name` and `description`. Condense each description into a short README-style summary (under ~90 characters), matching the style of existing entries.

**Skills:**
```bash
ls claude/skills/*/SKILL.md
```

For each `SKILL.md`, read the YAML frontmatter and extract `name` and `description`. Condense each description into a short README-style summary.

Store both inventories for use in subsequent steps.

## Step 2: Diff Against README

Read `README.md` and parse:

1. **Description line** — extract agent and skill counts from pattern: `Claude Code plugin with N specialized subagents and M skills.`
2. **Agents table** — extract all rows from the `## Agents` table
3. **Skills table** — extract all rows from the `## Skills` table
4. **Structure section** — extract the counts from the tree display: `# Subagents (N)` and `# Skills (M)`

Compare the filesystem inventory against README and classify:

- **Added** — in filesystem but not in README table
- **Removed** — in README table but not in filesystem
- **Description changed** — present in both but description no longer matches
- **Unchanged** — matches

If zero differences across agents and skills, report "README is already in sync" and skip to Step 3.

## Step 3: Validate Plugin Conventions

Check all agent and skill files against these rules:

### Agent files (`claude/agents/*.md`)

1. Frontmatter present — starts with `---` and has closing `---`
2. Required fields — `name`, `description`, `tools`, `model` all present
3. Name matches filename — `name` field equals filename without `.md`
4. Model value — one of: `haiku`, `sonnet`, `opus`, `inherit`
5. Description is non-empty
6. Meaningful markdown body after frontmatter

### Skill files (`claude/skills/*/SKILL.md`)

1. Frontmatter present — starts with `---` and has closing `---`
2. Required fields — `name` and `description` present. Either `model` or `disable-model-invocation: true` must exist.
3. Name matches directory — `name` field equals parent directory name
4. Model value (if present) — one of: `haiku`, `sonnet`, `opus`
5. Description is non-empty
6. Meaningful markdown body after frontmatter

### Plugin metadata (`claude/.claude-plugin/plugin.json`)

1. Valid JSON
2. Required fields — `name`, `description`, `version` present
3. Version matches semver `X.Y.Z`

If any issues found, present them as a numbered list with file paths and **stop**. Do not proceed until issues are fixed.

## Step 4: Apply README Updates

If Step 2 found differences, update `README.md` using the Edit tool:

1. **Description line** — update counts: `Claude Code plugin with {agent_count} specialized subagents and {skill_count} skills.`

2. **Agents table** — rebuild the full table sorted alphabetically by name:
   ```
   | [agent-name](claude/agents/agent-name.md) | Short description |
   ```

3. **Skills table** — rebuild the full table sorted alphabetically by name:
   ```
   | [skill-name](claude/skills/skill-name/SKILL.md) | Short description |
   ```

4. **Structure section** — update counts in the tree:
   ```
   ├── agents/                     # Subagents ({agent_count})
   └── skills/                     # Skills ({skill_count})
   ```

## Step 5: Bump Version

Read `claude/.claude-plugin/plugin.json`, increment the patch version (e.g., `2.0.2` → `2.0.3`), and update the file using the Edit tool.

## Step 6: Present Summary

Before committing, show a clear summary:

```
## Release Summary

**Version:** X.Y.Z → X.Y.Z+1

**README changes:**
- Added agents: ...
- Removed agents: ...
- Updated descriptions: ...
- Added skills: ...
- Removed skills: ...
- Counts updated: N → M agents, P → Q skills

**Validation:** All agents and skills pass convention checks.

**Files to commit:**
- README.md
- claude/.claude-plugin/plugin.json
```

Only show sections with actual changes.

## Step 7: Commit

Stage and commit only the modified files:

```bash
git add README.md claude/.claude-plugin/plugin.json
```

Commit with message format:

```
release: vX.Y.Z

- Updated README (added N agents, removed M agents, ...)
- Bumped version to X.Y.Z
```

Do NOT use `git add -A` or `git add .`. After committing, run `git status` to confirm clean state and report the commit hash.
