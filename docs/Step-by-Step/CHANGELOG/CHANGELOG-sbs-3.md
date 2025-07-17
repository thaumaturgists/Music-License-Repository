# CATHELP
==================================================
```
This is the project structure
``Project structure``7-17-2025
This is the current CHANGELOG.md
``CHANGELOG.md``7-17-2025
This is the update-changelog.yml
``update-changelog.yml``7-17-2025
fix CHANGELOG.md and update-changelog.yml, CHANGELOG needs timestamps and better format and index.
```
==================================================

# 📜 CHANGELOG

All notable changes to this repository will be documented here.  

This format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).  

---

## Table of Contents

- [Unreleased](#unreleased)  
- [1.0.0 – 2025-07-14](#100-–-2025-07-14)  

---

## [Unreleased]

> Changes that are in progress and not yet released.

### 2025-07-17

- Added or Modified Files:  
  - audio/your-song-name/…  
  - lyrics/your-song-name/…  
  - metadata/…  
  - license-forms/…

---

## [1.0.0] – 2025-07-14

### Added

- Initial audio uploads: `dreamscape.mp3`, `lullaby.wav`  
- Corresponding lyrics files  
- `LICENSE_ACCEPTED.md` workflow and GitHub Actions  
- Custom Music License Agreement (`LICENSE.md`)  
- Contributor guidelines (`CONTRIBUTING.md`)  
- Folder structure for audio, lyrics, license-forms, and metadata  

### Configuration

- `CODEOWNERS` file  
- Protected branch ruleset for licensing governance  

---

# YAML: `.github/workflows/update-changelog.yml`

This workflow appends a dated list of file changes under the **[Unreleased]** section every time you push to **main**. It skips CI-trigger loops by only committing when there’s something new.

```yaml
name: Auto Update CHANGELOG

on:
  push:
    branches:
      - main

jobs:
  changelog-update:
    runs-on: ubuntu-latest

    steps:
      - name: Check out repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 2

      - name: Generate changed files list
        id: detect
        run: |
          git diff --name-only ${{ github.event.before }} ${{ github.sha }} > files.txt
          echo "::set-output name=has_changes::$(if grep -qE '^(audio/|lyrics/|metadata/|license-forms/)' files.txt; then echo 'true'; else echo 'false'; fi)"

      - name: Append to CHANGELOG under [Unreleased]
        if: steps.detect.outputs.has_changes == 'true'
        run: |
          TODAY=$(date +'%Y-%m-%d')
          # Insert a new dated subsection immediately after "## [Unreleased]"
          awk -v date="$TODAY" '
            BEGIN { inserted=0 }
            /^## \[Unreleased\]/ && !inserted {
              print
              print ""
              print "### " date
              print "- Added or Modified Files:"
              while ((getline line < "files.txt") > 0) print "- " line
              print ""
              inserted=1
              next
            }
            { print }
          ' CHANGELOG.md > tmp && mv tmp CHANGELOG.md

      - name: Commit & push changelog update
        if: steps.detect.outputs.has_changes == 'true'
        run: |
          git config --global user.name "Auto Changelog Bot"
          git config --global user.email "noreply@example.com"
          git add CHANGELOG.md
          git commit -m "chore: update CHANGELOG for $TODAY" || echo "No changes to commit"
          git push https://x-access-token:${{ secrets.GITHUB_TOKEN }}@github.com/${{ github.repository }} HEAD:main
```

---

With this setup:

- **CHANGELOG.md** now has a clear index, proper timestamps, and clean sections.  
- **update-changelog.yml** safely injects new entries into the **[Unreleased]** block whenever relevant files change.  

Let me know if you’d like to refine category grouping (e.g., separate “Audio” vs. “Metadata”), or if you want to automate version bumping once you’re ready to cut a new release!

