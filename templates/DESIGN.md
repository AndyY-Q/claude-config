# <Project> — design contract

Binding brand contract for visual work. The `design-direction` skill reads this first. Tokens
live in `<path/to/globals.css or theme>`; this file is the *intent* behind them. When they
disagree, the CSS wins and this file should be corrected.

> TEMPLATE — replace every `<…>` placeholder, then delete this note. Fastest path: open this repo
> in Claude Code and say "fill in DESIGN.md from our tokens" — `design-direction` reads the real
> globals.css / theme and drafts accurate values instead of these stubs.

## Surfaces

<Describe any split — e.g. public marketing (expressive, allowed to move) vs authenticated app
(quiet, utilitarian, performance-first). If the whole app is one register, say so. A move that's
right in one surface is usually wrong in the other.>

## Palette (use tokens, not raw hex)

- `<--token>` `<#hex>` — <role>
- … 
- Name the ONE accent reserved for CTA/highlight, and anything reserved as a secondary/technical
  voice. Keep them from blurring into "two accents".

## Type

- **Sans — `<family>`** (`<--font-sans>`): <usage>
- **Serif / display — `<family>`**: <usage, or "none">
- **Mono — `<family>`**: <usage>

## Voice

<2–3 sentences: what the brand should feel like, and the one thread that ties it together.>

## Constraints (these outrank any design idea)

<Animation-library rules, imagery / SEO ADRs, accessibility (honor prefers-reduced-motion), the
public-vs-internal boundary — anything in AGENTS.md / docs/decisions that design must not violate.
Never reverse an ADR by inference; surface the conflict instead.>

## Do / don't

- Do reuse existing component / class helpers before inventing new CSS.
- Do honor `prefers-reduced-motion` on any new motion.
- Don't <misuse the accent / add a third type family / introduce a new accent hue / …>.
- Don't claim a visual change works without viewing it (typecheck / lint don't see pixels).

## Process

For open-ended direction use the `design-direction` three-direction advisor. For quiet / internal
surfaces, skip it and extend the established system. <Point to a strategy skill if the project has
one.>
