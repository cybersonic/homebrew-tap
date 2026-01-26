# LuCLI Homebrew Tap

⚠️ This tap is in active development and might not work on your system 

This repository provides a Homebrew tap for installing **LuCLI**, a CLI for Lucee CFML.

The tap defines a single formula, `lucli`, which installs prebuilt LuCLI binaries for macOS and Linux.

## Installation

### 1. Add the tap

Replace `<owner>` with the actual GitHub owner for this tap (for example, `cybersonic` or your GitHub username):

```bash
brew tap cybersonic/homebrew-tap
```

### 2. Install LuCLI

Once the tap is added, install LuCLI:

```bash
brew install lucli
```

To force a build from the current formula definition in this repo (useful when developing the tap locally):

```bash
# From the repository root
brew install --build-from-source ./Formula/lucli.rb
```

## Usage

After installation, LuCLI should be available on your `PATH` as `lucli`:

```bash
lucli --help
lucli --version
```

## Development (for tap maintainers)

From the repository root:

- Run the formula's test block:

  ```bash
  brew test --verbose lucli
  ```

- Run Homebrew audit checks on the formula:

  ```bash
  brew audit --strict --online lucli
  ```
