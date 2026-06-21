---
name: design-direction
description: >-
  Visual design craft for any project with a UI/marketing surface — use when starting a new
  design (page, section, hero, deck, component) and the visual direction is open, when the user
  asks for design options/directions, or when a design brief is vague enough that committing
  straight to one execution would be guessing. Grounds every design in the project's own brand
  contract (DESIGN.md), offers three distinct directions before building when direction is
  unclear, and works in a junior-designer style that exposes assumptions before delivering.
  Project-agnostic craft; the brand itself lives in each project's DESIGN.md.
---

# Design direction

Craft layer for visual work. It does not carry any brand — it reads the brand from the project
and applies a disciplined process on top. Two mechanisms: **three-direction advisor** (for when
direction is open) and **junior-designer workflow** (always).

## Step 0 — load the brand contract (always, before anything visual)

Read the current project's `DESIGN.md`. It is the binding brand contract: palette, type,
voice, the do/don't list, and motion/ADR constraints. If it's missing, say so and offer to draft
one from the project's `globals.css` / theme tokens before designing — don't invent a brand.

Also honor the project's constraints that live outside DESIGN.md: animation-library rules,
imagery ADRs, and the public-vs-authenticated-surface distinction. A quiet internal/workbench
surface is **not** a place for the three-direction showcase below — there, consistency with the
existing system wins; skip straight to executing within the established components.

## Mechanism 1 — three-direction advisor (when direction is open)

If the brief is vague or the user hasn't locked a direction, do **not** commit to one execution.
Generate three genuinely distinct directions, each derived from a *different* logical frame so
they don't collapse into the same idea with three accent colors:

- **Direction A — brand-orthodox:** the most disciplined reading of the project's own DESIGN.md.
  The safe, on-system answer.
- **Direction B — reference-led:** anchored to a specific, named class of award-winning work
  appropriate to the surface (cite the reference class, e.g. "editorial-serif product sites
  like Linear/Stripe docs"). Pull a concrete move from it.
- **Direction C — concept-led:** driven by the *content's* idea — a metaphor or principle from
  what this page is actually about — not from a visual trend.

For each: one tight paragraph (the idea + why it fits), the key type/color/layout move, and the
main tradeoff. Recommend one. Then stop and let the user pick — build only after they choose.

Vary the directions by what the surface needs; don't mechanically force three if one is clearly
right and the user just wants it built. State that and proceed.

## Mechanism 2 — junior-designer workflow (always)

Work like a junior designer reporting to a sharp art director — visible reasoning, not a black box:
- Surface assumptions up front ("assuming desktop-first, real product copy not lorem, …").
- Mark placeholders explicitly where real content/assets are missing.
- When you make a non-obvious design call, say why in one clause.
- Deliver, then point at the 1–2 spots most worth a second look rather than declaring it perfect.

## Verify before claiming done

Design is visual — type-checking proves nothing about whether it *looks* right. For previewable
work, run it and look (screenshot / preview) before reporting success, and check the brand
contract's do/don't list against what you built. If you can't view it, say so explicitly.
