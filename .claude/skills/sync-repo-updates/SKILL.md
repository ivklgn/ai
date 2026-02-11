---
name: sync-repo-updates
description: "Synchronize README.md and install.sh after adding, removing, or renaming subagents. Use this skill automatically after creating a new subagent (claude/agents/*.md), removing an existing one, or renaming one. Also invoke via /sync-repo-updates manually."
---

# Sync Repo Updates

After any subagent is added, removed, or renamed, update the registry files to stay in sync.

## Steps

1. **Scan agents directory** — Glob `claude/agents/*.md` to get the current list of agent files.

2. **Read each new/changed agent file** — Extract `name` and `description` from YAML frontmatter.

3. **Update README.md** — The agents table in `README.md` must:
   - Contain a row for every agent in `claude/agents/`
   - Be sorted alphabetically by agent name
   - Follow the existing column format exactly:
     ```
     | [agent-name](claude/agents/agent-name.md) | Short description |
     ```
   - All rows must be padded to align with the header separator widths

4. **Update install.sh** — The `KNOWN_AGENTS` array in `claude/install.sh` must:
   - Contain every agent name (filename without `.md`)
   - Be sorted alphabetically
   - One entry per line, indented with 4 spaces, quoted: `    "agent-name"`

5. **Verify** — After editing, read both files and confirm:
   - The agent count in README table matches the file count in `claude/agents/`
   - The agent count in `KNOWN_AGENTS` matches the file count
   - Table alignment has no issues (all pipes align)
