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

## Available Tags

- `latest` - Latest build from main branch
- `x.y.z` - Specific upstream version (e.g., `1.0.0`)
- `main` - Latest commit on main branch

## License

This Docker wrapper is provided under MIT license. The underlying Azure DevOps MCP server is maintained by Microsoft under their license terms.
