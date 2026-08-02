# argocd-mcp-docker

Harbor-published wrapper image around [`argoproj-labs/mcp-for-argocd`](https://github.com/argoproj-labs/mcp-for-argocd) (npm package `argocd-mcp`), pinned to v0.8.0 and started in streamable-HTTP mode (`argocd-mcp http --port 8080`) so it's reachable as an OWUI MCP tool server.

Deploy manifests live in the sibling repo [`dvystrcil/argocd-mcp`](https://github.com/dvystrcil/argocd-mcp) (three-repo split — see `architecture/owui-extensibility-mechanisms.md` in `dvystrcil/homelab`).

## Auth

The upstream server itself does no read/write scoping — whatever `ARGOCD_API_TOKEN` can do, the tool can do. This homelab wires it up with a **read-only ArgoCD RBAC role** (`applications`/`logs` get+list only, no `sync`/`create`/`update`/`delete`/`action`). See `dvystrcil/homelab#815` for the RBAC policy and live verification receipt.

## Endpoints (upstream, v0.8.0)

- `GET /healthz` — health check
- `GET|POST /mcp` — MCP streamable-HTTP endpoint

## Build

```bash
docker build -t argocd-mcp .
docker run -p 8080:8080 -e ARGOCD_BASE_URL=<url> -e ARGOCD_API_TOKEN=<token> argocd-mcp
```

## License

[MIT](LICENSE) — see LICENSE. This repo only wraps upstream's published npm package; it carries none of upstream's own code.
