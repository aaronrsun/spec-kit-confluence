# spec-kit-confluence

## Overview
**spec-kit-confluence** is an extension for [spec-kit](https://github.com/your-org/spec-kit) that helps you create high-quality design documentation in Confluence. It automatically summarizes and consolidates all relevant content generated before the task and implementation phases (specifically, specify and plan) into a single, well-structured Confluence document. The agent uses judgment to select and rephrase the most important information, rather than copying everything verbatim.

## Key Features
- **Automated Design Doc Creation:** Summarizes pre-implementation discussions and planning into a Confluence page.
- **Intelligent Synthesis:** Picks out and rephrases the most important information for clarity and conciseness.
- **MCP Integration:** Uses the MCP server to securely access and write to Confluence.

## Prerequisites
- [spec-kit](https://github.com/your-org/spec-kit) v1.0.0 or higher
- A Confluence account with API access
- MCP server credentials/configuration (`*/Code/User/mcp.json` or `*/github-copilot/intellij/mcp.json`)

## Setup
1. Run the setup script:
	```sh
	chmod +x setup_mcp.sh
	./setup_mcp.sh
	```
	This will configure the MCP server for Confluence access.

## Usage and Functionality
After completing the specify and plan phases, run the `writetoconfluence` command. Be sure to include the URL to where you want the doc to be so the agent knows to write the doc there.

```
/speckit.confluence.writetoconfluence [confluence_url]
```

The agent will:
- Gather and synthesize all relevant pre-implementation content
- Create a new Confluence page in the specified space (and under the parent page, if provided)
- Add any specified tags/labels

## Notes
- The agent will use the MCP server to access Confluence. Ensure the MCP server is configured and running.
- The document will **not** simply copy all content verbatim; it will summarize and rephrase for clarity.
- For more details, see [commands/writetoconfluence.md](commands/writetoconfluence.md).

## License
MIT
