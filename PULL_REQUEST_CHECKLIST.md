# Security & Quality Checklist For All PRs

This checklist ensures every change in DesignrTutorials stays secure and on track.

## Before Creating a PR - ALWAYS Check:

### 🔒 Security
- [ ] No passwords, API keys, or secrets in code
- [ ] No hardcoded credentials anywhere
- [ ] No suspicious external links
- [ ] No malicious code patterns
- [ ] All dependencies are reviewed (if any)

### 📝 Quality
- [ ] Code follows project standards
- [ ] All spelling and grammar correct
- [ ] Markdown formatting is clean
- [ ] No broken links
- [ ] Content is accurate

### 📂 Organization
- [ ] Files in correct folders
- [ ] README updated if needed
- [ ] Changes described clearly
- [ ] Git commit messages are meaningful

### 🧪 Testing
- [ ] Manually tested changes
- [ ] Links verified
- [ ] Examples work correctly
- [ ] Formatting renders properly

## Creating a PR - ALWAYS Do This:

1. **Create feature branch**
   ```bash
   git checkout -b feature/your-change-name
   ```

2. **Make your changes**
   - Add files to appropriate folders
   - Follow the structure

3. **Commit with clear message**
   ```bash
   git commit -m "type: description of change"
   ```
   Types: `docs`, `feat`, `fix`, `security`, `update`

4. **Push branch**
   ```bash
   git push -u origin feature/your-change-name
   ```

5. **Create PR on GitHub**
   - Go to repo on GitHub
   - Click "New Pull Request"
   - Describe what you changed
   - Wait for security scan
   - Get approval before merging

## After PR is Approved:

1. ✅ Security scanner passes
2. ✅ Code review passes
3. ✅ All checks pass
4. ✅ Merge to main
5. ✅ Done!

## Never Commit Directly to Main

Always create a PR first. This keeps everything secure and on track.

---

**This is the standard workflow for ALL work on this project.**
