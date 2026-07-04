# 🧊 Journali - Liquid Glass Journal

AI-powered bullet journal for iOS, iPadOS, and macOS with Apple-native sync and reflective AI intelligence.

---

## ✨ Overview

Liquid Glass Journal is a privacy-first journaling system built for the Apple ecosystem.

It combines:
- Offline-first bullet journaling
- Cross-device sync via Apple CloudKit
- AI-powered reflection and insights
- Minimal “liquid glass” visual UI system

AI is an enhancement layer, not a dependency.

---

## 🍎 Supported Platforms

- iOS (iPhone)
- iPadOS
- macOS (Apple Silicon + Intel)

---

## 🧠 Architecture

```
SwiftUI App Layer
        ↓
Core Data / SwiftData (Local Store)
        ↓
CloudKit (Sync Layer)
        ↓
AI Layer (Optional Enhancement)
```

---

## 📦 Core Modules

### Journal Engine
Handles all user content.

- JournalEntry
- DailyLog
- TaskItem
- Tags

---

### Sync Engine

Powered by CloudKit:
- Cross-device sync
- Offline-first queueing
- Conflict-safe merges

---

### AI Engine (Optional)

Enhances journal data asynchronously.

Features:
- Entry summarization
- Mood detection
- Tag suggestions
- Pattern recognition
- Daily reflection generation

AI must never block writing.

---

### Liquid Glass UI System

Visual rendering layer inspired by translucent depth.

Per-entry UI metadata:
- blur intensity
- opacity
- tint color
- mood gradient
- reflection score

---

## 🧾 Data Models

### JournalEntry

```swift
struct JournalEntry {
    let id: UUID
    let timestamp: Date
    var text: String

    var mood: Mood?
    var tags: [String]

    var aiSummary: String?
    var aiInsights: [String]

    var deviceSource: String
    var syncState: SyncState
}
```

---

### DailyLog

```swift
struct DailyLog {
    let date: Date
    var tasks: [TaskItem]
    var events: [String]
    var notes: [String]
    var completedTasks: [UUID]
}
```

---

### AIContext

```swift
struct AIContext {
    var toneProfile: String
    var recurringThemes: [String]
    var habitPatterns: [String]
}
```

---

## 🔄 Core Flow

### Writing an Entry

1. User writes entry locally
2. Saved instantly via Core Data / SwiftData
3. CloudKit sync queues update
4. AI processes asynchronously:
   - summarization
   - mood tagging
   - insight extraction
5. UI updates when AI results return

---

### Daily Reflection

1. Aggregate last 24h entries
2. AI generates:
   - summary
   - emotional trend
   - behavioral patterns
3. Store result in DailyLog

---

## 🧊 Liquid Glass Rendering

UI metadata per entry:

```json
{
  "glassEffect": {
    "blur": 16,
    "opacity": 0.45,
    "tint": "cool-blue",
    "depth": 0.7
  }
}
```

This affects visuals only — never core logic.

---

## 🔐 Privacy Model

- Local-first storage
- CloudKit encrypted sync
- AI calls are optional and stateless
- No external data persistence beyond user devices

---

## ⚙️ Non-Goals

This project does NOT:

- Replace Apple Notes
- Require constant internet access
- Depend on AI for core journaling
- Use custom backend servers
- Include social or sharing features

---

## 🚀 Future Features

- Apple Watch quick entry
- Widgets for instant journaling
- Voice-to-entry support
- Mood heatmap calendar
- Timeline “glass view”
- On-device AI summarization

---

## 📁 Suggested Repo Structure

```
LiquidGlassJournal/
│
├── App/
├── Core/
│   ├── Models/
│   ├── Persistence/
│   ├── Sync/
│
├── AI/
│   ├── PromptEngine/
│   ├── Analysis/
│
├── UI/
│   ├── GlassRenderer/
│   ├── Components/
│
├── Features/
│   ├── Journal/
│   ├── DailyLog/
│
├── Resources/
├── Tests/
└── README.md
```

---

## 🧠 Design Principles

- Journaling must be instant
- AI is optional enhancement
- Sync must be invisible
- UI should feel like layered glass memory
- Simplicity over feature bloat
