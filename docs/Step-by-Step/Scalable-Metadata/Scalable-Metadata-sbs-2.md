# Refactored Scalable Metadata Schema

To unify, validate, and scale your track metadata, we’ll introduce a versioned JSON Schema, controlled vocabularies, and a clear separation between schema definitions and data. Below is the proposed structure, schema definition, and example metadata files.

---

## Folder Structure

```text
Music-License-Repository/
├── metadata/
│   ├── schemas/                    # 🎯 Schema definitions
│   │   └── track.schema.json
│   └── data/                       # 🎵 Actual track metadata
│       ├── dreamscape.json
│       └── lullaby.json
└── (other repo folders…)
```

---

## 1. Versioned JSON Schema

File: `metadata/schemas/track.schema.json`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "$id": "https://your-domain.com/schemas/track.schema.json",
  "title": "Track Metadata",
  "description": "Core metadata for a musical track",
  "type": "object",
  "required": [
    "schemaVersion",
    "trackId",
    "title",
    "artist",
    "licenseId",
    "duration",
    "releaseDate"
  ],
  "properties": {
    "schemaVersion": {
      "type": "string",
      "pattern": "^\\d+\\.\\d+\\.\\d+$",
      "description": "SemVer for this metadata format"
    },
    "trackId": {
      "type": "string",
      "format": "uuid",
      "description": "Unique identifier for this track"
    },
    "title": {
      "type": "string",
      "minLength": 1
    },
    "artist": {
      "type": "string",
      "minLength": 1
    },
    "artistId": {
      "type": "string",
      "format": "uuid",
      "description": "Optional reference to a contributor record"
    },
    "album": {
      "type": "string",
      "description": "Album or collection name"
    },
    "genre": {
      "type": "string",
      "enum": [
        "Ambient",
        "Classical",
        "Electronic",
        "Jazz",
        "Pop",
        "Rock",
        "World",
        "Other"
      ]
    },
    "mood": {
      "type": "array",
      "items": {
        "type": "string",
        "enum": [
          "Calm",
          "Relaxing",
          "Ethereal",
          "Uplifting",
          "Dark",
          "Melancholic",
          "Energetic",
          "Other"
        ]
      },
      "uniqueItems": true,
      "minItems": 1
    },
    "bpm": {
      "type": "integer",
      "minimum": 20,
      "maximum": 300
    },
    "key": {
      "type": "string",
      "pattern": "^[A-G](#|b)?( Major| Minor)?$"
    },
    "duration": {
      "type": "integer",
      "description": "Track length in seconds",
      "minimum": 1
    },
    "releaseDate": {
      "type": "string",
      "format": "date",
      "description": "ISO 8601 date"
    },
    "licenseStatus": {
      "type": "string",
      "enum": [
        "Draft",
        "Evaluation Only",
        "License Accepted",
        "Published"
      ]
    },
    "licenseId": {
      "type": "string",
      "format": "uuid"
    },
    "contributors": {
      "type": "array",
      "items": {
        "type": "string",
        "format": "uuid"
      },
      "description": "UUIDs of contributors"
    },
    "tags": {
      "type": "array",
      "items": { "type": "string" },
      "uniqueItems": true
    },
    "assets": {
      "type": "object",
      "properties": {
        "audio": {
          "type": "array",
          "items": { "type": "string", "format": "uri" }
        },
        "sheetMusic": {
          "type": "array",
          "items": { "type": "string", "format": "uri" }
        },
        "lyrics": {
          "type": "array",
          "items": { "type": "string", "format": "uri" }
        },
        "graphics": {
          "type": "array",
          "items": { "type": "string", "format": "uri" }
        }
      },
      "additionalProperties": false
    },
    "description": {
      "type": "string",
      "description": "Optional track description"
    },
    "metadataExt": {
      "type": "object",
      "description": "Key–value map for future extensions",
      "additionalProperties": true
    }
  },
  "additionalProperties": false
}
```

---

## 2. Example Metadata Files

### A. `metadata/data/dreamscape.json`

```json
{
  "schemaVersion": "1.0.0",
  "trackId": "550e8400-e29b-41d4-a716-446655440000",
  "title": "Dreamscape",
  "artist": "Connor",
  "artistId": "a1b2c3d4-5678-90ab-cdef-1234567890ab",
  "genre": "Ambient",
  "bpm": 72,
  "key": "F# Minor",
  "mood": ["Ethereal", "Uplifting"],
  "duration": 240,
  "releaseDate": "2025-07-12",
  "licenseStatus": "Evaluation Only",
  "licenseId": "deadbeef-dead-beef-dead-beefdeadbeef",
  "contributors": [
    "a1b2c3d4-5678-90ab-cdef-1234567890ab"
  ],
  "tags": ["angelic", "feather", "light"],
  "assets": {
    "audio": ["../music/dreamscape/audio/connor-dreamscape.mp3"],
    "sheetMusic": ["../music/dreamscape/sheet-music/connor-dreamscape-sheet-music.pdf"],
    "graphics": ["../music/dreamscape/graphics/connor-dreamscape-album-art.svg"]
  }
}
```

### B. `metadata/data/lullaby.json`

```json
{
  "schemaVersion": "1.0.0",
  "trackId": "660f9511-f39c-42e5-b817-557766880111",
  "title": "Lullaby",
  "artist": "Connor",
  "genre": "Ambient",
  "bpm": 72,
  "key": "D Major",
  "mood": ["Calm", "Relaxing", "Ethereal"],
  "duration": 210,
  "releaseDate": "2025-07-12",
  "description": "A soothing lullaby designed to create a peaceful atmosphere, perfect for relaxation and sleep.",
  "licenseStatus": "License Accepted",
  "licenseId": "cafebab0-cafe-babe-cafe-babecafebabe",
  "tags": ["sleep", "peaceful"],
  "assets": {
    "audio": ["../music/lullaby/audio/connor-lullaby.wav"],
    "sheetMusic": ["../music/lullaby/sheet-music/connor-lullaby-sheet-music.ly"]
  }
}
```

---

## 3. Benefits & Next Steps

- **Validation**  
  Automate schema checks in CI (GitHub Actions) to reject malformed metadata.  

- **Controlled Vocabularies**  
  Enums for `genre`, `mood`, and `licenseStatus` ensure consistency.  

- **Extensibility**  
  `metadataExt` captures future or experimental fields without breaking validation.  

- **Versioning**  
  `schemaVersion` lets you evolve metadata over time with backward compatibility.  

- **Querying & Indexing**  
  Database or search layers can ingest these JSON files directly, index by `trackId`, `tags`, or `licenseStatus`.  

Next, add a workflow to lint and validate all `metadata/data/*.json` against `track.schema.json`. This ensures every PR updates or adds well-formed, consistent track metadata.

# YAML-Based Metadata Schema

To support YAML for both schemas and data files, we’ll mirror the JSON approach in a YAML-native format. This makes it easy for contributors who prefer YAML and integrates seamlessly with YAML linters and validators.

---

## Folder Structure

```text
Music-License-Repository/
├── metadata/
│   ├── schemas/
│   │   └── track.schema.yaml       # YAML version of track schema
│   └── data/
│       ├── dreamscape.yaml         # Track metadata in YAML
│       └── lullaby.yaml            # Track metadata in YAML
└── (other repo folders…)
```

---

## 1. Versioned YAML Schema

File: `metadata/schemas/track.schema.yaml`

```yaml
# YAML Schema Draft-07 representation
$id: "https://your-domain.com/schemas/track.schema.yaml"
$schema: "http://json-schema.org/draft-07/schema#"
title: "Track Metadata"
description: "Core metadata for a musical track"
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
    description: "SemVer for this metadata format"

  trackId:
    type: string
    format: uuid
    description: "Unique identifier for this track"

  title:
    type: string
    minLength: 1

  artist:
    type: string
    minLength: 1

  artistId:
    type: string
    format: uuid
    description: "Optional reference to a contributor record"

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

  contributors:
    type: array
    items:
      type: string
      format: uuid
    description: "UUIDs of contributors"

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
    description: "Optional track description"

  metadataExt:
    type: object
    description: "Key–value map for future extensions"
    additionalProperties: true

additionalProperties: false
```

---

## 2. Example Track Metadata in YAML

### A. `metadata/data/dreamscape.yaml`

```yaml
schemaVersion: "1.0.0"
trackId: "550e8400-e29b-41d4-a716-446655440000"
title: "Dreamscape"
artist: "Connor"
artistId: "a1b2c3d4-5678-90ab-cdef-1234567890ab"
genre: "Ambient"
bpm: 72
key: "F# Minor"
mood:
  - Ethereal
  - Uplifting
duration: 240
releaseDate: "2025-07-12"
licenseStatus: "Evaluation Only"
licenseId: "deadbeef-dead-beef-dead-beefdeadbeef"
contributors:
  - "a1b2c3d4-5678-90ab-cdef-1234567890ab"
tags:
  - angelic
  - feather
  - light
assets:
  audio:
    - "../music/dreamscape/audio/connor-dreamscape.mp3"
  sheetMusic:
    - "../music/dreamscape/sheet-music/connor-dreamscape-sheet-music.pdf"
  graphics:
    - "../music/dreamscape/graphics/connor-dreamscape-album-art.svg"
```

### B. `metadata/data/lullaby.yaml`

```yaml
schemaVersion: "1.0.0"
trackId: "660f9511-f39c-42e5-b817-557766880111"
title: "Lullaby"
artist: "Connor"
genre: "Ambient"
bpm: 72
key: "D Major"
mood:
  - Calm
  - Relaxing
  - Ethereal
duration: 210
releaseDate: "2025-07-12"
description: "A soothing lullaby designed to create a peaceful atmosphere, perfect for relaxation and sleep."
licenseStatus: "License Accepted"
licenseId: "cafebab0-cafe-babe-cafe-babecafebabe"
tags:
  - sleep
  - peaceful
assets:
  audio:
    - "../music/lullaby/audio/connor-lullaby.wav"
  sheetMusic:
    - "../music/lullaby/sheet-music/connor-lullaby-sheet-music.ly"
```

---

## 3. Benefits & Next Steps

- Integrate a YAML schema linter (e.g., Yamale, Spectral) into CI to validate all `*.yaml` against `track.schema.yaml`.  
- Leverage the same enums, patterns, and controlled vocabularies for consistency across JSON and YAML.  
- Use `metadataExt` for ad hoc fields without breaking the core schema.  
- Version your schema (`schemaVersion`) to support future format changes with backward compatibility.  
- Index or ingest these YAML files into your database search layer just like JSON.

Next, add a GitHub Action that runs your chosen YAML linter on every pull request to ensure clean, valid metadata before merge.
