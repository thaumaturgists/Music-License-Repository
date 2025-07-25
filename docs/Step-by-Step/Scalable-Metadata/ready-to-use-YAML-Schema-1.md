Here’s a ready-to-use YAML Schema for your track metadata, with the `$id` pointing at a typical GitHub raw URL. Just replace `<USER>`, `<REPO>` and the branch (`main` below) with your own.

```yaml
# File: metadata/schemas/track.schema.yaml
$id: "https://raw.githubusercontent.com/<USER>/<REPO>/main/metadata/schemas/track.schema.yaml"
$schema: "http://json-schema.org/draft-07/schema#"
title: "Track Metadata"
description: "Core metadata definition for a musical track in Music-License-Repository"
type: object

required:
  - schemaVersion
  - trackId
  - title
  - artist
  - licenseId
  - duration
  - releaseDate

properties:
  schemaVersion:
    type: string
    pattern: "^\d+\.\d+\.\d+$"
    description: "SemVer for this metadata format (e.g. 1.0.0)"

  trackId:
    type: string
    format: uuid
    description: "UUID for this specific track"

  title:
    type: string
    minLength: 1

  artist:
    type: string
    minLength: 1

  artistId:
    type: string
    format: uuid
    description: "Optional UUID reference to a contributor record"

  album:
    type: string
    description: "Album or collection name"

  genre:
    type: string
    enum:
      - Ambient
      - Classical
      - Electronic
      - Jazz
      - Pop
      - Rock
      - World
      - Other

  mood:
    type: array
    items:
      type: string
      enum:
        - Calm
        - Relaxing
        - Ethereal
        - Uplifting
        - Dark
        - Melancholic
        - Energetic
        - Other
    uniqueItems: true
    minItems: 1

  bpm:
    type: integer
    minimum: 20
    maximum: 300

  key:
    type: string
    pattern: "^[A-G](#|b)?( Major| Minor)?$"

  duration:
    type: integer
    description: "Track length in seconds"
    minimum: 1

  releaseDate:
    type: string
    format: date
    description: "ISO 8601 date"

  licenseStatus:
    type: string
    enum:
      - Draft
      - Evaluation Only
      - License Accepted
      - Published

  licenseId:
    type: string
    format: uuid
    description: "UUID for the license terms governing this track"

  contributors:
    type: array
    items:
      type: string
      format: uuid
    description: "List of UUIDs referencing contributor records"

  tags:
    type: array
    items:
      type: string
    uniqueItems: true

  assets:
    type: object
    properties:
      audio:
        type: array
        items:
          type: string
          format: uri
      sheetMusic:
        type: array
        items:
          type: string
          format: uri
      lyrics:
        type: array
        items:
          type: string
          format: uri
      graphics:
        type: array
        items:
          type: string
          format: uri
    additionalProperties: false

  description:
    type: string
    description: "Optional free-form description of the track"

  metadataExt:
    type: object
    description: "Key–value map for future extensions"
    additionalProperties: true

additionalProperties: false
```

Next steps:

1. Commit this file to `metadata/schemas/track.schema.yaml`.  
2. Add a GitHub Action to run a YAML linter (e.g. Spectral) against it.  
3. Validate every `metadata/data/*.yaml` file in CI to ensure compliance before merge.  
4. Replace `<USER>`, `<REPO>` and `main` in the `$id` URL with your actual GitHub username, repository name, and default branch.