# How to Use the Dev Tool Setup Automation System

## The Problem This Solves

You ask Claude Desktop: "Help me set up a Python data science environment"

Claude responds with 50 steps like:
```
1. First install Homebrew
2. Then install Python via pyenv
3. Configure virtual environments
4. Install Jupyter
5. Install pandas, numpy, matplotlib
... 45 more steps
```

**Instead of doing all that manually**, this system lets Ralph do it for you!

---

## Quick Start (3 Steps)

### Step 1: Create Your Setup File

Copy the template and describe what you want:

```bash
cp automation/templates/setup-template.md automation/workflows/my-setup.md
```

Edit `my-setup.md` and **paste the instructions Claude gave you**.

### Step 2: Start the Ralph Loop

Create `.claude/ralph-loop.local.md`:

```markdown
---
active: true
iteration: 1
max_iterations: 20
completion_promise: "SETUP COMPLETE"
started_at: "2026-01-11T22:00:00Z"
---

Execute ALL steps in automation/workflows/my-setup.md

Verify each step completed successfully before moving to the next.

If any step fails, debug and fix it before proceeding.

When ALL steps are complete and verified, output:
<promise>SETUP COMPLETE</promise>
```

### Step 3: Let Ralph Work

Ralph will:
- ✅ Read your setup instructions
- ✅ Execute each step in order
- ✅ Verify success
- ✅ Fix failures automatically
- ✅ Iterate until everything works
- ✅ Tell you when it's done

---

## Real-World Example

### Scenario: Claude Desktop Says...

```
To set up Docker and Kubernetes:
1. Download Docker Desktop
2. Install it
3. Configure resources (4GB RAM, 2 CPUs)
4. Install kubectl
5. Install minikube
6. Start minikube cluster
7. Verify with kubectl get nodes
... etc
```

### What You Do:

**1. Create `automation/workflows/docker-k8s-setup.md`:**

```markdown
---
tool_name: "Docker + Kubernetes"
purpose: "Container orchestration environment"
platform: "macos"
---

# Docker and Kubernetes Setup

## Step 1: Install Docker Desktop
- Download from docker.com
- Install the .dmg file
- Launch Docker Desktop
- Verify: `docker --version`

## Step 2: Configure Docker Resources
- Open Docker Desktop preferences
- Set Memory: 4GB
- Set CPUs: 2
- Click "Apply & Restart"

## Step 3: Install kubectl
```bash
brew install kubectl
kubectl version --client
```

## Step 4: Install minikube
```bash
brew install minikube
minikube version
```

## Step 5: Start Cluster
```bash
minikube start
kubectl get nodes
```

## Success: Output <promise>K8S READY</promise> when:
- [ ] Docker running
- [ ] kubectl installed
- [ ] minikube running
- [ ] `kubectl get nodes` shows Ready
```

**2. Create Ralph loop state (`.claude/ralph-loop.local.md`):**

```markdown
---
active: true
iteration: 1
max_iterations: 25
completion_promise: "K8S READY"
started_at: "2026-01-11T22:00:00Z"
---

Execute automation/workflows/docker-k8s-setup.md

Complete ALL steps and verify each one.
Fix any errors that occur.
Output <promise>K8S READY</promise> only when everything works.
```

**3. Watch Ralph work!**

Ralph will execute everything, handle errors, and tell you when it's done.

---

## Advanced: Converting Claude's Instructions

### When Claude gives you instructions:

1. **Copy them into a workflow file**
2. **Add verification commands** after each step
3. **Define success criteria** at the end
4. **Set a completion promise**
5. **Let Ralph execute**

### Template for Converting:

```markdown
# [TOOL NAME] Setup

## [Claude's Step 1]
[Command or action]
Verify: [How to check it worked]

## [Claude's Step 2]
[Command or action]
Verify: [How to check it worked]

... etc ...

## Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

Output <promise>SETUP COMPLETE</promise> when all criteria met.
```

---

## Tips for Success

### ✅ DO:
- **Be specific** about verification commands
- **Set realistic max_iterations** (15-30 for complex setups)
- **Define clear success criteria**
- **Use completion promises** to prevent infinite loops

### ❌ DON'T:
- Leave verification steps vague
- Set max_iterations too low (Ralph might not finish)
- Forget the completion promise (Ralph runs forever!)
- Mix multiple unrelated setups in one workflow

---

## Monitoring Progress

While Ralph is working:

```bash
# Check current iteration
grep '^iteration:' .claude/ralph-loop.local.md

# See what Ralph is working on
tail -20 .claude/ralph-loop.local.md

# Cancel if needed
/cancel-ralph
```

---

## Common Workflows Included

Check `automation/workflows/` for examples:
- `example-nodejs-setup.md` - Complete Node.js environment
- More coming soon!

You can use these as templates for your own setups.

---

## What Makes This Powerful

**Traditional Way:**
1. Read step 1
2. Execute it manually
3. Check if it worked
4. If failed, Google the error
5. Try again
6. Repeat for 50 steps
⏰ **Time: 2-3 hours**

**Ralph Way:**
1. Paste instructions into a file
2. Start Ralph loop
3. Go get coffee ☕
4. Come back to completed setup
⏰ **Time: 5 minutes of your time**

---

## Your First Automation

**Try this RIGHT NOW:**

Next time Claude Desktop gives you setup instructions:
1. Create a file in `automation/workflows/`
2. Paste the instructions
3. Add verification steps
4. Start a Ralph loop
5. Let Ralph handle it!

**You'll never manually execute long setup instructions again!**
