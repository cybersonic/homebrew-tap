# Homebrew Tap for LuCLI and Markspresso

⚠️ This tap is in active development and might not work on your system

This repository provides a Homebrew tap for installing:
- **LuCLI** (`lucli`) — a CLI for Lucee CFML
- **Markspresso** (`markspresso`) — a CLI for static site generation

## Installation

### 1. Add the tap

Add this tap once:

```bash
brew tap cybersonic/tap
```

(`cybersonic/tap` is shorthand for `cybersonic/homebrew-tap`.)

### 2. Install formulas

Install LuCLI:

```bash
brew install lucli
```

Install Markspresso:

```bash
brew install markspresso
```

If you want to force this tap explicitly (avoiding name collisions with other taps), use:

```bash
brew install cybersonic/tap/lucli
brew install cybersonic/tap/markspresso
```

To install from the local formula files while developing this tap:

```bash
# From the repository root
brew install --build-from-source ./Formula/lucli.rb
brew install --build-from-source ./Formula/markspresso.rb
```

## Usage

After installation, LuCLI should be available on your `PATH` as `lucli`:

```bash
lucli --help
lucli --version
```

After installation, Markspresso should be available on your `PATH` as `markspresso`:

```bash
markspresso --help
markspresso --version
```

## Development (for tap maintainers)

From the repository root:
- Run the formulas' test blocks:

  ```bash
  brew test --verbose lucli
  brew test --verbose markspresso
  ```

- Run Homebrew audit checks:

  ```bash
  brew audit --strict --online lucli
  brew audit --strict --online markspresso
  ```

## Automation (reusable GitHub Actions workflow)

This tap includes a reusable workflow at `.github/workflows/update-formula.yml` that updates a formula from a GitHub release and opens a PR automatically.

### Trigger modes

- `workflow_call` (recommended): called from upstream release workflows (e.g. LuCLI or markspresso repos).
- `workflow_dispatch`: manual runs from this tap repo's Actions tab.

### Required caller inputs

- `formula_name`: formula file name without extension (`lucli`, `markspresso`).
- `formula_type`:
  - `os_split` for formulas with separate macOS/Linux release assets.
  - `single_asset` for formulas with one release asset.
- `release_repo`: upstream repository (`owner/repo`).
- `version`: release version (with or without a leading `v`).

Optional inputs include `release_tag`, `asset_name`, `macos_asset_name`, `linux_asset_name`, `tap_repository`, and `pr_base_branch`.

### Authentication for cross-repo calls

When calling this workflow from another repository, pass `tap_repo_token` with write access to `cybersonic/homebrew-tap`.

### Example: LuCLI caller workflow

```yaml
name: Update Homebrew tap (LuCLI)

on:
  release:
    types: [published]

jobs:
  update-tap:
    uses: cybersonic/homebrew-tap/.github/workflows/update-formula.yml@main
    with:
      formula_name: lucli
      formula_type: os_split
      release_repo: cybersonic/LuCLI
      version: ${{ github.event.release.tag_name }}
    secrets:
      tap_repo_token: ${{ secrets.HOMEBREW_TAP_TOKEN }}
```

### Example: markspresso caller workflow

```yaml
name: Update Homebrew tap (markspresso)

on:
  release:
    types: [published]

jobs:
  update-tap:
    uses: cybersonic/homebrew-tap/.github/workflows/update-formula.yml@main
    with:
      formula_name: markspresso
      formula_type: single_asset
      release_repo: cybersonic/markspresso
      version: ${{ github.event.release.tag_name }}
      asset_name: markspresso
    secrets:
      tap_repo_token: ${{ secrets.HOMEBREW_TAP_TOKEN }}
```
