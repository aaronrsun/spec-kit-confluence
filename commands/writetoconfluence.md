---
title: Write to Confluence
description: Automatically summarize and consolidate all relevant content generated before the task and implementation phases (specifically, specify and plan) into a single, well-structured Confluence document. The agent will select and synthesize the most important information for clarity and conciseness, not simply copy everything verbatim.
---

## Usage
Use this command after completing your planning, requirements gathering, and design discussions (before implementation begins). It will create a design document in Confluence, accessible to your team.

## Parameters
- **confluenceSpace** (string, required): The Confluence space key where the document will be created.
- **parentPageId** (string, optional): The parent page ID under which the new document will be created.
- **title** (string, required): The title of the Confluence document.
- **tags** (array, optional): Tags or labels to add to the Confluence page.

## Example
```yaml
command: writetoconfluence
confluenceSpace: "ENG"
parentPageId: "123456" # optional
title: "Design: New Feature X"
tags: ["design", "spec-kit", "summary"] # optional
```

## Notes
- The agent will use the MCP server to access Confluence. Ensure the MCP server is configured and running (see setup_mcp.sh).
- The document will contain a synthesized summary of all relevant pre-implementation content, including requirements, goals, constraints, and design rationale.
- The agent will use judgment to select and rephrase content for clarity and conciseness.
- For more details and workflow, see the main README.
