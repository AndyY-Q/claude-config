---
name: retro
description: >-
  Session learning loop — turn what went wrong (or what worked) this session into a durable
  rule so the same mistake is not repeated. Use at the end of a session, after a bug/incident
  was diagnosed, when the user says "remember this" / "don't do that again" / "let's do a
  retro" / "distill the lessons", or any time a correction surfaced that future sessions
  should inherit. Routes each lesson to the right altitude (cross-project global memory vs a
  single project's AGENTS.md / ADR) and prunes as it writes so the memory files stay thin
  instead of rotting. Project-agnostic; works in any repo.
---

# Retro — failure → durable rule

The point of this loop: the model does not get smarter between sessions, but the *context it
inherits* can. Each session that ends with a fresh correction left only in the chat is a lesson
lost. This skill converts that correction into a rule the next session reads for free.

Run it deliberately, not on every stop. A retro is worth doing when something was *learned* —
a trap was hit, an assumption was wrong, a convention was discovered, a fix revealed a rule.
Routine successful work needs no retro; its commit message is the record.

## The loop

**1. Gather.** From this session, list the concrete lessons worth keeping. Each must be:
- *Durable* — true beyond this one task (not "fixed the typo on line 40").
- *Non-obvious* — not already derivable from the code, git history, or an existing rule.
- *Actionable* — phrased as a rule a future agent can follow, with the **why**.

Discard anything that fails these three. Most raw observations should be discarded — a short,
high-signal list beats an exhaustive one.

**2. Judge altitude.** For each surviving lesson, decide where it belongs. This is the core
step — wrong altitude is how memory files rot.

| Lesson is true for… | Goes to | Form |
|---|---|---|
| Every project / the machine / the user's style | global `~/.claude/CLAUDE.md` | one tight line |
| One project, operational/convention | that project's `AGENTS.md` | one line under the right heading |
| One project, a binding engineering decision | that project's `docs/decisions/` ADR | dated ADR + index line (follow the repo's ADR convention) |
| One project, but it's really *personal* (your role, prefs, feedback) | global auto-memory (`~/.claude/projects/<slug>/memory/`) | a memory file + MEMORY.md pointer |

When unsure between global and project: **default to project.** Global is expensive — it loads
into every session of every repo, so the bar for it is "would I want this in front of me while
working on an unrelated project?" If no, it's project-level.

**3. Dedupe before writing.** Open the target file. Search for an existing rule that already
covers this. If one exists: sharpen or correct it in place — do **not** append a near-duplicate.
A `[[link]]` or cross-reference to a related rule is better than restating it.

**4. Write.** Add the rule at the right altitude, matching the file's existing voice and
structure. Keep it to the shortest form that carries the *why* — a rule without its reason rots
into cargo-cult and gets ignored or wrongly reversed.
- ADRs are binding: never reverse one by inference. If a lesson contradicts an existing ADR,
  surface it to the user and write a *superseding* ADR rather than quietly diverging.

**5. Prune (mandatory — this is what stops the loop from becoming the rot it prevents).**
Before finishing, scan the file you just touched:
- Delete rules that are now stale, contradicted, or were proven wrong.
- Merge rules that have drifted into overlap.
- If a file has grown long enough that the signal is diluted, say so and propose a consolidation
  pass (the `consolidate-memory` skill covers the global-memory side of this).

Append-only is failure. A retro that only adds is half a retro.

## Output

End with a 3-line summary: what was learned, where each lesson landed (file + altitude), and
what was pruned. Then stop — don't re-narrate the session.
