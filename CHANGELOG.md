# Changelog

All notable changes to **Chrome Quickfire** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.1.1] - 2026-03-30

### Changed
- Translated all Vietnamese comments, doc comments, and UI strings in `main.swift` to English
  - Code comments: `TabItem` decoder, `NSMenuDelegate`, `applescriptCommand`, screen picker
  - UI tooltip strings: screen picker help, per-tab launch button help
  - Inline comments: optical centering offset, menu delegate setup

### Changed Files

| File | Change |
|------|--------|
| `main.swift` | All Vietnamese text → English |

---

## [1.1.0] - 2026-03-30

### Added
- **Chọn màn hình per-tab** — mỗi tab có thêm picker để chọn màn hình đích (Screen 1, Screen 2, ...); danh sách tự detect từ `NSScreen.screens` với tên và resolution thực tế
- **Nút launch riêng per-tab** — mỗi hàng trong Preferences có nút tròn ▶ (xanh accent / xám nếu URL trống) để mở riêng tab đó không cần chạy cả workspace
- **`runSingleTab(_:)`** — hàm mới trong `AppDelegate` để launch đúng 1 tab với đúng màn hình và layout
- **`applescriptCommand(for:)`** — helper dùng chung cho cả `runSingleTab` và `runWorkspace`, loại bỏ code lặp

### Fixed
- **Multi-monitor layout sai màn hình** — AppleScript cũ dùng `Finder → bounds of window of desktop` luôn trả về primary screen; thay bằng tính bounds trong Swift từ `NSScreen.screens[screenIndex]` với flip Y-axis đúng (Quartz → AppleScript)
- **Tab cũ bị mất sau update** — `TabItem` thiếu `screenIndex` khiến synthesized `Decodable` throw lỗi, toàn bộ UserDefaults load về `[]`; fix bằng custom `init(from:)` dùng `decodeIfPresent` fallback về `0`
- **`config.json` không load được** — `loadConfigFile()` tìm file ở thư mục cha của `.app` trong khi `build.sh` copy vào `Contents/Resources/`; đổi sang `Bundle.main.url(forResource:withExtension:)`

### Changed
- **Menu bar gọn hơn** — bỏ per-tab items khỏi dropdown menu bar, chỉ giữ Launch Workspace / Preferences / Quit
- **`NSMenuDelegate`** — menu bar rebuild động mỗi lần mở thay vì static items lúc khởi động
- **`runWorkspace()`** refactor — dùng `applescriptCommand(for:)` thay vì inline code lặp
- **Nút launch icon** — đổi sang hình tròn `Circle` + `play.fill` ở giữa

### Changed Files

| File | Thay đổi |
|------|----------|
| `main.swift` | Thêm `screenIndex` vào `TabItem`, custom `Decodable`, `computeBounds`, screen picker UI, circle launch button, `NSMenuDelegate`, `applescriptCommand`, `runSingleTab`, refactor `runWorkspace` |
| `WorkspaceProject/Sources/WorkspaceManager/main.swift` | Sync từ `main.swift` |

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
