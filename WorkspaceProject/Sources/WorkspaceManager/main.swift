import Cocoa
import SwiftUI
import Foundation

// MARK: - Layout Enum
enum Layout: String, CaseIterable, Codable, Identifiable {
    var id: String { rawValue }

    case left            = "left"
    case right           = "right"
    case top             = "top"
    case bottom          = "bottom"
    case topLeft         = "top-left"
    case topRight        = "top-right"
    case bottomLeft      = "bottom-left"
    case bottomRight     = "bottom-right"
    case topLeftTwoThirdH   = "top-left-2third-h"
    case topRightTwoThirdH  = "top-right-2third-h"
    case bottomLeftTwoThirdH  = "bottom-left-2third-h"
    case bottomRightTwoThirdH = "bottom-right-2third-h"
    case leftThird       = "left-third"
    case leftTwoThirds   = "left-two-thirds"
    case centerThird     = "center-third"
    case rightTwoThirds  = "right-two-thirds"
    case rightThird      = "right-third"
    case maximize        = "maximize"
    case center          = "center"

    var displayName: String {
        switch self {
        case .left:           return "Left"
        case .right:          return "Right"
        case .top:            return "Top"
        case .bottom:         return "Bottom"
        case .topLeft:        return "Top Left"
        case .topRight:       return "Top Right"
        case .bottomLeft:     return "Bottom Left"
        case .bottomRight:    return "Bottom Right"
        case .topLeftTwoThirdH:    return "Top Left (2/3 H)"
        case .topRightTwoThirdH:   return "Top Right (2/3 H)"
        case .bottomLeftTwoThirdH:  return "Bottom Left (2/3 H)"
        case .bottomRightTwoThirdH: return "Bottom Right (2/3 H)"
        case .leftThird:      return "Left Third"
        case .leftTwoThirds:  return "Left Two Thirds"
        case .centerThird:    return "Center Third"
        case .rightTwoThirds: return "Right Two Thirds"
        case .rightThird:     return "Right Third"
        case .maximize:       return "Maximize"
        case .center:         return "Center"
        }
    }

    var icon: String {
        switch self {
        case .left:           return "rectangle.lefthalf.filled"
        case .right:          return "rectangle.righthalf.filled"
        case .top:            return "rectangle.tophalf.filled"
        case .bottom:         return "rectangle.bottomhalf.filled"
        case .topLeft:        return "rectangle.inset.topleft.filled"
        case .topRight:       return "rectangle.inset.topright.filled"
        case .bottomLeft:     return "rectangle.inset.bottomleft.filled"
        case .bottomRight:    return "rectangle.inset.bottomright.filled"
        case .topLeftTwoThirdH:    return "rectangle.inset.topleft.filled"
        case .topRightTwoThirdH:   return "rectangle.inset.topright.filled"
        case .bottomLeftTwoThirdH:  return "rectangle.inset.bottomleft.filled"
        case .bottomRightTwoThirdH: return "rectangle.inset.bottomright.filled"
        case .leftThird:      return "rectangle.split.3x1"
        case .leftTwoThirds:  return "rectangle.split.3x1"
        case .centerThird:    return "rectangle.split.3x1"
        case .rightTwoThirds: return "rectangle.split.3x1"
        case .rightThird:     return "rectangle.split.3x1"
        case .maximize:       return "rectangle.fill"
        case .center:         return "rectangle.center.inset.filled"
        }
    }

