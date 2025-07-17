```yaml
# File: .github/workflows/auto-update-track-schema-url.yml

name: Auto-Update Schema $id URL

on:
  push:
    branches:
      - main
    paths:
      - metadata/schemas/track.schema.yaml
  schedule:
    - cron: '0 2 * * 1'   # weekly, every Monday at 02:00 UTC

jobs:
  update-schema-url:
    runs-on: ubuntu-latest
    outputs:
      updated: ${{ steps.check.outputs.changed }}
    steps:

      - name: Checkout repository (full history)
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Set up Git identity
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"

      - name: Read current schema file
        id: read
        run: |
          echo "::set-output name=content::$(sed 's/"/\\"/g' metadata/schemas/track.schema.yaml)"

      - name: Update $id placeholder
        id: update
        run: |
          ORG_REPO="${{ github.repository }}"
          RAW_URL="https://raw.githubusercontent.com/${ORG_REPO}/${{ github.ref_name }}/metadata/schemas/track.schema.yaml"
          echo "Replacing placeholder with ${RAW_URL}"
          sed -i "s|https://raw\.githubusercontent\.com/<USER>/<REPO>/main/metadata/schemas/track.schema.yaml|${RAW_URL}|g" metadata/schemas/track.schema.yaml
          # detect whether file changed
          if git diff --quiet; then
            echo "::set-output name=changed::false"
          else
            echo "::set-output name=changed::true"
          fi

      - name: Commit & push changes
        if: steps.update.outputs.changed == 'true'
        run: |
          git add metadata/schemas/track.schema.yaml
          git commit -m "chore: auto-update track.schema.yaml $id to ${{ github.repository }}/${{ github.ref_name }}"
          git push

      - name: No changes needed
        if: steps.update.outputs.changed == 'false'
        run: echo "Schema $id URL is already up to date."
```

Explanation of key parts:

- Triggers  
  • On `push` to `main` when the schema file is modified.  
  • Weekly schedule (you can adjust the cron).  

- Steps  
  1. Checkout full history (needed for diff detection).  
  2. Configure Git author for automated commits.  
  3. Compute the raw URL from `${{ github.repository }}` and `${{ github.ref_name }}`.  
  4. Use `sed` to replace the placeholder  
     `https://raw.githubusercontent.com/<USER>/<REPO>/main/metadata/schemas/track.schema.yaml`  
     with the real URL.  
  5. If there’s a change, commit and push it back to `main`.  

Feel free to tweak:

- Replace the placeholder regex if you used a different pattern.  
- Change branches, schedules, or commit messages.  
- Extend with additional steps (e.g., schema linting) before committing.
