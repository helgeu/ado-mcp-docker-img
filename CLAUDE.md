# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project creates a Docker image that wraps the official Microsoft Azure DevOps MCP server (`@azure-devops/mcp` npm package). The goal is to provide containerized access to the MCP server with automated builds that track upstream releases.

## Build Commands

```bash
# Build the Docker image
docker build -t azure-devops-mcp .

# Build with a specific upstream version
docker build --build-arg ADO_MCP_VERSION=1.0.0 -t azure-devops-mcp .

# Run locally (requires .env file)
cp .env.example .env  # then edit with real values
docker-compose up
```

## Testing

```bash
# Test that the image builds successfully
docker build -t azure-devops-mcp:test .

# Test that it starts (will error without valid credentials, but should launch)
docker run --rm -e ADO_ORG=test azure-devops-mcp:test
```

## Architecture

- **Dockerfile**: Alpine-based Node.js 20 image that installs `@azure-devops/mcp` globally
- **docker-compose.yml**: Local development configuration with environment variable passthrough
- **.github/workflows/build-and-push.yml**: CI/CD pipeline that:
  - Builds on push to main
  - Checks daily for upstream npm releases
  - Auto-tags when new upstream versions are detected
  - Pushes to GitHub Container Registry (ghcr.io)
- **.github/workflows/test.yml**: PR validation workflow

## Key Design Decisions

1. **Alpine base image** - Smaller image size
2. **Non-root user** - Security best practice
3. **Global npm install** - Simplifies entrypoint, avoids npx overhead
4. **Environment variable auth** - Uses `--authentication envvar` flag with `ADO_MCP_AUTH_TOKEN`
5. **Stdio transport** - MCP servers communicate via stdin/stdout, hence `-i` flag when running

## Upstream Dependency

The upstream package is `@azure-devops/mcp` from https://github.com/microsoft/azure-devops-mcp. The GitHub Action checks npm registry daily for new versions.