    // Compute absolute AppleScript bounds given a screen's origin and size
    func computeBounds(screenX sx: Int, screenY sy: Int, screenWidth sw: Int, screenHeight sh: Int) -> String {
        let hw = sw / 2, hh = sh / 2
        let tw = sw / 3, ttw = (sw / 3) * 2
        let tth = (sh * 2) / 3
        let qw = sw / 4, qh = sh / 4
        switch self {
        case .left:                  return "{\(sx), \(sy), \(sx+hw), \(sy+sh)}"
        case .right:                 return "{\(sx+hw), \(sy), \(sx+sw), \(sy+sh)}"
        case .top:                   return "{\(sx), \(sy), \(sx+sw), \(sy+hh)}"
        case .bottom:                return "{\(sx), \(sy+hh), \(sx+sw), \(sy+sh)}"
        case .topLeft:               return "{\(sx), \(sy), \(sx+hw), \(sy+hh)}"
        case .topRight:              return "{\(sx+hw), \(sy), \(sx+sw), \(sy+hh)}"
        case .bottomLeft:            return "{\(sx), \(sy+hh), \(sx+hw), \(sy+sh)}"
        case .bottomRight:           return "{\(sx+hw), \(sy+hh), \(sx+sw), \(sy+sh)}"
        case .topLeftTwoThirdH:      return "{\(sx), \(sy), \(sx+hw), \(sy+tth)}"
        case .topRightTwoThirdH:     return "{\(sx+hw), \(sy), \(sx+sw), \(sy+tth)}"
        case .bottomLeftTwoThirdH:   return "{\(sx), \(sy+sh-tth), \(sx+hw), \(sy+sh)}"
        case .bottomRightTwoThirdH:  return "{\(sx+hw), \(sy+sh-tth), \(sx+sw), \(sy+sh)}"
        case .leftThird:             return "{\(sx), \(sy), \(sx+tw), \(sy+sh)}"
        case .leftTwoThirds:         return "{\(sx), \(sy), \(sx+ttw), \(sy+sh)}"
        case .centerThird:           return "{\(sx+tw), \(sy), \(sx+ttw), \(sy+sh)}"
        case .rightTwoThirds:        return "{\(sx+tw), \(sy), \(sx+sw), \(sy+sh)}"
        case .rightThird:            return "{\(sx+ttw), \(sy), \(sx+sw), \(sy+sh)}"
        case .maximize:              return "{\(sx), \(sy), \(sx+sw), \(sy+sh)}"
        case .center:                return "{\(sx+qw), \(sy+qh), \(sx+sw-qw), \(sy+sh-qh)}"
        }
    }
}

// MARK: - Tab Model
struct TabItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var url: String = ""
    var profile: String = "Default"
    var layout: Layout = .topLeft
    var screenIndex: Int = 0  // 0 = primary screen

    // Custom decode để backward-compatible với data cũ chưa có screenIndex
    init(id: UUID = UUID(), url: String = "", profile: String = "Default",
         layout: Layout = .topLeft, screenIndex: Int = 0) {
        self.id = id; self.url = url; self.profile = profile
        self.layout = layout; self.screenIndex = screenIndex
    }

    enum CodingKeys: String, CodingKey { case id, url, profile, layout, screenIndex }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id          = try c.decode(UUID.self,   forKey: .id)
        url         = try c.decode(String.self, forKey: .url)
        profile     = try c.decode(String.self, forKey: .profile)
        layout      = try c.decode(Layout.self, forKey: .layout)
        screenIndex = (try? c.decode(Int.self,  forKey: .screenIndex)) ?? 0  // fallback
    }
}

// MARK: - Config Model
struct AppConfig: Codable {
    var tabs: [TabItem]
}

// MARK: - Persistence Key
let tabsStorageKey = "mstart_tabs"

func saveTabs(_ tabs: [TabItem]) {
    if let data = try? JSONEncoder().encode(tabs) {
        UserDefaults.standard.set(data, forKey: tabsStorageKey)
    }
}

func loadTabs() -> [TabItem] {
    guard let data = UserDefaults.standard.data(forKey: tabsStorageKey),
          let tabs = try? JSONDecoder().decode([TabItem].self, from: data) else {
        return []
    }
    return tabs
}

// MARK: - Config File Loader
func loadConfigFile() -> AppConfig? {
    guard let configURL = Bundle.main.url(forResource: "config", withExtension: "json"),
          let data = try? Data(contentsOf: configURL),
          let config = try? JSONDecoder().decode(AppConfig.self, from: data) else {
        return nil
    }
    return config
}

