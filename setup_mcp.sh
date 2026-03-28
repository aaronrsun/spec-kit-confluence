#!/bin/bash

echo ""
echo "=============================="
echo "🛠️  VS Code Setup Instructions"
echo "=============================="
echo ""
echo "1. Ensure Visual Studio Code is installed."
echo "   👉 Download: https://code.visualstudio.com/"
echo ""
echo "2. Install the GitHub Copilot extension:"
echo "   👉 Extensions (Ctrl+Shift+X) > Search 'GitHub Copilot' > Install"
echo ""
echo "3. Update VS Code to the latest version:"
echo "   👉 Help > Check for Updates"
echo ""
echo "Keep this terminal open while you complete the above steps."
echo ""

echo "=============================="
echo "🛠️  IntelliJ Setup Instructions"
echo "=============================="
echo ""
echo "1. Update IntelliJ to the latest version:"
echo "   👉 Help > Check for Updates"
echo ""
echo "2. Update the Copilot plugin to the latest version:"
echo "   👉 Preferences > Plugins > Installed > GitHub Copilot > Update"
echo ""
echo "3. Verify Copilot is working in IntelliJ (look for Copilot icon at bottom right)."
echo ""

echo "=============================================="
echo "🔑 How to Generate a GitHub Personal Access Token (PAT)"
echo "=============================================="
echo ""
echo "1. Go to: https://github.com/settings/personal-access-tokens"
echo ""
echo "2. Click 'Generate new token'."
echo ""
echo "3. Select Resource owner (e.g., eg-internal for org tokens)."
echo ""
echo "4. Name your token (e.g., MCP_PAT)."
echo ""
echo "5. Set expiration as desired."
echo ""
echo "6. Select 'All repositories'."
echo ""
echo "7. Expand 'Repository permissions' and grant all read-only access (expand as needed)."
echo ""
echo "8. Expand 'Organization permissions' and grant all read-only access (expand as needed)."
echo ""
echo "9. Click 'Generate token' and COPY the token immediately."
echo ""
echo "10. Store the token securely. You will need to paste it in the mcp.json file."
echo ""

echo "🔐 Enter your GitHub Personal Access Token:"
read -r GH_MCP_PAT

echo "🔧 Checking for github-mcp-server..."
if brew list github-mcp-server &>/dev/null; then
    echo "✅ github-mcp-server is already installed."
else
    echo "📥 Installing github-mcp-server..."
    brew install github-mcp-server
fi

echo "🔧 Checking for node..."
if brew list node &>/dev/null; then
    echo "✅ node is already installed."
else
    echo "📥 Installing node..."
    brew install node
fi

echo "🔧 Checking for mcp-remote..."
if npm list -g mcp-remote &>/dev/null; then
    echo "✅ mcp-remote is already installed."
else
    echo "📥 Installing mcp-remote..."
    npm install -g mcp-remote
fi

echo "🔍 Searching for mcp.json file in github-copilot/intellij..."
MCP_FILE=$(find /Users -type f -path "*/github-copilot/intellij/mcp.json" 2>/dev/null)

if [ -z "$MCP_FILE" ]; then
    echo "❌ No mcp.json file found at /Users/*/github-copilot/intellij/mcp.json"
    exit 1
fi

MATCH_COUNT=$(echo "$MCP_FILE" | wc -l | tr -d ' ')
if [ "$MATCH_COUNT" -ne 1 ]; then
    echo "❌ Found $MATCH_COUNT matching mcp.json files. There should be exactly one."
    echo "$MCP_FILE"
    exit 1
fi

FILE_TO_UPDATE="$MCP_FILE"

# --- New block for VS Code mcp.json ---
echo "🔍 Searching for mcp.json file in Code/User..."
VSCODE_MCP_FILE=$(find /Users -type f -path "*/Code/User/mcp.json" 2>/dev/null)

