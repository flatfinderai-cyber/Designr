# Designr App Store - Distribution Manifest

**Version:** 1.0.0  
**Last Updated:** January 16, 2026  

---

## 📦 Available Apps

### 1. DesignrLabs (MVP)
**Package Name:** `designr-labs`  
**Version:** 1.0.0  
**Status:** Production Ready ✅

**Description:** AI-powered design and development platform. Create, preview, and generate code from design screenshots using GPT-4 Vision and Claude AI.

**Features:**
- Upload design screenshots
- Extract elements with AI vision
- Generate React components
- Collaborate with team members
- Export as Next.js project

**Technologies:**
- Next.js 14 + React 18 + TypeScript
- Supabase PostgreSQL + Auth
- GPT-4 Vision + Claude 3.5 Sonnet
- Tailwind CSS + Radix UI

**Installation:**
```bash
git clone https://github.com/flatfinderai-cyber/DesignrLabs.git
cd DesignrLabs
pnpm install
pnpm dev
```

**Repository:** https://github.com/flatfinderai-cyber/DesignrLabs  
**Demo:** [Launch Guide](DesignrLabs/LAUNCH-GUIDE.md)  

---

### 2. YouTube Analytics App
**Package Name:** `designr-youtube-app`  
**Version:** 0.1.0  
**Status:** Beta 🔧

**Description:** Analyze YouTube video performance and trends. Extract data, generate insights, and create reports.

**Features:**
- Connect YouTube channels
- Analyze video metrics
- Track performance trends
- Generate automated reports

**Location:** `/workspaces/Designr/YoutubeApp`  
**Entry Point:** `index.ts` + `pipeline.ts`

**Installation:**
```bash
cd YoutubeApp
npm install
npm run start
```

---

### 3. PRD Generator
**Package Name:** `prd-generator`  
**Version:** 1.0.0  
**Status:** Production Ready ✅

**Description:** Interactive Q&A tool to generate PRD.json for Ralph-loop automation. Create detailed Product Requirements Documents without writing from scratch.

**Features:**
- Interactive question workflow (3-5 questions)
- Guided quality gates specification
- Adaptive follow-up questions
- PRD preview
- JSON export ready for ralph-tui

**Technologies:**
- Next.js 14 + React 18 + TypeScript
- Tailwind CSS
- Zustand (state management)
- Lucide icons

**Installation:**
```bash
cd PRDGenerator
pnpm install
pnpm dev
```

**Usage:**
1. Open http://localhost:3000
2. Answer 3 question sets
3. Preview generated PRD
4. Download prd.json
5. Run with `ralph-tui run --prd prd.json`

**Repository:** [PRD Generator Docs](PRDGenerator/README.md)  

---

### 4. Designr Hub (App Store)
**Package Name:** `designr-hub`  
**Version:** 1.0.0  
**Status:** Production Ready ✅

**Description:** Central hub for discovering, deploying, and managing Designr applications. Micro-SaaS architecture with pluggable apps.

**Features:**
- App registry and discovery
- One-click deployment
- App management dashboard
- Team collaboration
- Integration marketplace

**Location:** `/workspaces/Designr`

**Installation:**
```bash
git clone https://github.com/flatfinderai-cyber/Designr.git
cd Designr
pnpm install
pnpm dev
```

**Repository:** https://github.com/flatfinderai-cyber/Designr  
**Documentation:** [APP-STORE-COMPLETE.md](APP-STORE-COMPLETE.md)  

---

## 📋 Installation Matrix

| App | Type | Node | Package Manager | Status |
|-----|------|------|-----------------|--------|
| DesignrLabs | Next.js | 18+ | pnpm | ✅ Ready |
| YouTube App | Node.js | 18+ | npm | 🔧 Beta |
| PRD Generator | Next.js | 18+ | pnpm | ✅ Ready |
| Designr Hub | Next.js | 18+ | pnpm | ✅ Ready |

---

## 🚀 Quick Start

### Start All Apps Locally

```bash
# Terminal 1: Designr Hub
cd /workspaces/Designr
pnpm install
pnpm dev  # Runs on http://localhost:3000

# Terminal 2: DesignrLabs
cd /workspaces/Designr/DesignrLabs
pnpm install
pnpm dev  # Runs on http://localhost:3001

# Terminal 3: PRD Generator
cd /workspaces/Designr/PRDGenerator
pnpm install
pnpm dev  # Runs on http://localhost:3002
```

---

## 📦 Docker Deployment

Each app can be containerized:

```dockerfile
FROM node:20-alpine

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]
```

---

## 🔗 Integration & APIs

### Supabase Connection
All apps connect to same Supabase instance:
```
Database: PostgreSQL
Auth: Supabase Auth
Storage: S3-compatible
```

### AI Models
- **GPT-4 Vision** - Image analysis in DesignrLabs
- **Claude 3.5 Sonnet** - Code generation & reasoning

### Authentication
- Supabase Auth (OAuth + Email)
- Next.js Auth Helpers
- JWT tokens

---

## 📊 Version History

### January 16, 2026
- ✅ DesignrLabs MVP (20 iterations, production ready)
- ✅ PRD Generator (interactive Q&A + JSON export)
- ✅ YouTube App (beta)
- ✅ Designr Hub (app store infrastructure)

---

## 🛠️ Build & Test

### Quality Gates for All Apps

**TypeScript:**
```bash
pnpm typecheck
```

**Linting:**
```bash
pnpm lint
```

**Testing:**
```bash
pnpm test
```

**E2E Tests:**
```bash
pnpm test:e2e
```

---

## 📝 Documentation

- **[DesignrLabs Build Guide](DesignrLabs/BUILD-INSTRUCTIONS.md)**
- **[PRD Generator Readme](PRDGenerator/README.md)**
- **[App Store Complete](APP-STORE-COMPLETE.md)**
- **[Getting Started](GETTING-STARTED.md)**

---

## 🤝 Contributing

Each app follows strict quality gates:

1. Feature branch (`feature/*`)
2. Pull request with code review
3. Security scanner approval
4. All tests passing
5. Merge to main

See [PULL_REQUEST_CHECKLIST.md](PULL_REQUEST_CHECKLIST.md)

---

## 📞 Support

- **Issues:** GitHub Issues on respective repos
- **Docs:** See README.md in each app folder
- **Tutorials:** [Interactive Tutorials](docs/GITHUB-PUSH-TUTORIAL.md)

---

## 📄 License

MIT - See LICENSE in each repository

---

**Ready to deploy?** Choose your app and follow the installation steps above.
