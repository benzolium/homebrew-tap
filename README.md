# Homebrew Tap for Raskraska

This tap provides the CLI formula for Raskraska:

<https://github.com/benzolium/raskraska>

## Install

```bash
brew install benzolium/tap/raskraska
```

## Upgrade

```bash
brew update
brew upgrade raskraska
```

## Uninstall

```bash
brew uninstall raskraska
```

## Maintainer Update Flow

After publishing a new `vX.Y.Z` tag in the main repository, update this
formula from the tap checkout:

```bash
scripts/update-raskraska-formula.sh vX.Y.Z
brew style Formula/raskraska.rb
git add Formula/raskraska.rb
git commit -m "Update raskraska to vX.Y.Z"
git push
brew update
brew audit --formula benzolium/tap/raskraska
brew fetch benzolium/tap/raskraska
brew install --build-from-source benzolium/tap/raskraska
brew test benzolium/tap/raskraska
```
