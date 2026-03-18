# Changelog - DragonBinds

## [1.5.1] - 2026-03-18
### Added
- **Modular Architecture**: Completely refactored the codebase, splitting the monolithic `Core.lua` into `Core.lua`, `Settings.lua`, `Overrides.lua`, and `Detection.lua` for better maintainability and debugging.
- **English Localization**: Translated all in-game print messages and code comments to English for the standard open-source release.
- **Development Environment Setup**: Added `.gitignore` to keep local development addons out of the production repository.

### Changed
- **Flight Detection Logic**: Replaced the Vigor (`UnitPowerType`) check with a purely native `IsMounted() + IsFlying()` trigger. This guarantees immediate activation exactly when leaving the ground and avoids edge-case bugs in WoW Midnight.
- **Removed Debug Mode**: Stripped out `Debug.lua` and associated telemetry to keep the production release lightweight and clean.

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

## [1.0.0] - Initial Release
- First release
