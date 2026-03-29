# Changelog

All notable changes to **Chrome Quickfire** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.0] - 2026-03-30

### 🎉 Initial Release

#### Added
- **Menu Bar agent** — app runs silently in the background as a macOS status bar item (`LSUIElement`), no Dock icon
- **One-click workspace launch** — opens multiple Chrome windows and positions them on screen automatically via AppleScript
- **Dynamic tab configuration** — add, remove, and drag-to-reorder any number of tabs (no hardcoded limit)
- **19 layout presets** per tab:
  - Half-screen: Left, Right, Top, Bottom
  - Quarter-screen: Top Left, Top Right, Bottom Left, Bottom Right
  - 2/3 height corners: Top Left (2/3 H), Top Right (2/3 H), Bottom Left (2/3 H), Bottom Right (2/3 H)
  - Thirds: Left Third, Left Two Thirds, Center Third, Right Two Thirds, Right Third
  - Other: Maximize, Center
- **Per-tab Chrome Profile support** — open each tab under a different Google account simultaneously
- **Preferences window** (SwiftUI) — visual UI to manage URLs, profiles, and layouts without touching code
- **Edit mode** — toggle to delete tabs via ❌ button in Preferences
- **Empty state + onboarding** — first launch automatically opens Preferences if no tabs are configured
- **`config.json` file-driven defaults** — seed initial configuration from a JSON file bundled with the app
- **`config.example.json`** — template committed to git for new users to copy and customize
- **`build.sh`** — one-command build script: compiles Swift, bundles config, relaunches app
- **Custom app icon** — 4-window grid icon in macOS Big Sur style
- **SF Symbol menu bar icon** — `square.grid.2x2` adapts to dark/light mode automatically
- **`README.md`** — full documentation including layout reference, Chrome profile guide, and build instructions
- **`.gitignore`** — ignores `config.json` (personal data), all `.app` bundles, Xcode user data, macOS system files

#### Performance
- Launch delay reduced from `1.5s` to `1.0s` per tab (~4s total for 4 tabs, down from ~6s)

---

## [Unreleased]

### Planned
- Configurable delay per tab
- Error notification when AppleScript fails (currently logged to console only)
- Named workspace profiles (save/restore multiple sets of tabs)
- Support for browsers other than Chrome
