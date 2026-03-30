---
title: Write to Confluence
description: Automatically summarize and consolidate all relevant content generated before the task and implementation phases (specifically, specify and plan) into a single, well-structured Confluence document. The agent will select and synthesize the most important information for clarity and conciseness, not simply copy everything verbatim.
---

## Usage and Functionality
Given a Atlassian Confluence URL, create a doc summarizing the generated specifications and plans after completing the specify and plan phases. If the user did not provide any URL or provided one that does not lead to Atlassian Confluence, ask for valid one.

Additionally, if this command is being executed in the CLI, you may need to use an Atlassian API token and email address to access the site. If you cannot access Atlassian after about a minute or two, trying using the token and email address. Ask for them if not already provided.

Please also be sure to log your updates and progress in the console as you go along.

## Parameters
- **confluence_url** (string, required): the URL to where the doc will be stored
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
- The document will contain a synthesized summary of all relevant pre-implementation content, including requirements, goals, constraints, and design rationale.
- The agent will use judgment to select and rephrase content for clarity and conciseness.
- For more details and workflow, see the main README.
