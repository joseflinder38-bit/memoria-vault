---
id: realclaudian
name: Claudian
source: vault-native
plugin-type: community
status: enabled
class: FULL
description: "Embeds Claude Code, Codex, and other coding agents as AI collaborators in your vault. Your vault becomes their working directory, giving them capabilities for file reads and writes, search, bash commands, and multi-step workflows."
has-settings: true
commands:
  - id: "realclaudian:open-view"
    name: "Claudian: Open chat view"
  - id: "realclaudian:inline-edit"
    name: "Claudian: Inline edit"
  - id: "realclaudian:new-tab"
    name: "Claudian: New tab"
  - id: "realclaudian:new-session"
    name: "Claudian: New session (in current tab)"
  - id: "realclaudian:close-current-tab"
    name: "Claudian: Close current tab"
---

# Claudian

**Description:** Embeds Claude Code, Codex, and other coding agents as AI collaborators in your vault. Your vault becomes their working directory, giving them capabilities for file reads and writes, search, bash commands, and multi-step workflows.
**Status:** Enabled
**Plugin ID:** realclaudian

## Available Commands

Available command IDs (use execute_command for Obsidian-native commands):
- `realclaudian:open-view` -- Claudian: Open chat view
- `realclaudian:inline-edit` -- Claudian: Inline edit
- `realclaudian:new-tab` -- Claudian: New tab
- `realclaudian:new-session` -- Claudian: New session (in current tab)
- `realclaudian:close-current-tab` -- Claudian: Close current tab

## Configuration File

Settings path: `.obsidian/plugins/realclaudian/data.json`

To configure this plugin programmatically:
1. Read the config: read_file(".obsidian/plugins/realclaudian/data.json")
2. Understand the settings structure and modify values as needed
3. Write changes: write_file(".obsidian/plugins/realclaudian/data.json", updatedJSON)

Do NOT ask the user to open Settings UI. Modify data.json directly.

## Current Configuration

These are the plugin's current settings (sensitive values redacted):

```
tabManagerState:
  openTabs: [3 items]
  activeTabId: tab-1783211498089-yk4nh4i
```

For full settings, read: `.obsidian/plugins/realclaudian/data.json`

## Documentation

For detailed plugin documentation (commands, options, dependencies):
read_file(".vault-operator/plugin-skills/realclaudian.readme.md")

## Usage

When the user asks for functionality related to Claudian:
1. Read the plugin documentation (.readme.md) to understand capabilities and dependencies
2. Read the config file (.obsidian/plugins/realclaudian/data.json). If it does not exist, that is normal -- create it with the required settings
3. Configure the plugin by writing data.json with the values needed for the task
4. Execute the task using the appropriate tool:
   - For Obsidian-native commands (including file export): use execute_command
   - For CLI-based conversion needing Pandoc/LaTeX: use execute_recipe
   - For data queries: use call_plugin_api
5. If a command opens a UI dialog, tell the user what to click.

CRITICAL RULES:
- Prefer native Obsidian commands over external tools when both can accomplish the task.
- NEVER create fake output files. If the user asks for a PDF/DOCX/image export, use execute_recipe -- do NOT write content to a .pdf file yourself.
- If a dependency is missing (e.g. Pandoc), tell the user what to install.
IMPORTANT: After reading this file, ALWAYS take action or respond. Never end silently.
