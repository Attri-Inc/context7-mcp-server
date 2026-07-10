# Run the published Context7 MCP server (npm) wrapped in Supergateway streamable HTTP.
# Context7 upstream is now a pnpm monorepo; the published package is the supported entrypoint.
FROM ghcr.io/supercorp-ai/supergateway:3.4.3
RUN npm install -g @upstash/context7-mcp@3.2.3
EXPOSE 8080
ENTRYPOINT ["supergateway"]
CMD ["--stdio", "context7-mcp", "--port", "8080", "--outputTransport", "streamableHttp", "--streamableHttpPath", "/mcp", "--cors"]
