# spec-kit-confluence

## Overview
**spec-kit-confluence** is an extension for [spec-kit](https://github.com/your-org/spec-kit) that bridges your pre-implementation workflow with Confluence. It can create, read, and update Confluence documents — automatically synthesizing the outputs of the specify and plan phases into a well-structured design doc, retrieving existing pages for reference, and keeping docs up to date as your plans evolve. The agent uses judgment to select and rephrase the most important information, rather than copying everything verbatim.

## Key Features
- **Automated Design Doc Creation:** Synthesizes pre-implementation discussions and planning into a Confluence page.
- **Document Retrieval:** Fetches and displays the contents of any existing Confluence page for in-context review.
- **Intelligent Updates:** Revises existing Confluence docs to reflect the latest specifications and plans, preserving document structure.
- **MCP Integration:** Uses the MCP server to securely access Confluence across all commands.

## Prerequisites
- [spec-kit](https://github.com/your-org/spec-kit) v0.1.0 or higher
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
- Gather and synthesize all relevant pre-implementation content when creating or updating docs
- Summarize and rephrase content for clarity when writing or updating — not copy verbatim
- Retrieve an existing doc and updating the pre-implementation content

### `write` command
After completing the specify and plan phases, run the `write` command. Be sure to include the following:
- Conflence URL to where you want the doc to be
- Atlassian API token **(if run on the CLI)**
- Atlassian email address **(if run on the CLI)**

For more details, see [commands/write.md](commands/write.md).

### `read` command
To retrieve and display the contents of an existing Confluence document, run the `read` command. Be sure to include the following:
- Confluence URL of the existing doc to read
- Atlassian API token **(if run on the CLI)**
- Atlassian email address **(if run on the CLI)**

For more details, see [commands/read.md](commands/read.md).

### `update` command
To modify an existing Confluence document with the latest specifications and plans, run the `update` command. The agent will intelligently revise the document rather than overwriting it wholesale. Be sure to include the following:
- Confluence URL of the existing doc to update
- Atlassian API token **(if run on the CLI)**
- Atlassian email address **(if run on the CLI)**

For more details, see [commands/update.md](commands/update.md).

### Input format
```
Confluence URL: [confluence_url]
Atlassian API token: [atlassian_api_token] // if using CLI
Atlassian email address: [atlassian_email_address] // if using CLI

[For read/update, tell the agent what you want to do with the read content or how you want to modify it]
```

## License
MIT
