# Chroma MCP — Operational Notes

## What it is

A local vector database MCP server. Stores embeddings of text content and supports similarity search — the building block for RAG (retrieval-augmented generation) over a knowledge library.

- **Source:** https://github.com/chroma-core/chroma-mcp
- **PyPI package:** `chroma-mcp`
- **License:** Apache-2.0
- **Author:** Chroma (official)

## What it does

Tools provided:

- `create_collection`, `list_collections`, `delete_collection`
- `add_documents` — ingest text with metadata, generates embeddings automatically
- `query_collection` — similarity search ("give me the K most relevant docs to this query")
- `update_documents`, `delete_documents`

The agent can store any text — brand books, podcast transcripts, prior client deliverables, blog posts, source documents — and later retrieve the most relevant chunks for any query without you re-pasting them into the prompt.

## Why this is high-value

Most AI knowledge libraries are too large to fit in any single Claude context window. Chroma lets the agent:

- Store every brand book, source doc, and transcript once
- At query time, retrieve only the relevant chunks for the current task
- Keep brand voice consistent across drafts because the relevant style guides are always reachable

This is a one-time ingestion, then a recurring query benefit. The investment-to-payoff ratio is high if the library is meaningful in size (typically: multiple mounted folders of business and brand content).

## Installation

Automated:

```bash
bash scripts/06-install-mcp-chroma.sh
```

What the script does:
1. Reads `CHROMA_DB_PATH` from `client.env`
2. Creates the directory if missing
3. Installs `chroma-mcp` via pipx or `pip --user`
4. Registers with Claude Code with `CHROMA_DB_PATH` as an env var
5. If `OPENAI_API_KEY_FOR_EMBEDDINGS` is set, configures OpenAI embeddings; otherwise uses the local default model

## Embedding model decision

Two options, configured via `client.env`:

**Option A — local default model (recommended start)**
- Pros: zero external dependency, no API key, no per-token cost, fully self-contained
- Cons: slower ingestion, slightly lower retrieval quality
- Set `OPENAI_API_KEY_FOR_EMBEDDINGS=""` (empty) in `client.env`

**Option B — OpenAI embeddings**
- Pros: faster, higher retrieval quality
- Cons: requires an OpenAI key, costs ~$0.0001 per 1k tokens of ingestion
- Set `OPENAI_API_KEY_FOR_EMBEDDINGS="sk-..."` in `client.env`

Note: if you already pay for OpenAI separately, Option B is available without adding new vendor relationships. Local default model is still the cleanest start.

## Verification

```bash
claude mcp list | grep chroma
```

In a Claude Code session:

```
> Use chroma to create a collection called "test-collection"
> Then add a document with content "the quick brown fox" and metadata {"source": "test"}
> Then query the collection for "fox" and return the top 1 result
```

If round-trips correctly, the server works.

## Initial ingestion of the knowledge library

After install, the next step is one-time bulk ingestion. From a Claude Code session on the VPS:

```
> Create a chroma collection named "knowledge-library"
> Use the filesystem tool to walk these directories:
>   <list of directories from KNOWLEDGE_LIBRARY_ROOTS>
> For each markdown file, read it, chunk it ~1000 tokens with 100-token overlap,
> and add each chunk to the chroma collection with metadata
> {source_path, chunk_index, total_chunks}
```

This is a one-time investment. After it completes, the agent can query the library natively.

For most stacks, the candidate ingestion source is whatever knowledge-library directories are already mounted in the workspace.

## Backup

The Chroma directory at `CHROMA_DB_PATH` contains all embeddings. Re-generating from source documents is possible but slow. Back it up like any other database:

```cron
0 4 * * * tar czf ${CHROMA_DB_PATH}.$(date +\%Y\%m\%d).tar.gz ${CHROMA_DB_PATH} && find $(dirname ${CHROMA_DB_PATH}) -name "chroma_db*.tar.gz" -mtime +30 -delete
```

## Resource considerations

- **Disk:** Embeddings are bigger than source text (~3-5x for the local model)
- **RAM:** Loads index into memory; budget ~200 MB for a moderately-sized library
- **Ingestion time:** Local model: ~50-100 docs/second; OpenAI: faster but capped by API rate limits

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `chroma-mcp` not found | pip --user bin not on PATH | Use absolute path (script handles this) |
| "OPENAI_API_KEY required" error | Embedding provider config wrong | Either set the key in client.env or unset to use local model |
| Slow query | Index too large for VPS RAM | Size up VPS or shard collections |
| Inconsistent retrievals | Different embedding model than originally used | Re-ingest if you switch embedding providers |

## Related files in this repo

- `scripts/06-install-mcp-chroma.sh` — installer
- `config/client.example.env` — `CHROMA_DB_PATH` and `OPENAI_API_KEY_FOR_EMBEDDINGS`