if [ -z "$VSCODE_MCP_FILE" ]; then
    echo "❌ No mcp.json file found at /Users/*/Code/User/mcp.json"
    
    # Check if Code/User folder exists but mcp.json is missing
    VSCODE_USER_DIR=$(find /Users -type d -path "*/Code/User" 2>/dev/null | head -1)
    if [ -n "$VSCODE_USER_DIR" ]; then
        echo "📁 Found VS Code User directory: $VSCODE_USER_DIR"
        echo "✋ The mcp.json file is missing. Would you like to create it? (y/n):"
        read -r CREATE_VSCODE_MCP
        if [ "$CREATE_VSCODE_MCP" = "y" ]; then
            VSCODE_MCP_FILE="$VSCODE_USER_DIR/mcp.json"
            echo "📝 Will create: $VSCODE_MCP_FILE"
        fi
    fi
else
    VSCODE_MATCH_COUNT=$(echo "$VSCODE_MCP_FILE" | wc -l | tr -d ' ')
    if [ "$VSCODE_MATCH_COUNT" -ne 1 ]; then
        echo "❌ Found $VSCODE_MATCH_COUNT matching VS Code mcp.json files. There should be exactly one."
        echo "$VSCODE_MCP_FILE"
        VSCODE_MCP_FILE=""
    fi
fi

NEW_CONTENT=$(cat <<EOF
{
  "servers": {
    "atlassian": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote",
        "https://mcp.atlassian.com/v1/sse"
      ]
    },
    "GHEC": {
      "command": "github-mcp-server",
      "args": [
        "stdio"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "$GH_MCP_PAT",
        "GITHUB_HOST": "https://github.com"
      }
    }
  }
}
EOF
)

VSCODE_STATIC_CONTENT=$(cat <<EOF
{
	"servers": {
		"github": {
			"type": "http",
			"url": "https://api.githubcopilot.com/mcp/",
			"gallery": true
		},
		"atlassian": {
			"type": "http",
			"url": "https://mcp.atlassian.com/v1/sse",
			"gallery": true
		}
	},
	"inputs": []
}
EOF
)

echo "📄 File: $FILE_TO_UPDATE"
echo "🔎 Current content:"
cat "$FILE_TO_UPDATE"
echo "➡️ New content:"
echo "$NEW_CONTENT"

if [ -n "$VSCODE_MCP_FILE" ]; then
    echo "📄 VS Code File: $VSCODE_MCP_FILE"
    echo "🔎 Current content:"
    cat "$VSCODE_MCP_FILE"
    echo "➡️ New content:"
    echo "$VSCODE_STATIC_CONTENT"
fi

echo "✋ Set up Intellij Copilot MCP? (y/n):"
read -r SETUP_INTELLIJ
if [ "$SETUP_INTELLIJ" = "y" ]; then
    if [ -n "$FILE_TO_UPDATE" ]; then
        echo "📄 File: $FILE_TO_UPDATE"
        echo "🔎 Current content:"
        cat "$FILE_TO_UPDATE"
        echo "➡️ New content:"
        echo "$NEW_CONTENT"
        INTELLIJ_READY=1
    else
        echo "❌ Intellij mcp.json file not found. Skipping Intellij setup."
        INTELLIJ_READY=0
    fi
else
    echo "⏭️  Skipping Intellij Copilot MCP setup."
    INTELLIJ_READY=0
fi

echo "✋ Set up VS Code Copilot MCP? (y/n):"
read -r SETUP_VSCODE
if [ "$SETUP_VSCODE" = "y" ]; then
    if [ -n "$VSCODE_MCP_FILE" ]; then
        echo "📄 VS Code File: $VSCODE_MCP_FILE"
        echo "🔎 Current content:"
        cat "$VSCODE_MCP_FILE"
        echo "➡️ New content:"
        echo "$VSCODE_STATIC_CONTENT"
        VSCODE_READY=1
    else
        echo "❌ VS Code mcp.json file not found. Skipping VS Code setup."
        VSCODE_READY=0
    fi
else
    echo "⏭️  Skipping VS Code Copilot MCP setup."
    VSCODE_READY=0
fi

