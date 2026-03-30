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
2. Refer to [this doc](https://support.atlassian.com/atlassian-rovo-mcp-server/docs/getting-started-with-the-atlassian-remote-mcp-server) for CLI congifuration.

## Usage and Functionality
### Overall
The agent will:
- Use the MCP server to access Confluence (ensure the MCP server is configured and running)
- Gather and synthesize all relevant pre-implementation content
- Create a new Confluence page in the specified space (and under the parent page, if provided)
- Not simply copy all content verbatim but rather summarize and rephrase for clarity
- Add any specified tags/labels

### `write` command
After completing the specify and plan phases, run the `write` command. Be sure to include the following:
- Conflence URL to where you want the doc to be
- Atlassian API token **(if run on the CLI)**
- Atlassian email address **(if run on the CLI)**

### Input format
```
Confluence URL: [confluence_url]
Atlassian API token: [atlassian_api_token] // if using CLI
Atlassian email address: [atlassian_email_address] // if using CLI
```

For more details, see [commands/write.md](commands/write.md).

## License
MIT
