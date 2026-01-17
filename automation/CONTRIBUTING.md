# Contributing to Designr Automation System

Thank you for your interest in improving the automation system! This guide will help you contribute effectively.

---

## Ways to Contribute

### 1. Add Example Workflows
Share your automation workflows in `workflows/` directory.

**Example:** `workflows/docker-setup.md`

### 2. Improve Documentation
- Fix typos or unclear instructions
- Add examples to HOW-TO-USE.md
- Update QUICK-REFERENCE.md with new tips

### 3. Create Helper Scripts
Add scripts to `scripts/` that help with common tasks.

### 4. Report Issues
Found a bug? File an issue with:
- Description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your environment (OS, tool versions)

### 5. Suggest Improvements
Have ideas for new features? Open an issue describing:
- The problem you're trying to solve
- Your proposed solution
- Any alternatives you considered

---

## Workflow File Guidelines

When contributing workflow files:

### ✅ DO:
- Use clear, descriptive step names
- Include verification commands for each step
- Add success criteria at the end
- Test the workflow before submitting
- Use the template in `templates/setup-template.md`

### ❌ DON'T:
- Skip verification steps
- Use vague success criteria
- Include secrets or credentials
- Assume specific system configurations

### Template Structure:

```markdown
---
tool_name: "Tool Name"
purpose: "Brief description"
platform: "macos|linux|windows|all"
---

# Tool Setup

## Step 1: [Action]
[Commands or instructions]
Verify: [Verification command]

## Step 2: [Action]
[Commands or instructions]
Verify: [Verification command]

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

Output <promise>SETUP COMPLETE</promise> when all criteria met.
```

---

## Script Guidelines

When contributing helper scripts:

### Requirements:
- Use bash for portability
- Add `set -e` at the top for error handling
- Include usage documentation in comments
- Make scripts executable (`chmod +x`)
- Test on multiple platforms if possible

### Template:

```bash
#!/bin/bash
set -e

# Script Name - Brief Description
# Usage: ./script-name.sh [options]

# Your code here
```

---

## Documentation Guidelines

### Style:
- Use clear, simple language
- Provide examples for every concept
- Include code blocks with syntax highlighting
- Use emoji sparingly for visual markers (✅ ❌ 🚀 📖)

### Format:
- Use markdown
- Keep lines under 100 characters when possible
- Use headers for organization
- Include a table of contents for long documents

---

## Submitting Changes

### 1. Fork the Repository
```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/Designr.git
cd Designr
```

### 2. Create a Branch
```bash
git checkout -b automation/your-feature-name
```

### 3. Make Your Changes
- Edit files in `automation/` directory
- Test your changes thoroughly
- Update relevant documentation

### 4. Commit Your Changes
```bash
git add automation/
git commit -m "automation: Add [feature/fix] description"
```

Use commit message prefixes:
- `automation: feat:` - New features
- `automation: fix:` - Bug fixes
- `automation: docs:` - Documentation changes
- `automation: chore:` - Maintenance tasks

### 5. Push and Create PR
```bash
git push origin automation/your-feature-name
```

Then create a Pull Request on GitHub with:
- Clear title describing the change
- Description of what changed and why
- Any testing you performed
- Screenshots if UI/output changed

---

## Testing Your Changes

### For Workflow Files:
1. Test with Ralph using your workflow
2. Verify all steps complete successfully
3. Test error handling (intentionally break something)
4. Document any platform-specific requirements

### For Scripts:
1. Test on your local system
2. Test with different inputs/flags
3. Verify error messages are helpful
4. Check script exits cleanly

### For Documentation:
1. Proofread carefully
2. Verify all links work
3. Test any code examples
4. Preview markdown rendering

---

## Code of Conduct

### Be Respectful
- Be kind and courteous
- Accept constructive criticism gracefully
- Focus on what's best for the community

### Be Collaborative
- Help others learn
- Share knowledge freely
- Give credit where due

### Be Professional
- Keep discussions on-topic
- Avoid personal attacks
- Report inappropriate behavior

---

## Questions?

- Check existing issues first
- Read the documentation thoroughly
- Ask in a new issue if needed

---

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

---

Thank you for contributing to make automation easier for everyone! 🚀
