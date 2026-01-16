# Designr Apps Registry

**Last Updated:** January 16, 2026
**Total Apps:** 4
**Production Ready:** 3 ✅
**Beta:** 1 🔧

Central registry of all apps available in the Designr App Store.

---

## 📊 Registry Overview

| App | Version | Status | Type | Repo | --- | --- | --- | --- | --- | --- | --- | DesignrLabs | 1.0.0 | ✅ Production | Next.js | flatfinderai-cyber/DesignrLabs | --- | Designr Hub | 1.0.0 | ✅ Production | Next.js | flatfinderai-cyber/Designr | --- | PRD Generator | 1.0.0 | ✅ Production | Next.js | Designr/PRDGenerator | --- | YouTube App | 0.1.0 | 🔧 Beta | Node.js | Designr/YoutubeApp |

---

## 📱 Apps Registry

### DesignrLabs
**ID**: `designr-labs`

#### Transform hand-drawn sketches into production-ready code

Convert UI sketches from paper, whiteboard, or iPad into interactive web applications with AI detection and code export.

| Property | Value | --- | --- | --- | --- | **Repository** | [github.com/flatfinderai-cyber/DesignrLabs](https://github.com/flatfinderai-cyber/DesignrLabs) | --- | **Website** | [designrlabs.com](https://designrlabs.com) | --- | **Version** | 0.0.1 | --- | **Status** | Developing | --- | **Launch** | Q2 2026 | --- | **Owner** | Designr Labs Team |

**Features**:
- Sketch Upload (drag-drop, camera, batch)
- AI Element Detection (GPT-4 Vision)
- Infinite Canvas (Konva.js)
- Artboard System (device presets)
- Layer Management
- Live UI Preview
- Code Export (5+ frameworks)
- One-Click Deploy

**Tech Stack**:
- Frontend: Next.js 14, TypeScript, Tailwind CSS
- Backend: Node.js, Supabase
- Canvas: Konva.js
- State: Zustand
- Testing: Jest, Playwright

**Pricing Tiers**:
- Free: $0/month (10 sketches/month)
- Pro: $29/month (unlimited)
- Team: $99/month (5 seats, API access)

**API Endpoints**:
```bash

POST /api/sketches/upload
POST /api/ai/detect-elements
POST /api/ai/generate-ui
POST /api/export/code
POST /api/deploy
```

**Health Check**: [designrlabs.com/health](https://designrlabs.com/health)

---

## 🔄 Adding a New App

To submit your app to the Designr App Store:

1. **Meet Technical Standards** - Read [STANDARDS.md](STANDARDS.md)
2. **Prepare Repository** - Include all required files
3. **Create Registry Entry** - Add to this file
4. **Submit PR** - Create pull request
5. **Review & Approval** - 1-2 week review
6. **Launch** - Appear in app store

### Registry Entry Template

```markdown
### Your App Name
**ID**: `your-app-id`

#### One-line description of what your app does

Longer description with details about features and benefits.

| Property | Value | --- | --- | --- | --- | **Repository** | [github.com/your-org/your-app](https://github.com/your-org/your-app) | --- | **Website** | [your-app.com](https://your-app.com) | --- | **Version** | 0.0.1 | --- | **Status** | Developing/Beta/Stable | --- | **Launch** | Q2 2026 | --- | **Owner** | Your Team Name |

**Features**:
- Feature 1
- Feature 2
- Feature 3

**Tech Stack**:
- Frontend: [Your tech]
- Backend: [Your tech]
- Database: [Your tech]

**Pricing Tiers**:
- Free: Description
- Pro: Description
- Team: Description

**API Endpoints**:
```bash

GET /api/...
POST /api/...
```

**Health Check**: [your-app.com/health](https://your-app.com/health)
```

---

## 📊 Registry Statistics

| Metric | Value | --- | --- | --- | --- | Total Apps | 1 | --- | Apps Developing | 1 | --- | Apps Stable | 0 | --- | Total Users (Estimated) | TBD | --- | Total MRR | TBD |

---

## 🔗 Integration Endpoints

Each app provides these standard endpoints:

### Health Check
```bash

GET /health

Response:
{
  "status": "healthy",
  "version": "0.0.1",
  "timestamp": "2025-01-16T10:30:00Z"
}
```

### User Profile
```bash

GET /api/v1/users/me

Headers:
Authorization: Bearer <token>

Response:
{
  "id": "uuid",
  "email": "user@example.com",
  "name": "User Name",
  "avatar": "[...",](https://...",)
  "created_at": "2025-01-16T10:30:00Z"
}
```

### Projects/Workspace
```bash

GET /api/v1/projects

Response:
{
  "data": [
    {
      "id": "uuid",
      "name": "Project Name",
      "created_at": "2025-01-16T10:30:00Z"
    }
  ]
}
```

---

## 🔒 Authentication

All apps support these auth methods:

1. **OAuth 2.0** (Google, GitHub)
2. **API Keys** (service-to-service)
3. **JWT Tokens** (web/mobile)

Inter-app authentication uses API keys:

```bash

Authorization: Bearer designr-app-<app-id>-<api-key>
X-App-ID: designr-labs
X-Request-ID: uuid
```

---

## 📡 Webhooks

Apps can subscribe to events from other apps:

```bash
# Register webhook
POST /api/v1/webhooks/register

{
  "target_app": "designr-labs",
  "event": "sketch.created",
  "webhook_url": "[your-app.com/webhooks/designr-labs",](https://your-app.com/webhooks/designr-labs",)
  "events": [
    "sketch.created",
    "sketch.processed",
    "code.exported"
  ]
}
```

### Events Available

#### DesignrLabs Events
- `sketch.created` - New sketch uploaded
- `sketch.processed` - Elements detected
- `sketch.failed` - Processing failed
- `ui.rendered` - UI preview ready
- `code.exported` - Code exported
- `deployment.started` - Deployment begun
- `deployment.completed` - Deployed successfully

---

## 🎯 Planned Apps

### Coming Soon (Q1-Q2 2026)

- **DesignrBrand** - Brand asset management
- **DesignrCollab** - Real-time collaboration
- **DesignrAnalytics** - Usage analytics
- **DesignrDeploy** - Enhanced deployment
- **DesignrAPI** - API marketplace

---

## 📞 Support

- **Developer Slack**: [Join]([slack.designr.store](https://slack.designr.store))
- **GitHub Issues**: [Report issues]([github.com/flatfinderai-cyber/Designr/issues](https://github.com/flatfinderai-cyber/Designr/issues))
- **Email**: developers@designr.store
- **Discord**: [Community]([discord.gg/designr](https://discord.gg/designr))

---

**Last Updated**: 2025-01-16  
**Version**: 1.0
