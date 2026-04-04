# Changelog

## [1.0.0] - 2026-03-29

### Functionalities
- Synthesizes the outputs of the specify and plan phases into a coherent, well-structured design document published directly to Confluence — no manual copy-pasting required.

### Added
- `write` — Given a Confluence URL of a workspace, generates and publishes a design doc summarizing the specifications and plans produced so far.

## [1.1.0] - 2026-04-04

### Functionalities
- Synthesizes the outputs of the specify and plan phases into a coherent, well-structured design document published directly to Confluence — no manual copy-pasting required.
- Retrieves the full contents of any existing Confluence page for in-context reference or review.
- Applies targeted updates to an existing Confluence page, incorporating the latest specifications and plans while preserving the document's existing structure.

### Added
- `read` — Given a Confluence URL of a doc, fetches and displays the current contents of an existing page.
- `update` — Given a Confluence URL of a doc, intelligently revises an existing page to reflect the latest specifications and plans without overwriting content wholesale.
