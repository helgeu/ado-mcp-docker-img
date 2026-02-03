# Azure DevOps MCP Docker Image

Docker image wrapping the official [Microsoft Azure DevOps MCP server](https://github.com/microsoft/azure-devops-mcp).

## Quick Start

```bash
docker pull ghcr.io/helgeu/ado-mcp-docker-img:latest

docker run -i --rm \
  -e ADO_ORG=your-organization \
  -e ADO_MCP_AUTH_TOKEN=your-pat-token \
  ghcr.io/helgeu/ado-mcp-docker-img:latest
```

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ADO_ORG` | Yes | Azure DevOps organization name |
| `ADO_MCP_AUTH_TOKEN` | Yes | Personal Access Token |

### Creating a Personal Access Token

1. Go to `https://dev.azure.com/{organization}/_usersSettings/tokens`
2. Create a new token with scopes based on your needs:
   - **Work Items**: Read & Write
   - **Code**: Read
   - **Build**: Read
   - **Release**: Read

## Usage with Claude Desktop

Add to your Claude Desktop MCP configuration (`~/.claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "azure-devops": {
      "command": "docker",
      "args": [
        "run", "-i", "--rm",
        "-e", "ADO_ORG=your-organization",
        "-e", "ADO_MCP_AUTH_TOKEN=your-pat-token",
        "ghcr.io/helgeu/ado-mcp-docker-img:latest"
      ]
    }
  }
}
```

## Building Locally

```bash
# Build with latest version
docker build -t azure-devops-mcp .

# Build with specific version
docker build --build-arg ADO_MCP_VERSION=1.0.0 -t azure-devops-mcp .

# Using docker-compose
cp .env.example .env
# Edit .env with your values
docker-compose build
```

## Automated Updates

This repository uses GitHub Actions to:
- Build and push images on every commit to `main`
- Check daily for new upstream releases
- Automatically tag and build new versions when upstream updates

## Managing Workflows with GitHub CLI

```bash
# List workflows and their status
gh workflow list

# List recent workflow runs
gh run list --limit 5

# Manually trigger a build
gh workflow run "Build and Push Docker Image"

# Trigger build with specific version
gh workflow run "Build and Push Docker Image" -f ado_mcp_version=2.4.0

# Watch a running workflow
gh run watch

# View logs from the latest run
gh run view --log

# View logs from a failed run
gh run view --log-failed

# Check upstream npm package version
npm view @azure-devops/mcp version
```

## Available Tags

- `latest` - Latest build from main branch
- `x.y.z` - Specific upstream version (e.g., `2.4.0`)
- `main` - Latest commit on main branch

## License

This Docker wrapper is provided under MIT license. The underlying Azure DevOps MCP server is maintained by Microsoft under their license terms.