if [ "$INTELLIJ_READY" = "1" ] || [ "$VSCODE_READY" = "1" ]; then
    echo "✋ Type 'update mcp.json' to proceed with updating the selected file(s):"
    read -r CONFIRM
    if [ "$CONFIRM" = "update mcp.json" ]; then
        if [ "$INTELLIJ_READY" = "1" ]; then
            CURRENT_CONTENT=$(cat "$FILE_TO_UPDATE")
            if [ "$CURRENT_CONTENT" = "$NEW_CONTENT" ]; then
                echo "✅ $FILE_TO_UPDATE is already correctly configured."
            else
                {
                    echo "$FILE_TO_UPDATE"
                    cat "$FILE_TO_UPDATE"
                    echo ""
                } >> script_temp_logs.txt
                echo "$NEW_CONTENT" > "$FILE_TO_UPDATE"
                echo "✅ Updated $FILE_TO_UPDATE"
            fi
        fi
        if [ "$VSCODE_READY" = "1" ]; then
            CURRENT_VSCODE_CONTENT=$(cat "$VSCODE_MCP_FILE")
            if [ "$CURRENT_VSCODE_CONTENT" = "$VSCODE_STATIC_CONTENT" ]; then
                echo "✅ $VSCODE_MCP_FILE is already correctly configured."
            else
                {
                    echo "$VSCODE_MCP_FILE"
                    cat "$VSCODE_MCP_FILE"
                    echo ""
                } >> script_temp_logs.txt
                echo "$VSCODE_STATIC_CONTENT" > "$VSCODE_MCP_FILE"
                echo "✅ Updated $VSCODE_MCP_FILE"
            fi
        fi
        echo ""
        echo "🎉 MCP configuration complete!"
        echo ""
        echo "=============================="
        echo "🧑‍💻 Next Steps for VS Code"
        echo "=============================="
        echo ""
        echo "1. Open VS Code."
        echo "2. Click the Copilot icon in the sidebar or bottom bar."
        echo "3. Go to 'Agent' or 'Agent Mode' from the Copilot panel."
        echo "4. When prompted by Atlassian, approve access in your browser."
        echo "5. To manage tools: In the Copilot panel, look for the 'Tools' section. You can enable/disable tools as needed."
        echo ""
        echo "=============================="
        echo "🧑‍💻 Next Steps for IntelliJ"
        echo "=============================="
        echo ""
        echo "1. Open IntelliJ."
        echo "2. Click the Copilot icon at the bottom right."
        echo "3. Go to 'Agent' or 'Agent Mode' in the Copilot popup."
        echo "4. When prompted by Atlassian, approve access in your browser."
        echo "5. To manage tools: In the Copilot popup, expand the 'Tools' section to select or unselect tools."
        echo ""
        echo "=============================="
        echo "💡 Tips"
        echo "=============================="
        echo ""
        echo "- If you do not see the Agent mode or tools, restart your IDE."
        echo "- If issues persist, try restarting your laptop."
        echo "- Ensure your Copilot plugin/extension is up to date."
        echo ""
        echo "✅ All done! Enjoy using Copilot MCP Agent mode."
        echo ""
        echo "=============================="
        echo "🔧 Alternative: Using Environment Variables"
        echo "=============================="
        echo ""
        echo "Instead of storing your PAT directly in mcp.json, you can use environment variables:"
        echo ""
        echo "1. Set the environment variable in your shell profile:"
        echo "   For zsh: echo 'export GH_MCP_PAT=\"your_token_here\"' >> ~/.zshrc"
        echo "   For bash: echo 'export GH_MCP_PAT=\"your_token_here\"' >> ~/.bash_profile"
        echo ""
        echo "2. Update your mcp.json to reference the environment variable:"
        echo "   \"GITHUB_PERSONAL_ACCESS_TOKEN\": \"\$GH_MCP_PAT\""
        echo ""
        echo "3. Restart your terminal and IDE for changes to take effect."
        echo ""
    else
        echo "❌ Update cancelled."
    fi
else
    echo "No files selected for update. Exiting."
fi
