---
invention_name: "smart-clipboard"
invention_type: "software"
category: "cli-tool"
language: "python"
complexity: "simple"
estimated_iterations: 12
created: "2026-01-11"
status: "example"
---

# Smart Clipboard Manager

## The Problem (Pain Point)

**Current situation:**
When you copy multiple things (links, text snippets, code), you lose previous items. The clipboard only holds one thing at a time, so you have to constantly switch between windows to copy-paste-copy-paste.

**Who experiences this:**
Developers, writers, researchers - anyone who copies/pastes frequently

**Why existing solutions fail:**
- Clipboard managers exist but are often GUI-heavy
- Not programmable/scriptable
- Don't integrate with terminal workflows
- Overkill for simple "save a few things" use case

---

## Your Solution

**High-level concept:**
A CLI tool that maintains a clipboard history and lets you quickly access previous items.

**How it works:**
- Monitors clipboard automatically
- Saves history to a file
- Provides commands to list, select, and paste from history
- Simple, fast, terminal-native

**What makes it novel:**
Dead-simple CLI interface, no GUI bloat, designed for terminal users who want clipboard history in their workflow.

---

## Key Features

1. **Auto-save:** Automatically captures everything you copy
2. **Quick access:** List history with `clipboard list`
3. **Easy paste:** Copy item back with `clipboard get 3`
4. **Search:** Find items with `clipboard search "keyword"`

---

## User Experience

**How someone uses this:**

1. User copies text normally (Cmd+C or Ctrl+C)
2. Clipboard tool saves it automatically
3. Later, user runs `clipboard list` to see history
4. User runs `clipboard get 2` to copy item #2 back to clipboard
5. User pastes normally (Cmd+V or Ctrl+V)

