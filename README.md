# Chrome Quickfire

> A lightweight macOS Menu Bar app that launches and arranges multiple Chrome windows in one click.

![macOS](https://img.shields.io/badge/macOS-11%2B-blue) ![Swift](https://img.shields.io/badge/Swift-5.7%2B-orange) ![License](https://img.shields.io/badge/license-MIT-green)

---

## What is Chrome Quickfire?

Tired of manually opening tabs and dragging windows around every morning? **Chrome Quickfire** sits quietly in your Menu Bar and launches all your Chrome windows — each with its own URL, Chrome Profile, and screen position — in a single click.

## Features

- **One-click workspace launch** from the Menu Bar
- **Dynamic tab configuration** — add as many tabs as you want, no hardcoding
- **19 layout presets** per tab (Top Left, Right Third, Center, Maximize, 2/3 height variants, and more)
- **Per-tab Chrome Profile support** — open different tabs under different Google accounts simultaneously
- **Config file driven** — set your defaults in `config.json`, no recompile needed
- **Preferences UI** — edit URLs, profiles and layouts visually without touching code
- **Drag to reorder** tabs in the Preferences window
- **Tiny footprint** — native Swift, no Electron, minimal RAM usage

## Requirements

- macOS 11 (Big Sur) or later
- Google Chrome installed at `/Applications/Google Chrome.app`
- Xcode Command Line Tools (`xcode-select --install`)

## Getting Started

### 1. Clone the repo

```bash
git clone <your-repo-url>
cd mstart
```

### 2. Create your config file

```bash
cp config.example.json config.json
```

Edit `config.json` with your own URLs, Chrome Profiles and layouts:

```json
{
  "tabs": [
    {
      "id": "any-uuid-here",
      "url": "https://mail.google.com",
      "profile": "Default",
      "layout": "top-left"
    },
    {
      "id": "another-uuid",
      "url": "https://github.com",
      "profile": "Profile 1",
      "layout": "top-right"
    }
  ]
}
```

### 3. Build and run

```bash
./build.sh
```

That's it. Chrome Quickfire will appear in your Menu Bar.

## Finding Your Chrome Profile Name

1. Open Chrome with the profile you want to use
2. Type `chrome://version` in the address bar
3. Look at the **Profile Path** field — the last folder name is your profile (e.g. `Default`, `Profile 1`, `Profile 17`)

## Available Layouts

| Layout | Description |
|--------|-------------|
| `left` | Left half, full height |
| `right` | Right half, full height |
| `top` | Full width, top half |
| `bottom` | Full width, bottom half |
| `top-left` | Top-left quarter |
| `top-right` | Top-right quarter |
| `bottom-left` | Bottom-left quarter |
| `bottom-right` | Bottom-right quarter |
| `top-left-2third-h` | Left half, top 2/3 height |
| `top-right-2third-h` | Right half, top 2/3 height |
| `bottom-left-2third-h` | Left half, bottom 2/3 height |
| `bottom-right-2third-h` | Right half, bottom 2/3 height |
| `left-third` | Left 1/3 of screen |
| `left-two-thirds` | Left 2/3 of screen |
| `center-third` | Center 1/3 of screen |
| `right-two-thirds` | Right 2/3 of screen |
| `right-third` | Right 1/3 of screen |
| `maximize` | Full screen |
| `center` | Centered, 50% of screen |

## Usage

| Action | How |
|--------|-----|
| Launch workspace | Click **Chrome Quickfire** in Menu Bar → **Launch Workspace** (or `⌘R`) |
| Open Preferences | Click **Chrome Quickfire** → **Preferences…** (or `⌘,`) |
| Add a tab | Preferences → **Add Tab** button |
| Delete a tab | Preferences → **Edit** → click the ❌ button |
| Reorder tabs | Preferences → **Edit** → drag tabs |
| Quit | Click **Chrome Quickfire** → **Quit Chrome Quickfire** |

## Auto-start on Login

To have Chrome Quickfire launch automatically when you log in:

1. Open **System Settings → General → Login Items**
2. Click **+** and add `Chrome Quickfire.app`

## Project Structure

```
mstart/
├── main.swift                  # Full application source code
├── build.sh                    # Build script
├── config.json                 # Your personal config (gitignored)
├── config.example.json         # Example config to copy & customize
├── setup_chrome.applescript    # Legacy standalone AppleScript
├── Chrome Quickfire.app/                 # Compiled app bundle (gitignored)
└── WorkspaceProject/           # Xcode-compatible Swift Package
    └── Sources/WorkspaceManager/main.swift
```

## Rebuilding After Changes

Whenever you edit `main.swift` or `config.json`, run:

```bash
./build.sh
```

The script will: compile Swift → bundle `config.json` → sync Xcode source → relaunch the app.

## License

MIT
