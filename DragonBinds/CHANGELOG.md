# Changelog - DragonBinds

## [1.4.1] - 2026-03-18
### Added
- **Universal Compatibility**: The addon now automatically detects your movement keybinds (WASD, ESDF, IJKL, etc.).
- **`/db bind [Key]` Command**: Allows users to manually define the "backward" key to be hijacked for flight (ideal for PvP players with custom binds).
- **Persistent Settings**: Auto-mode state and custom bound keys are now saved per character.
- **WoW Midnight (12.0) Support**: Full optimization to bypass the "Addon Prune" using a lightweight polling system.

### Fixed
- **Detection Stability**: Fixed an issue where auto-mode wouldn't trigger on certain mounts using the `IsMounted()` logic.
- **Zero Taint**: Migrated to `SetOverrideBinding` to avoid corrupting global game configuration files.
- **Multi-Binds Support**: Properly handles secondary keybinds (e.g., Arrow Keys + WASD).

## [v1.0.0]

- First release