**Example session:**
\`\`\`bash
# Copy a few things normally...
# Then:
$ clipboard list
1. https://github.com/anthropics/claude-code
2. def hello_world():
3. Fix the authentication bug

$ clipboard get 2
# Now "def hello_world():" is back in clipboard

$ clipboard search "github"
1. https://github.com/anthropics/claude-code
\`\`\`

---

## Technical Implementation

### Tech Stack
- Language: Python 3.9+
- Framework: Click (for CLI) or argparse
- Dependencies: pyperclip (clipboard access)
- Storage: JSON file (~/.clipboard_history.json)

### Architecture
\`\`\`
┌─────────────────┐
│  User copies    │ (Cmd+C)
│  something      │
└────────┬────────┘
         │
         v
┌─────────────────┐
│  Clipboard      │ (pyperclip watches)
│  Watcher        │
└────────┬────────┘
         │
         v
┌─────────────────┐
│  History File   │ (~/.clipboard_history.json)
│  [item1, item2] │
└────────┬────────┘
         │
         v
┌─────────────────┐
│  CLI Commands   │ (list, get, search)
│  clipboard get  │
└─────────────────┘
\`\`\`

### Data Model
\`\`\`json
{
  "history": [
    {
      "id": 1,
      "content": "copied text",
      "timestamp": "2026-01-11T22:00:00Z",
      "preview": "copied text..."
    }
  ],
  "max_items": 100
}
\`\`\`

---

## Build Plan

### Phase 1: Project Setup & Foundation

**Step 1: Initialize Project**
\`\`\`bash
mkdir smart-clipboard
cd smart-clipboard
python3 -m venv venv
source venv/bin/activate
pip install pyperclip click
touch clipboard.py
\`\`\`
**Verify:** Virtual environment active, dependencies installed, can import pyperclip

**Step 2: Core Data Structure**
- Action: Create HistoryManager class to handle JSON storage
- Why: Need persistent storage of clipboard items
- Code structure:
  \`\`\`python
  class HistoryManager:
      def __init__(self, file_path):
          self.file_path = file_path
      def add_item(self, content):
          pass  # Add to history
      def get_items(self):
          pass  # Return all items
      def get_item(self, index):
          pass  # Return specific item
  \`\`\`
- Verify: Can create instance, add item, retrieve items
- Expected: JSON file created, data persists between runs

### Phase 2: Core Functionality

**Step 3: Clipboard Monitoring**
- Action: Implement function to monitor clipboard changes
- Why: Auto-save requires detecting when user copies
- Code:
  \`\`\`python
  import pyperclip
  import time

  def monitor_clipboard(history_manager):
      previous = ""
      while True:
          current = pyperclip.paste()
          if current != previous:
              history_manager.add_item(current)
              previous = current
          time.sleep(0.5)  # Check every 500ms
  \`\`\`
- Verify: Copy something, check if it appears in JSON file
- Expected: New clipboard items automatically saved

**Step 4: History Retrieval**
- Action: Implement functions to list and retrieve history
- Why: Users need to access saved items
- Code:
  \`\`\`python
  def list_history(history_manager):
      items = history_manager.get_items()
      for i, item in enumerate(items, 1):
          preview = item['content'][:50]
          print(f"{i}. {preview}")

  def get_item(history_manager, index):
      item = history_manager.get_item(index)
      pyperclip.copy(item['content'])
  \`\`\`
- Verify: Can list items, can copy item back to clipboard
- Expected: Commands show history and restore items

### Phase 3: Interface & Integration

**Step 5: CLI Interface**
- Action: Create command-line interface with Click
- Why: Users need simple commands to interact
- Code:
  \`\`\`python
  import click

  @click.group()
  def cli():
      pass

  @cli.command()
  def list():
      """List clipboard history"""
      # Implementation

  @cli.command()
  @click.argument('index', type=int)
  def get(index):
      """Get item from history"""
      # Implementation

  @cli.command()
  @click.argument('query')
  def search(query):
      """Search clipboard history"""
      # Implementation
  \`\`\`
- Verify: Can run `python clipboard.py list`, `python clipboard.py get 1`
- Expected: Commands work as expected

**Step 6: Search Functionality**
- Action: Add search through history
- Why: Find specific items without scrolling
- Code:
  \`\`\`python
  def search_history(history_manager, query):
      items = history_manager.get_items()
      matches = [item for item in items if query.lower() in item['content'].lower()]
      return matches
  \`\`\`
- Verify: Search for keyword, only matching items shown
- Expected: Accurate search results

### Phase 4: Testing & Polish

**Step 7: Make it Executable**
- Action: Add shebang, make executable, optionally add to PATH
- Code:
  \`\`\`bash
  # Add to top of clipboard.py:
  #!/usr/bin/env python3

  # Make executable:
  chmod +x clipboard.py

  # Optional: symlink to /usr/local/bin
  ln -s $(pwd)/clipboard.py /usr/local/bin/clipboard
  \`\`\`
- Verify: Can run `clipboard list` from anywhere
- Expected: Command available globally

**Step 8: Error Handling & Edge Cases**
- Action: Add error handling for:
  - Empty clipboard
  - Invalid index
  - Corrupted JSON file
  - Missing dependencies
- Why: Make it robust
- Verify: Test edge cases, see graceful errors
- Expected: No crashes, helpful error messages

**Step 9: Create README**
- Action: Write README.md with:
  - Installation instructions
  - Usage examples
  - Available commands
- Why: Anyone should be able to use it
- Verify: Follow README from scratch
- Expected: Clear, complete documentation

---

## Testing Scenarios

### Test Case 1: Basic Usage
- Actions:
  1. Copy "Hello World"
  2. Copy "Second item"
  3. Run `clipboard list`
  4. Run `clipboard get 1`
- Expected Output:
  - List shows both items
  - Get 1 copies "Hello World" to clipboard
- Actual: [Filled by Rube Goldberg]

### Test Case 2: Search
- Actions:
  1. Copy several items including "github.com/repo"
  2. Run `clipboard search "github"`
- Expected Output: Only items containing "github" shown
- Actual: [Filled by Rube Goldberg]

### Test Case 3: Edge Case - Empty History
- Actions:
  1. Delete history file
  2. Run `clipboard list`
- Expected Output: "No clipboard history" or similar message
- Actual: [Filled by Rube Goldberg]

### Test Case 4: Large Items
- Actions:
  1. Copy very long text (>1000 chars)
  2. Run `clipboard list`
- Expected Output: Shows truncated preview
- Actual: [Filled by Rube Goldberg]

---

## Success Criteria

The invention is complete when ALL of these are true:

- [ ] Clipboard monitoring works (auto-saves copied items)
- [ ] `clipboard list` shows history with previews
- [ ] `clipboard get <n>` copies item back to clipboard
- [ ] `clipboard search <query>` finds matching items
- [ ] History persists across runs (JSON file)
- [ ] Error handling works (graceful failures)
- [ ] README exists with clear usage instructions
- [ ] Tool is executable from terminal
- [ ] All test cases pass

**When ALL criteria met, output:**
\`\`\`
<promise>INVENTION COMPLETE: smart-clipboard</promise>
\`\`\`

---

## Rube Goldberg Iteration Log

*Rube Goldberg will document attempts here:*

### Iteration 1
- Attempted: Project setup
- Succeeded: Created structure, installed dependencies
- Failed: N/A
- Lessons learned: Environment ready

---

## Notes & Ideas

Future enhancements:
- Background daemon mode (run continuously)
- Max history size limit
- Export history to file
- Sync across devices?

---

## Next Steps After Completion

1. Test the tool daily for a week
2. Identify common use patterns
3. Consider: Package for easy installation?
4. Decide: Ship it or iterate further?
