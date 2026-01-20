#!/bin/bash
# Create a new invention specification

set -e

echo "🔬 New Digital Invention Creator"
echo ""

# Get invention details
read -p "Invention name (e.g., 'smart-email-filter'): " INVENTION_NAME
INVENTION_NAME=$(echo "$INVENTION_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

read -p "Type (web-app/cli-tool/api/automation/extension): " INVENTION_TYPE
read -p "Primary language (javascript/python/typescript/other): " LANGUAGE

# Create directory structure
mkdir -p inventions/active
mkdir -p inventions/ideas
mkdir -p inventions/completed

INVENTION_FILE="inventions/active/${INVENTION_NAME}.md"

echo ""
echo "📝 Creating invention specification: $INVENTION_FILE"

# Create the invention file
cat > "$INVENTION_FILE" << EOF
---
invention_name: "${INVENTION_NAME}"
invention_type: "software"
category: "${INVENTION_TYPE}"
language: "${LANGUAGE}"
complexity: "medium"
estimated_iterations: 15
created: "$(date -u +%Y-%m-%d)"
status: "planning"
---

# ${INVENTION_NAME}

## The Problem (Pain Point)

**Current situation:**
[Describe the inefficiency, frustration, or problem]

**Who experiences this:**
[Target users/audience]

**Why existing solutions fail:**
[What's missing in current tools/approaches]

---

## Your Solution

**High-level concept:**
[One-sentence description of your invention]

**How it works:**
[Explain the core mechanism/approach]

**What makes it novel:**
[Why this is a new/better solution]

---

## Key Features

1. **Feature 1:** [Description]
2. **Feature 2:** [Description]
3. **Feature 3:** [Description]

---

## User Experience

**How someone uses this:**
1. User does [X]
2. Invention does [Y]
3. Result is [Z]

---

## Technical Implementation

### Tech Stack
- Language: ${LANGUAGE}
- Framework: [e.g., Express, Flask, React]
- Dependencies: [Key libraries]
- Storage: [Database/files if needed]

### Architecture
\`\`\`
[Describe components and how they connect]
Example:
- Frontend (user input)
- Backend (processing logic)
- Storage (data persistence)
- Output (results display)
\`\`\`

---

## Build Plan

### Phase 1: Project Setup & Foundation

**Step 1: Initialize Project**
\`\`\`bash
mkdir ${INVENTION_NAME}
cd ${INVENTION_NAME}
# Add setup commands for ${LANGUAGE}
\`\`\`
**Verify:** Project structure created, dependencies installed

**Step 2: Core Data Structure**
- Action: Define the main data structures/models
- Why: Foundation for all functionality
- Verify: Data can be created and stored
- Expected: No errors, basic CRUD works

### Phase 2: Core Functionality

**Step 3: Main Feature Implementation**
- Action: [Build the core feature]
- Why: [This is the heart of the invention]
- Verify: [How to test it works]
- Expected: [What successful output looks like]

**Step 4: Processing Logic**
- Action: [Implement the algorithm/logic]
- Why: [This solves the core problem]
- Verify: [Test with sample data]
- Expected: [Correct output]

### Phase 3: Interface & Integration

**Step 5: User Interface**
- Action: [Build CLI/UI/API endpoints]
- Why: [Users need to interact with it]
- Verify: [Manual test of interaction]
- Expected: [User can input and see output]

**Step 6: Error Handling**
- Action: [Add validation and error messages]
- Why: [Make it robust]
- Verify: [Test edge cases]
- Expected: [Graceful handling of errors]

### Phase 4: Testing & Polish

**Step 7: Integration Testing**
- Action: [Test full user workflows]
- Why: [Ensure everything works together]
- Verify: [Run through complete scenarios]
- Expected: [All features work end-to-end]

**Step 8: Documentation**
- Action: [Create README and usage guide]
- Why: [You/others need to know how to use it]
- Verify: [Someone can use it from README alone]
- Expected: [Clear, complete documentation]

---

## Testing Scenarios

### Test Case 1: [Basic Functionality]
- Input: [Sample input]
- Expected Output: [What should happen]
- Actual: [Filled by Rube Goldberg during testing]

### Test Case 2: [Edge Case]
- Input: [Unusual input]
- Expected Output: [How it should handle it]
- Actual: [Filled by Rube Goldberg during testing]

### Test Case 3: [Error Handling]
- Input: [Invalid input]
- Expected Output: [Error message/handling]
- Actual: [Filled by Rube Goldberg during testing]

---

## Success Criteria

The invention is complete when ALL of these are true:

- [ ] Core functionality implemented and working
- [ ] User can interact with it (CLI/UI/API)
- [ ] Error handling works properly
- [ ] All test cases pass
- [ ] Code is documented
- [ ] README exists with usage instructions
- [ ] Demonstrable prototype works end-to-end

**When ALL criteria met, output:**
\`\`\`
<promise>INVENTION COMPLETE: ${INVENTION_NAME}</promise>
\`\`\`

**IMPORTANT:** Only output this when the invention ACTUALLY WORKS!

---

## Rube Goldberg Iteration Log

*Rube Goldberg will document attempts here:*

### Iteration 1
- Attempted:
- Succeeded:
- Failed:
- Lessons learned:

---

## Notes & Ideas

*Add notes as you think of improvements:*

-
-
-

---

## Next Steps After Completion

Once Rube Goldberg finishes:
1. Test the prototype yourself
2. Identify improvements
3. Consider: Is this viable for users?
4. Decide: Refine further or move to next invention?
EOF

echo "✅ Created: $INVENTION_FILE"
echo ""
echo "📋 Next steps:"
echo "   1. Edit the file and fill in your invention details"
echo "   2. Be specific about the problem and solution"
echo "   3. Detail the build steps clearly"
echo "   4. When ready: ./inventions/scripts/start-invention.sh ${INVENTION_NAME}"
echo ""
echo "💡 Tip: The more specific you are, the better Rube Goldberg can build it!"
