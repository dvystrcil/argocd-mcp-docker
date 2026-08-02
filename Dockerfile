# Wraps argoproj-labs/mcp-for-argocd's published npm package (`argocd-mcp`)
# as a streamable-HTTP MCP server for OWUI. Upstream's CLI (v0.8.0) exposes
# `argocd-mcp http --port <n>` with a `/healthz` route and the MCP endpoint
# at `/mcp` (confirmed by reading src/server/transport.ts and src/cmd/cmd.ts
# at that tag -- the abandoned first attempt at this image used the wrong
# subcommand, `http-stream`, which only existed in the 0.4.x line).
FROM node:24-alpine

ARG ARGOCD_MCP_VERSION=0.8.0

RUN mkdir -p /home/node/.npm-global \
    && chown -R node:node /home/node

USER node
ENV HOME=/home/node
ENV npm_config_prefix=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:${PATH}"

RUN npm install -g "argocd-mcp@${ARGOCD_MCP_VERSION}"

EXPOSE 8080
ENTRYPOINT ["argocd-mcp", "http", "--port", "8080"]