func seedFromConfigIfNeeded() {
    guard loadTabs().isEmpty, let config = loadConfigFile() else { return }
    saveTabs(config.tabs)
}

// MARK: - Settings ViewModel
class TabsViewModel: ObservableObject {
    @Published var tabs: [TabItem] = [] {
        didSet { saveTabs(tabs) }
    }

    init() {
        tabs = loadTabs()
    }

    func addTab() {
        tabs.append(TabItem())
    }

    func removeTab(at offsets: IndexSet) {
        tabs.remove(atOffsets: offsets)
    }

    func moveTab(from source: IndexSet, to destination: Int) {
        tabs.move(fromOffsets: source, toOffset: destination)
    }
}

// MARK: - Tab Row View
struct TabRowView: View {
    @Binding var tab: TabItem

    /// Danh sách màn hình hiện có, lấy thực tế từ NSScreen
    private var availableScreens: [(index: Int, label: String)] {
        NSScreen.screens.enumerated().map { i, screen in
            let res = "\(Int(screen.frame.width))×\(Int(screen.frame.height))"
            return (index: i, label: "Screen \(i + 1)  —  \(screen.localizedName) (\(res))")
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: tab.layout.icon)
                    .foregroundColor(.accentColor)
                    .frame(width: 20)

                TextField("https://example.com", text: $tab.url)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(.body, design: .monospaced))

                Picker("", selection: $tab.layout) {
                    ForEach(Layout.allCases) { layout in
                        Label(layout.displayName, systemImage: layout.icon)
                            .tag(layout)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 160)
            }

