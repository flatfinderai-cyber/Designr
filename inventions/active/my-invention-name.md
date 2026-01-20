---
invention_name: "my-invention-name"
invention_type: "software"
category: "cli-tool"
language: "python"
complexity: "simple"
estimated_iterations: 15
created: "2026-01-11"
status: "planning"
---

# my-invention-name

## The Problem (Pain Point)

**Current situation:**
[Describe what's broken, inefficient, or frustrating]

**Who experiences this:**
[Who has this problem? Developers? You? Everyone?]

**Why existing solutions fail:**
[What's wrong with current tools/approaches?]

---

## Your Solution

**High-level concept:**
[One sentence: What does your invention do?]

**How it works:**
[Explain the core mechanism]

**What makes it novel:**
[Why is this better/different?]

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

**Example:**
```bash
# Show a concrete example of using it
my-tool command --option
# Output: Expected result
```

---

## Technical Implementation

### Tech Stack
- Language: python
- Framework: [e.g., Flask, Click, etc.]
- Dependencies: [Key libraries needed]
- Storage: [Files? Database? JSON?]

### Architecture
```
[Describe how components connect]

Example:
User Input → Processing Logic → Storage → Output
```

---

## Build Plan

### Phase 1: Project Setup & Foundation

**Step 1: Initialize Project**
```bash
mkdir my-invention-name
cd my-invention-name
python3 -m venv venv
source venv/bin/activate
touch main.py
```
**Verify:** Virtual environment active, main.py exists
**Expected:** No errors

**Step 2: Core Data Structure**
- Action: Define how data is stored
- Why: Foundation for all functionality
- Code structure:
  ```python
  # Example structure
  class DataManager:
      def __init__(self):
          pass
      def save(self, data):
          pass
      def load(self):
          pass
  ```
- Verify: Can create instance, basic operations work
- Expected: Data persists between runs

### Phase 2: Core Functionality

**Step 3: Main Feature Implementation**
- Action: [Build the core feature]
- Why: [This solves the main problem]
- What to build:
  ```python
  # Describe what code to write
  def main_feature():
      # Implementation details
      pass
  ```
- Verify: [How to test it works]
- Expected: [What successful output looks like]

**Step 4: Processing Logic**
- Action: [Implement the algorithm/logic]
- Why: [This is how it actually works]
- Verify: [Test with sample data]
- Expected: [Correct results]

### Phase 3: Interface & Integration

**Step 5: User Interface**
- Action: [Build CLI/UI/API]
- Why: [Users need to interact with it]
- What to create:
  ```python
  # Command line interface or API endpoints
  if __name__ == "__main__":
      # Implementation
  ```
- Verify: [Can interact with tool]
- Expected: [Commands work as expected]

**Step 6: Error Handling**
- Action: [Add validation and error messages]
- Why: [Make it robust]
- Verify: [Test edge cases]
- Expected: [Graceful error handling]

### Phase 4: Testing & Polish

**Step 7: Integration Testing**
- Action: [Test complete workflows]
- Why: [Ensure everything works together]
- Verify: [Run through full scenarios]
- Expected: [All features work end-to-end]

**Step 8: Documentation**
- Action: [Create README with usage examples]
- Why: [You/others need to know how to use it]
- Verify: [README is clear and complete]
- Expected: [Someone can use it from README alone]

---

## Testing Scenarios

### Test Case 1: [Basic Functionality]
- Input: [Sample input]
- Expected Output: [What should happen]
- Actual: [Rube Goldberg fills this during testing]

### Test Case 2: [Edge Case]
- Input: [Unusual input]
- Expected Output: [How it should handle it]
- Actual: [Rube Goldberg fills this during testing]

### Test Case 3: [Error Handling]
- Input: [Invalid input]
- Expected Output: [Error message/handling]
- Actual: [Rube Goldberg fills this during testing]

---

## Success Criteria

The invention is complete when ALL of these are true:

- [ ] Core functionality implemented and working
- [ ] User can interact with it (CLI/UI/API)
- [ ] Error handling works properly
- [ ] All test cases pass
- [ ] Code is documented
- [ ] README exists with usage instructions
- [ ] Tool is executable/runnable
- [ ] Demonstrable prototype works end-to-end

**When ALL criteria met, output:**
```
<promise>INVENTION COMPLETE: my-invention-name</promise>
```

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
3. Decide: Ship it, iterate, or move to next invention?
