# claude-config

Portable Claude Code global setup — the **mechanism layer** that should follow me to every
machine. Per-project *content* (each repo's `DESIGN.md`, `AGENTS.md`, ADRs) already travels with
that project's own repo; this repo carries the cross-project brain that otherwise lives only in
`~/.claude/` and would be lost on a new device.

## What's in here

| Path | What it is |
|---|---|
| `skills/retro/` | Session learning loop — distil a real correction into a durable rule at the right altitude, and prune. Available in every repo. |
| `skills/design-direction/` | Visual-design craft (three-direction advisor + junior-designer workflow). Reads each project's own `DESIGN.md` for the brand. |
| `CLAUDE.md` | Global user instructions, incl. the proactive "carry lessons across sessions" rule (the no-hook half of the loop). |
| `output-styles/baby-fable-5.md` | The Baby Fable 5 output style. |
| `settings.sample.json` | Reference for the two prefs that select the output style. The real `settings.json` is git-ignored (machine-local, may gain secrets). |
| `install.ps1` | Symlinks the above into `~/.claude/` (copy fallback) and selects the output style. |

## New machine setup

```powershell
git clone git@github.com:AndyY-Q/claude-config.git
cd claude-config
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Then clone your project repos as usual. Start a fresh Claude Code session to load the skills and
style. Full restore = **this repo (global brain) + your project repos (local content)**.

`install.ps1` symlinks by default so this repo stays the single source of truth — edits made via
`~/.claude/...` write straight back here; commit and push to sync to your other machines. (On a
host without symlink privilege it copies instead, and you'd re-run it after pulling updates.)

## Security

Secrets are never in this repo. `.credentials.json`, tokens, and `settings.json` are git-ignored.
On a new machine you re-authenticate locally with the `claude` CLI — nothing sensitive syncs
through GitHub.
