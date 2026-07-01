#!/bin/bash
# Flutter Screenshot-to-Code Skill Installer
# Automatically symlinks the skill to all detected AI agents

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLED=0

echo "🔍 Detecting installed agents..."

# Claude Code
if command -v claude &>/dev/null || [ -d "$HOME/.claude" ]; then
  mkdir -p "$HOME/.claude/skills"
  ln -sfn "$SKILL_DIR" "$HOME/.claude/skills/flutter-screenshot-to-code"
  echo "✅ Claude Code"
  INSTALLED=$((INSTALLED + 1))
fi

# OpenCode
if command -v opencode &>/dev/null || [ -d "$HOME/.config/opencode" ]; then
  mkdir -p "$HOME/.config/opencode/skills"
  ln -sfn "$SKILL_DIR" "$HOME/.config/opencode/skills/flutter-screenshot-to-code"
  echo "✅ OpenCode"
  INSTALLED=$((INSTALLED + 1))
fi

# Codex
if command -v codex &>/dev/null || [ -d "$HOME/.codex" ]; then
  mkdir -p "$HOME/.codex/skills"
  ln -sfn "$SKILL_DIR" "$HOME/.codex/skills/flutter-screenshot-to-code"
  echo "✅ Codex"
  INSTALLED=$((INSTALLED + 1))
fi

# Gemini CLI
if command -v gemini &>/dev/null || [ -d "$HOME/.gemini" ]; then
  mkdir -p "$HOME/.gemini/skills"
  ln -sfn "$SKILL_DIR" "$HOME/.gemini/skills/flutter-screenshot-to-code"
  echo "✅ Gemini CLI"
  INSTALLED=$((INSTALLED + 1))
fi

if [ $INSTALLED -eq 0 ]; then
  echo "⚠️  No agents detected. Skill available at: $SKILL_DIR"
else
  echo ""
  echo "🎉 Installed for $INSTALLED agent(s). Skill ready to use."
fi
