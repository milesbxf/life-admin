---
description: Process documents in the Paperless inbox — apply tags, correspondent, type, and clean titles
argument-hint: Optional number of documents to process (default: all)
---

Process the Paperless inbox.

Steps:
1. Call `mcp__paperless__list_tags` to find the inbox tag (look for `is_inbox_tag: true`)
2. Call `mcp__paperless__search_documents` filtering by that tag ID to find all inbox documents
3. For each document, spawn the `paperless-processor` agent with the document ID (it handles metadata, title, and summary in one pass)
4. Report back a summary of what was processed and what was applied to each document

If $ARGUMENTS specifies a number, process only that many documents (most recently added first).

Keep the user informed of progress as documents are processed.
