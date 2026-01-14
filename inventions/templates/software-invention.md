# Software Invention Template

For apps, tools, scripts, automations, and digital inventions.

---

## Invention Metadata

```yaml
---
invention_name: ""
invention_type: "software"
category: "web-app/cli-tool/automation/extension/api/library"
language: "javascript/python/typescript/go/other"
complexity: "simple/medium/complex"
estimated_iterations: 10
---
```

## The Problem

**What inefficiency/problem does this solve?**

**Who needs this?**

**Why doesn't a solution already exist?**

---

## The Invention

### What It Does
One-sentence description.

### Key Features
1.
2.
3.

### User Flow
How someone uses this invention:
1. User does X
2. Invention responds with Y
3. Result is Z

---

## Technical Design

### Tech Stack
- Language:
- Framework:
- Dependencies:
- Hosting/Deployment:

### Architecture
```
[Describe the structure - e.g., frontend/backend, modules, data flow]
```

### Data Model
```
[If relevant - databases, data structures, APIs]
```

---

## Build Plan

### Phase 1: Project Setup
```bash
# Initialize project
# Install dependencies
# Set up basic structure
```

**Verify:** Project runs without errors

### Phase 2: Core Feature
```
# Build the main functionality
# Implement core algorithm/logic
```

**Verify:** Core feature works with test data

### Phase 3: User Interface
```
# Build UI/CLI/API interface
# Add input validation
```

**Verify:** Users can interact with it

### Phase 4: Testing & Polish
```
# Add error handling
# Write tests
# Add documentation
```

**Verify:** All tests pass, documentation exists

---

## Testing

### Manual Tests
1. **Test:** [Action to perform]
   - Expected: [Result]

2. **Test:** [Action to perform]
   - Expected: [Result]

### Automated Tests
```bash
# Commands to run tests
npm test
# or
pytest
```

---

## Success Criteria

- [ ] Core functionality implemented
- [ ] User can interact with it
- [ ] Error handling works
- [ ] Tests pass
- [ ] Basic documentation exists
- [ ] Demonstrable prototype

**When complete, output:**
```
<promise>SOFTWARE INVENTION COMPLETE: [Name]</promise>
```

---

## Example: Smart File Organizer

```yaml
---
invention_name: "Smart File Organizer"
invention_type: "software"
category: "automation"
language: "python"
complexity: "simple"
estimated_iterations: 8
---
```

### Problem
Downloads folder is always messy. Files pile up unsorted.

### Solution
CLI tool that automatically organizes files by type/date.

### Build Plan

**Phase 1: Setup**
```bash
mkdir smart-file-organizer
cd smart-file-organizer
python -m venv venv
source venv/bin/activate
touch organizer.py
```

**Phase 2: Core Logic**
```python
# organizer.py
import os
import shutil
from pathlib import Path

def organize_files(directory):
    # Get file extension
    # Create folders by type
    # Move files to appropriate folders
    pass
```

**Phase 3: CLI Interface**
```bash
# Make it runnable
chmod +x organizer.py
# Add command-line arguments
```

**Phase 4: Test**
```bash
# Create test files
# Run organizer
# Verify files moved correctly
```

### Success:
Files organized automatically ✅
