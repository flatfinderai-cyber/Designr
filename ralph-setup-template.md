# Ralph Loop Manual Setup Template

To manually set up a Ralph loop, create `.claude/ralph-loop.local.md`:

```markdown
---
active: true
iteration: 1
max_iterations: 10
completion_promise: "YOUR COMPLETION PHRASE"
started_at: "2026-01-11T22:00:00Z"
---

Your task description goes here. This is the prompt that will be repeated.
```

## Fields Explanation:

- **active**: `true` to enable the loop, `false` to disable
- **iteration**: Current iteration number (start at 1)
- **max_iterations**: Max iterations before stopping (0 = unlimited)
- **completion_promise**: The phrase to output in `<promise>` tags to complete
- **started_at**: ISO timestamp when loop started

## Example for Adding a Feature:

```markdown
---
active: true
iteration: 1
max_iterations: 15
completion_promise: "USER AUTHENTICATION COMPLETE"
started_at: "2026-01-11T22:00:00Z"
---

Build a user authentication system with login, logout, and session management.
Output <promise>USER AUTHENTICATION COMPLETE</promise> when all tests pass.
```

## To Cancel:

Delete `.claude/ralph-loop.local.md` or run `/cancel-ralph`

## To Monitor:

```bash
# Check current iteration
grep '^iteration:' .claude/ralph-loop.local.md

# View full state
cat .claude/ralph-loop.local.md
```
