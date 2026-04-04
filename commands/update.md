---
title: Update Confluence Document
description: Modify an existing Confluence document by synthesizing updated specifications and plans into the existing doc. The agent will use judgment to determine what to revise, add, or remove for clarity and accuracy.
---

## Usage and Functionality
Given an Atlassian Confluence URL, update the existing document at that location. Unless otherwise prompted, reflect the latest specifications and plans. The agent will synthesize any new or changed content and apply it intelligently, rather than overwriting wholesale. If the user did not provide any URL or provided one that does not lead to Atlassian Confluence, ask for a valid one.

If this command is being executed in the CLI, you may need to use an Atlassian API token and email address to access the site. If you cannot access Atlassian after about a minute or two, try using the token and email address. Ask for them if not already provided.

Please also be sure to log your updates and progress in the console as you go along.

## Parameters
- **confluence_url** (string, required): the URL of the existing Confluence doc to update
- **atlassian_api_token** (string, required when using CLI): API token to connect to Atlassian when using CLI
- **atlassian_email_address** (string, required when using CLI): the email address for your Atlassian account

### Input template
```
Confluence URL: [confluence_url]
Atlassian API token: [atlassian_api_token] // if using CLI
Atlassian email address: [atlassian_email_address] // if using CLI
```

## Notes
- The agent will use the MCP server to access Confluence. Ensure the MCP server is configured and running (see setup_mcp.sh).
- The agent will use judgment to determine which parts of the document to revise, add, or remove based on the latest specifications and plans.
- Content will be rephrased and synthesized for clarity and conciseness, not copied verbatim.
- For more details and workflow, see the main README.
