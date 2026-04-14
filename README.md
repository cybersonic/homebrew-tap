# LuCLI Homebrew Tap

Homebrew tap for installing [LuCLI](https://github.com/cybersonic/LuCLI), a CLI for Lucee CFML.

## Installation

```bash
brew tap cybersonic/tap
brew install lucli
```

## Usage

```bash
lucli --help
lucli --version
```

## What gets installed

- **LuCLI binary** — installed to `$(brew --prefix)/opt/lucli/libexec/lucli`
- **Java 21** — installed automatically as a dependency (`openjdk@21`)
- **Wrapper script** — `lucli` in your PATH sets `JAVA_HOME` and delegates to the binary

## Updating

```bash
brew update
brew upgrade lucli
```

The formula is automatically kept in sync with [cybersonic/LuCLI releases](https://github.com/cybersonic/LuCLI/releases) via a daily GitHub Actions workflow.

## Development

```bash
brew install --build-from-source ./Formula/lucli.rb   # test install locally
brew test lucli                                         # run formula tests
brew audit --strict ./Formula/lucli.rb                  # lint the formula
```
