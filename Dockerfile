# Azure DevOps MCP Server Docker Image
# Wraps the official Microsoft azure-devops-mcp npm package
# https://github.com/microsoft/azure-devops-mcp

FROM node:20-alpine

LABEL org.opencontainers.image.title="Azure DevOps MCP Server"
LABEL org.opencontainers.image.description="Docker image wrapping the official Microsoft Azure DevOps MCP server"
LABEL org.opencontainers.image.source="https://github.com/microsoft/azure-devops-mcp"
LABEL org.opencontainers.image.licenses="MIT"

# Install the official Azure DevOps MCP package globally
# Using specific version tag allows for reproducible builds
ARG ADO_MCP_VERSION=latest
RUN npm install -g @azure-devops/mcp@${ADO_MCP_VERSION}

# Create non-root user for security
RUN addgroup -g 1001 -S mcp && \
    adduser -u 1001 -S mcp -G mcp

USER mcp

# The organization name must be provided at runtime
# Example: docker run -e ADO_ORG=myorg -e ADO_MCP_AUTH_TOKEN=xxx image-name
ENV ADO_ORG=""
ENV ADO_MCP_AUTH_TOKEN=""

# MCP servers use stdio transport
ENTRYPOINT ["sh", "-c", "mcp-server-azuredevops ${ADO_ORG} --authentication envvar"]
