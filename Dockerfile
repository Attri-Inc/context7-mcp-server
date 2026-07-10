# Run published Context7 MCP (npm) via Supergateway streamable HTTP in STATEFUL mode
# (stateful keeps one initialized session per client so tools/list works; no Redis needed).
FROM ghcr.io/supercorp-ai/supergateway:3.4.3
RUN npm install -g @upstash/context7-mcp@3.2.3
EXPOSE 8080
ENTRYPOINT ["supergateway"]
CMD ["--stdio", "context7-mcp", "--port", "8080", "--outputTransport", "streamableHttp", "--streamableHttpPath", "/mcp", "--stateful", "--cors"]
