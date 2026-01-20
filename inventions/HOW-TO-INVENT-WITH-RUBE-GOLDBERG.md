# How to Build Your Inventions with Rube Goldberg

## For Inventors: Turn Ideas Into Reality Faster

### The Problem You Have

You're an inventor with 100+ ideas. For each one:
- You have to manually prototype
- Debug problems as they arise
- Iterate through failures
- Spend hours/days per invention

**It's slow. It's tedious. You could be inventing more instead.**

---

## The Solution: Rube Goldberg Does the Iteration For You

### What Rube Goldberg Does

1. **Reads** your invention specification
2. **Builds** the prototype step-by-step
3. **Tests** each component
4. **Debugs** failures automatically
5. **Iterates** until it works
6. **Documents** what it learned

### Your New Invention Process

```
Old Way: Idea → Manual build → Debug → Test → Fix → Repeat (2-10 hours)

New Way: Idea → Document spec → Start Rube Goldberg → Get coffee → Review prototype (30 mins)
```

---

## Step-by-Step: Your First Automated Invention

### Step 1: Choose an Invention

Pick one from your 100+ ideas. Start with something **software-based** for best results:
- A tool/script
- An automation
- A web app
- A data processor
- An API

### Step 2: Document It

```bash
./inventions/scripts/new-invention.sh my-invention-name
```

This creates a file in `inventions/active/my-invention-name.md`

Edit it and fill in:
- **What problem it solves**
- **How it works (high-level)**
- **Build steps (specific)**
- **How to verify it works**
- **Success criteria**

### Step 3: Be Specific About Build Steps

**Bad (too vague):**
```
Step 1: Build the main feature
```

**Good (specific and verifiable):**
```
Step 1: Create file processor
- Action: Write function that reads CSV files
- Code:
  def read_csv(filepath):
      # implementation
- Verify: Test with sample.csv, should return dict
- Expected: No errors, data loaded correctly
```

### Step 4: Start Rube Goldberg

```bash
./inventions/scripts/start-invention.sh my-invention-name
```

Rube Goldberg will:
1. Read your spec
2. Start building
3. Test each step
4. Fix failures
5. Iterate until done

### Step 5: Monitor Progress

```bash
# Check which iteration Rube Goldberg is on
grep '^iteration:' .claude/rube-goldberg-loop.local.md

# See what Rube Goldberg is working on
tail -50 .claude/rube-goldberg-loop.local.md
```

### Step 6: Review the Prototype

When Rube Goldberg outputs `<promise>INVENTION COMPLETE</promise>`:
- Check the code/implementation
- Test it yourself
- Iterate further if needed

---

## Real Example: Automated Invoice Generator

### The Idea (30 seconds)
"I want a tool that generates professional invoices from a simple text file."

### Document It (5 minutes)

```yaml
---
invention_name: "Invoice Generator"
invention_type: "software"
category: "cli-tool"
language: "python"
---
```

**Problem:** Creating invoices is tedious

**Solution:** CLI tool: input simple data, output professional PDF

**Build Steps:**
1. Create Python script
2. Add CSV input parser
3. Implement PDF generation (use reportlab)
4. Add invoice template
5. Test with sample data

**Success:** `python invoice-gen.py data.csv` creates invoice.pdf

### Start Rube Goldberg (1 minute)

```bash
./inventions/scripts/start-invention.sh invoice-generator
```

### Rube Goldberg Works (15-30 iterations)

```
Iteration 1: Create project structure ✓
Iteration 2: Install dependencies ✓
Iteration 3: Write CSV parser ✓
Iteration 4: Add PDF generation ✗ (error: module not found)
Iteration 5: Fix imports, retry ✓
Iteration 6: Create invoice template ✓
Iteration 7: Test with sample data ✗ (formatting issue)
Iteration 8: Fix formatting ✓
Iteration 9: Verify output PDF ✓
Iteration 10: <promise>INVENTION COMPLETE: Invoice Generator</promise>
```

### You Review (5 minutes)

Working prototype ready to use! ✅

**Total time: ~20 minutes** (instead of 3-5 hours manually)

---

## Tips for Success

### ✅ DO:

1. **Start with software inventions** - Rube Goldberg excels at code
2. **Be specific** in your build steps
3. **Add verification** after each step
4. **Set realistic max_iterations** (15-30 for complex inventions)
5. **Use clear success criteria**
6. **Document edge cases** you want tested

### ❌ DON'T:

1. **Be vague** - "build the thing" won't work
2. **Skip verification steps** - Rube Goldberg needs to know what success looks like
3. **Set iterations too low** - Complex inventions need time
4. **Forget the completion promise** - Rube Goldberg will loop forever
5. **Try to build hardware** - Rube Goldberg can write code, not physically build things

---

## What Types of Inventions Work Best?

### ✅ Great for Rube Goldberg:

- **Software tools** (CLI apps, scripts)
- **Web applications** (frontend + backend)
- **APIs and integrations**
- **Data processors**
- **Automation scripts**
- **Browser extensions**
- **Mobile apps** (code only, not design)

### 🔧 Hybrid (Rube Goldberg handles software part):

- **Arduino/Raspberry Pi code**
- **IoT device programming**
- **Robot control software**
- **Hardware simulation**
- **CAD automation scripts**

### ❌ Not suitable:

- **Pure hardware** (Rube Goldberg can't 3D print or solder)
- **Physical prototypes** (can't manipulate real objects)
- **Designs requiring human creativity** (Rube Goldberg follows instructions)

---

## Scaling to 100+ Inventions

### The System

```
inventions/
├── ideas/              # Quick notes for future inventions
├── active/             # Currently building (5-10 at a time)
├── completed/          # Finished prototypes
└── templates/          # Reusable invention templates
```

### Workflow

1. **Capture ideas** quickly in `ideas/`
2. **Prioritize** - move best ideas to `active/`
3. **Use Rube Goldberg** to build 3-5 simultaneously
4. **Review** completed prototypes
5. **Iterate** on the most promising ones

### Build Multiple Inventions in Parallel

Rube Goldberg can handle multiple projects:

```bash
# Start 3 inventions at once
./start-invention.sh invention-1
# In a new terminal:
./start-invention.sh invention-2
# In another terminal:
./start-invention.sh invention-3
```

Each runs independently!

---

## Advanced: Creating Invention Templates

For inventions you build often, create reusable templates:

```bash
# Create a template
cp inventions/active/successful-invention.md \
   inventions/templates/my-template.md

# Use it for new inventions
cp inventions/templates/my-template.md \
   inventions/active/new-invention.md
```

---

## Measuring Success

### Before Rube Goldberg:
- **1-2 inventions per week** (manually built)
- **High frustration** from debugging
- **Many abandoned** due to complexity

### With Rube Goldberg:
- **5-10 prototypes per week** (automated)
- **Low frustration** (Rube Goldberg handles debugging)
- **Higher completion rate** (iteration is automated)

---

## Next Steps

1. **Pick your simplest software invention**
2. **Document it** using the template
3. **Start Rube Goldberg** and see it work
4. **Scale up** to more complex inventions

**You're about to 10x your invention output.** 🚀

---

## Questions?

- **Can Rube Goldberg build hardware?** No, but it can write the control software
- **What if my invention is complex?** Break it into phases, increase max_iterations
- **Can I pause and resume?** Yes! Rube Goldberg state is saved in files
- **What if Rube Goldberg gets stuck?** Increase iterations or clarify the stuck step

---

**Ready to automate your inventions?**

```bash
./inventions/scripts/new-invention.sh my-first-automated-invention
```