            HStack(spacing: 8) {
                Image(systemName: "person.circle")
                    .foregroundColor(.secondary)
                    .frame(width: 20)
                TextField("Chrome Profile (e.g. Default, Profile 1, Profile 17)", text: $tab.profile)
                    .textFieldStyle(.roundedBorder)
                    .font(.caption)

                // Screen picker — tự detect màn hình đang kết nối
                Image(systemName: "display")
                    .foregroundColor(.secondary)
                Picker("", selection: $tab.screenIndex) {
                    ForEach(availableScreens, id: \.index) { screen in
                        Text(screen.label).tag(screen.index)
                    }
                }
                .pickerStyle(.menu)
                .frame(minWidth: 160)
                .help("Chọn màn hình mở tab này")
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Settings View
struct SettingsView: View {
    @State private var isEditing = false
    @StateObject var vm = TabsViewModel()

    var hasAnyValidTab: Bool {
        vm.tabs.contains { !$0.url.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "square.grid.2x2")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Chrome Quickfire")
                        .font(.headline)
                    Text("Fire up your Chrome workspace in one click.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: { isEditing.toggle() }) {
                    Text(isEditing ? "Done" : "Edit")
                }
                .buttonStyle(.bordered)
                Button(action: { vm.addTab() }) {
                    Label("Add Tab", systemImage: "plus")
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))

            Divider()

            if vm.tabs.isEmpty {
                // Empty state
                VStack(spacing: 12) {
                    Image(systemName: "rectangle.on.rectangle.slash")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                    Text("No tabs configured")
                        .font(.headline)
                    Text("Click \"Add Tab\" to get started.")
                        .foregroundColor(.secondary)
                    Button("Add First Tab") { vm.addTab() }
                        .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach($vm.tabs) { $tab in
                        HStack(alignment: .top, spacing: 4) {
                            if isEditing {
                                Button(action: {
                                    if let idx = vm.tabs.firstIndex(where: { $0.id == tab.id }) {
                                        vm.tabs.remove(at: idx)
                                    }
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title3)
                                }
                                .buttonStyle(.plain)
                                .padding(.top, 10)
                            }
                            TabRowView(tab: $tab)
                        }
                    }
                    .onMove(perform: vm.moveTab)
                }
                .listStyle(.inset)

                // Chrome Profile help tip
                GroupBox {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.accentColor)
                            .font(.body)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("How to find your Chrome Profile name")
                                .font(.caption)
                                .fontWeight(.semibold)
                            HStack(spacing: 4) {
                                Text("Open")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Button("chrome://version") {
                                    NSWorkspace.shared.open(URL(string: "googlechrome://version")
                                        ?? URL(string: "https://google.com")!)
                                }
                                .font(.caption)
                                .buttonStyle(.link)
                                Text("→ look at **Profile Path** → copy the last folder name.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }

            Divider()

            // Footer
            HStack {
                if !vm.tabs.isEmpty {
                    Text("\(vm.tabs.count) tab\(vm.tabs.count == 1 ? "" : "s") configured")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: { AppDelegate.shared.runWorkspace() }) {
                    Label("Launch Workspace", systemImage: "rocket")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!hasAnyValidTab)
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
        }
        .frame(minWidth: 580, minHeight: 500)
    }
}

// MARK: - AppDelegate
class AppDelegate: NSObject, NSApplicationDelegate {
    static let shared = AppDelegate()
    var statusItem: NSStatusItem!
    var settingsWindow: NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        seedFromConfigIfNeeded()
        setupMenuBar()

        if loadTabs().isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.openSettings()
            }
        }
    }

    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let icon = NSImage(systemSymbolName: "square.grid.2x2", accessibilityDescription: "Mstart")
        icon?.isTemplate = true
        statusItem.button?.image = icon
        statusItem.button?.title = " Quickfire"
        statusItem.button?.toolTip = "Chrome Quickfire — Workspace Manager"

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Launch Workspace", action: #selector(runWorkspaceFromMenu), keyEquivalent: "r"))
        menu.addItem(NSMenuItem(title: "Preferences…", action: #selector(openSettings), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Chrome Quickfire", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }

    @objc func runWorkspaceFromMenu() { runWorkspace() }

    @objc func openSettings() {
        if settingsWindow == nil {
            let hostingController = NSHostingController(rootView: SettingsView())
            let window = NSWindow(contentViewController: hostingController)
            window.title = "Chrome Quickfire — Preferences"
            window.styleMask = [.titled, .closable, .miniaturizable, .resizable]
            window.setContentSize(NSSize(width: 600, height: 520))
            window.center()
            window.isReleasedWhenClosed = false
            self.settingsWindow = window
        }
        settingsWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func runWorkspace() {
        let tabs = loadTabs().filter { !$0.url.trimmingCharacters(in: .whitespaces).isEmpty }
        guard !tabs.isEmpty else { openSettings(); return }

        let screens = NSScreen.screens
        // Quartz Y=0 ở bottom-left; AppleScript Y=0 ở top-left của primary screen
        let primaryHeight = Int(screens.first?.frame.height ?? 0)

        var commands: [String] = []
        for tab in tabs {
            // Chắc chắn không out-of-bounds nếu màn hình bị unplug
            let safeIdx = min(max(tab.screenIndex, 0), screens.count - 1)
            let frame   = screens[safeIdx].frame

            let sx = Int(frame.origin.x)
            let sy = primaryHeight - Int(frame.origin.y) - Int(frame.height)  // flip Y
            let sw = Int(frame.width)
            let sh = Int(frame.height)

            let bounds = tab.layout.computeBounds(screenX: sx, screenY: sy,
                                                  screenWidth: sw, screenHeight: sh)

            let cmd = """
            do shell script "\\"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome\\" --profile-directory=\\"\(tab.profile)\\" --new-window \\"\(tab.url)\\" > /dev/null 2>&1 &"
            delay 1.0
            tell application "Google Chrome"
                activate
                set bounds of window 1 to \(bounds)
            end tell
            """
            commands.append(cmd)
        }

        let scriptSource = commands.joined(separator: "\n\n")

        var error: NSDictionary?
        if let script = NSAppleScript(source: scriptSource) {
            script.executeAndReturnError(&error)
            if let err = error { print("AppleScript error: \(err)") }
        }
    }
}

// MARK: - Entry Point
let app = NSApplication.shared
let delegate = AppDelegate.shared
app.delegate = delegate
app.run()
