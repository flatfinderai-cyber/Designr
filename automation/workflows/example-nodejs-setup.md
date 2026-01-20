# Node.js Development Environment Setup

This is an example workflow showing how to set up a complete Node.js development environment.

---

## SETUP INSTRUCTIONS FOR RUBE_GOLDBERG

**OBJECTIVE**: Set up a complete Node.js development environment with all necessary tools.

### Step 1: Install Node.js via nvm (Node Version Manager)

1. Check if nvm is already installed:
   ```bash
   command -v nvm
   ```

2. If not installed, install nvm:
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   ```

3. Load nvm:
   ```bash
   export NVM_DIR="$HOME/.nvm"
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
   ```

4. Install Node.js LTS:
   ```bash
   nvm install --lts
   nvm use --lts
   ```

5. Verify installation:
   ```bash
   node --version
   npm --version
   ```

### Step 2: Install Essential Global Packages

```bash
npm install -g typescript
npm install -g ts-node
npm install -g nodemon
npm install -g pnpm
```

### Step 3: Verify All Tools

Run these verification commands:

```bash
node --version     # Should output v18.x.x or higher
npm --version      # Should output 9.x.x or higher
tsc --version      # Should output TypeScript version
ts-node --version  # Should output ts-node version
nodemon --version  # Should output nodemon version
pnpm --version     # Should output pnpm version
```

### Step 4: Create Test Project

```bash
mkdir -p ~/test-node-setup
cd ~/test-node-setup
npm init -y
npm install express
```

Create a test file `index.js`:
```javascript
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Setup successful!'));
console.log('Node.js environment is ready!');
```

Run it:
```bash
node index.js
```

### Success Criteria

Output this completion promise ONLY when ALL of the following are true:
- [ ] `node --version` outputs v18 or higher
- [ ] `npm --version` works
- [ ] `tsc --version` works (TypeScript installed)
- [ ] `ts-node --version` works
- [ ] `nodemon --version` works
- [ ] `pnpm --version` works
- [ ] Test project created successfully
- [ ] `node index.js` runs without errors

When ALL criteria are met, output:
<promise>NODE.JS ENVIRONMENT READY</promise>

---

## How to Run This Setup

Use Rube Goldberg to execute this:

```bash
# Create the Rube Goldberg loop state
cat > .claude/rube-goldberg-loop.local.md << 'EOF'
---
active: true
iteration: 1
max_iterations: 15
completion_promise: "NODE.JS ENVIRONMENT READY"
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
---

Execute the setup instructions in automation/workflows/example-nodejs-setup.md
EOF
```

Then Rube Goldberg will:
1. Read the instructions
2. Execute each step
3. Verify success
4. Fix any failures
5. Iterate until complete
