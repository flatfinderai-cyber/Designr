# Invention Template

Use this template to document and automate building your inventions.

---

## Invention Metadata

```yaml
---
invention_name: "Your Invention Name"
invention_type: "software/hardware/hybrid"
category: "automation/tool/device/system"
complexity: "simple/medium/complex"
estimated_iterations: 15
---
```

## The Problem

What problem does this invention solve?

**Current situation:**
- What's broken or inefficient?
- Why do existing solutions fail?

**Your solution:**
- How does your invention solve it?
- What makes it better/different?

---

## The Invention

### High-Level Description
Describe your invention in 2-3 sentences.

### Key Features
1. Feature 1
2. Feature 2
3. Feature 3

### How It Works
Explain the core mechanism/principle.

---

## Build Plan

### Prerequisites
- Tools needed
- Materials needed (for hardware)
- Software needed
- Knowledge/skills required

### Build Steps

#### Phase 1: Foundation
**Step 1: [First Step Name]**
- Action: What to do
- Why: Why this step matters
- Verify: How to check it worked
- Expected result: What you should see

**Step 2: [Next Step Name]**
- Action: What to do
- Why: Why this step matters
- Verify: How to check it worked
- Expected result: What you should see

#### Phase 2: Core Implementation
**Step 3: [Build Core Feature]**
- Action: What to do
- Why: Why this step matters
- Verify: How to check it worked
- Expected result: What you should see

#### Phase 3: Integration & Testing
**Step 4: [Integration]**
- Action: What to do
- Why: Why this step matters
- Verify: How to check it worked
- Expected result: What you should see

**Step 5: [Testing]**
- Action: What to do
- Why: Why this step matters
- Verify: How to check it worked
- Expected result: What you should see

---

## Testing & Validation

### Test Cases
1. **Test 1:** [What to test]
   - Expected: [What should happen]
   - Actual: [What actually happened - filled by Rube Goldberg]

2. **Test 2:** [What to test]
   - Expected: [What should happen]
   - Actual: [What actually happened - filled by Rube Goldberg]

### Success Criteria

The invention is complete when:
- [ ] Core functionality works
- [ ] All tests pass
- [ ] Performance meets requirements
- [ ] Documentation is complete
- [ ] Prototype is demonstrable

---

## Iteration Notes

*Rube Goldberg will document iterations here:*

### Iteration 1
- What was attempted:
- What worked:
- What failed:
- Fixes applied:

### Iteration 2
- What was attempted:
- What worked:
- What failed:
- Fixes applied:

---

## Completion

When ALL success criteria are met, output:

```
<promise>INVENTION COMPLETE: [Invention Name]</promise>
```

**IMPORTANT:** Only output this when the invention ACTUALLY WORKS!

---

## Usage with Rube Goldberg

1. Fill out this template completely
2. Be specific about build steps and verification
3. Define clear success criteria
4. Start Rube Goldberg loop with:
   ```bash
   ./inventions/scripts/start-invention.sh [invention-name]
   ```
5. Rube Goldberg will build, test, iterate until complete
6. Review the working prototype!
