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
| `bootstrap-repo.ps1` | One-shot: give a *new* project repo its design content (AGENTS.md pointer + DESIGN.md template). The loop needs nothing per-repo. |
| `templates/DESIGN.md` | Fill-in brand-contract template used by `bootstrap-repo.ps1`. |

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

## Adding to a new project repo

The **mechanism is already global** — once `install.ps1` has run on a machine, `retro` and
`design-direction` work in every repo there. A new repo only ever needs *content*, and only if it
has a design surface:

- **The loop / retro:** nothing to do. AGENTS.md is its sink (created on demand); the global
  CLAUDE.md rule drives capture. Backend/no-UI repos need nothing at all.
- **Design:** the repo needs a `DESIGN.md` (its brand) + a one-line AGENTS.md pointer.

Best path — let the skill author an accurate contract from the repo's real tokens:

> Open the repo in Claude Code and say *"set up the design contract for this repo"*.
> `design-direction` reads `globals.css` / the theme and drafts a tokenized `DESIGN.md`.

Offline / scriptable path — stamp the pointer + a template to fill in later:

```powershell
# from the claude-config repo:
powershell -ExecutionPolicy Bypass -File .\bootstrap-repo.ps1 -RepoPath D:\my-new-app
# backend repo with no UI — skip the DESIGN.md (or just don't run this at all):
powershell -File .\bootstrap-repo.ps1 -RepoPath D:\api-only -NoDesignFile
```

Both are idempotent. Then commit `DESIGN.md` + `AGENTS.md` in *that* repo — it travels with the
project's own GitHub history, not this one.

## Security

Secrets are never in this repo. `.credentials.json`, tokens, and `settings.json` are git-ignored.
On a new machine you re-authenticate locally with the `claude` CLI — nothing sensitive syncs
through GitHub.
