---
title: Write to Confluence
description: Automatically summarize and consolidate all relevant content generated before the task and implementation phases (specifically, specify and plan) into a single, well-structured Confluence document. The agent will select and synthesize the most important information for clarity and conciseness, not simply copy everything verbatim.
---

## Usage and Functionality
After completing the specify and plan phases, create design doc in the location of the provided URL. It will create a design document in Confluence, accessible to your team. Be sure to include the URL to where you want the doc to be. If inital prompt did not provide any URL, ask for one. If the provided URL is an invalid Atlassian Confluence URL, ask the user for a valid one.

## Parameters
- **confluence_url** (string, required): the URL to where the doc will be stored

## Command Template
```
/speckit.confluence.writetoconfluence [confluence_url]
```

## Notes
- The agent will use the MCP server to access Confluence. Ensure the MCP server is configured and running (see setup_mcp.sh).
- The document will contain a synthesized summary of all relevant pre-implementation content, including requirements, goals, constraints, and design rationale.
- The agent will use judgment to select and rephrase content for clarity and conciseness.
- For more details and workflow, see the main README.
