# Global user memory

<!--
2026-06-13: "Baby Fable 5" now ships as an OUTPUT STYLE, not via CLAUDE.md imports.
  - Style file: ~/.claude/output-styles/baby-fable-5.md  (keep-coding-instructions: false)
  - Activated by: "outputStyle": "baby-fable-5" in ~/.claude/settings.json
This replaces Claude Code's persona/behavior layer with the claude.ai "Claude Fable 5"
prompt, while the harness still injects the REAL environment (Windows, opus-4-8, real
cwd, today's date), tool registration, and safety guardrails. Applies to every new
session, all projects, both CLI and Desktop.

The earlier CLAUDE.md imports of CC-SYS-PROMPT-FULL.md and CLAUDE-FABLE-5.md were
removed on purpose, to avoid double-loading the persona and re-injecting the CC
capture's stale cloud/Linux environment. Those files still exist on disk if wanted:
  ~/.claude/CC-SYS-PROMPT-FULL.md , ~/.claude/CLAUDE-FABLE-5.md

To turn Baby Fable 5 OFF: set "outputStyle" back to "Default" (or remove the line) in
~/.claude/settings.json, then start a new session (or run /output-style Default).
-->

# Carrying lessons across sessions

When a session produces a durable, non-obvious lesson — you were corrected on something, hit a
trap a future session would repeat, or found a genuinely better approach worth standardizing —
capture it immediately as ONE line at the right altitude: this file if it's cross-project; the
project's `AGENTS.md` (or a dated ADR under `docs/decisions/` if the project uses them) if it's
local. Then move on. Don't wait to be asked, don't run a full reflective pass, don't capture
routine successful work. If nothing was learned, write nothing. Sharpen or replace an existing
rule rather than appending a near-duplicate — keep these files high-signal. For a deliberate
end-of-session sweep, invoke the `retro` skill (it does the heavier, pruning version on request).
