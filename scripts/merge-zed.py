#!/usr/bin/env python3
"""Merge public Zed base settings with the local MCP snippet into one file.
Usage: merge-zed.py <base.json> <mcp-snippet.json> <out.json>
Line-based (JSONC-safe): injects context_servers as the first key."""
import sys
base_fn, mcp_fn, out_fn = sys.argv[1:4]
base = open(base_fn).read().split("\n")
mcp  = open(mcp_fn).read().rstrip("\n").split("\n")
i = next(idx for idx, l in enumerate(base) if l.strip().startswith("{"))
out = base[: i + 1] + mcp + base[i + 1 :]
open(out_fn, "w").write("\n".join(out))
