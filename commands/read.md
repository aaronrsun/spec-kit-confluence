---
title: Read from Confluence
description: Retrieve and display the contents of an existing Confluence document by URL.
---

## Usage and Functionality
Given an Atlassian Confluence URL, fetch and display the contents of the existing document at that location. If the user did not provide any URL or provided one that does not lead to Atlassian Confluence, ask for a valid one.

If this command is being executed in the CLI, you may need to use an Atlassian API token and email address to access the site. If you cannot access Atlassian after about a minute or two, try using the token and email address. Ask for them if not already provided.

Unless otherwise prompted, please summarize what's in the doc and, if possible, update the files generated from the specify, plan, and task agents/commands, or create them if they do not already exist.

Please also be sure to log your updates and progress in the console as you go along.

## Parameters
- **confluence_url** (string, required): the URL of the existing Confluence doc to read
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
- The document contents will be displayed as-is from Confluence.
- For more details and workflow, see the main README.
