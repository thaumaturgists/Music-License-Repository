# Scalable Metadata Schema Refactor

To support a growing library of musical assets, contributors, and licenses, we’ll normalize and modularize metadata into discrete schemas. This approach improves maintainability, enforces consistency, and makes horizontal scaling—sharding, indexing, caching—much easier.

---

## Core Principles

- Modularization  
  Break metadata into domain-specific schemas (Track, License, Contributor, Asset, Tag).  

- Referential Integrity  
  Use unique IDs and foreign keys rather than embedding repeated data.  

- Extensibility  
  Leverage optional fields, arrays, and key–value “extensions” for future requirements.  

- Validation  
  Define each schema in JSON Schema (or YAML) to automate validation and documentation.

---

## 1. Track Metadata Schema

```jsonc
{
  "$id": "https://example.com/schemas/track.json",
  "type": "object",
  "required": ["trackId", "title", "duration", "licenseId"],
  "properties": {
    "trackId":       { "type": "string", "format": "uuid" },
    "title":         { "type": "string" },
    "duration":      { "type": "integer", "description": "seconds" },
    "tempo":         { "type": "integer", "minimum": 40, "maximum": 250 },
    "key":           { "type": "string", "pattern": "^[A-G][b#]?$" },
    "licenseId":     { "type": "string", "format": "uuid" },
    "contributors":  { "type": "array", "items": { "type": "string", "format": "uuid" } },
    "tags":          { "type": "array", "items": { "type": "string" } },
    "metadataExt":   { "type": "object", "additionalProperties": true }
  }
}
```

---

## 2. License Metadata Schema

| Field           | Type     | Description                                            |
|-----------------|----------|--------------------------------------------------------|
| licenseId       | uuid     | Primary key                                            |
| name            | string   | e.g. “Creative Commons Attribution 4.0 International”  |
| url             | string   | Link to full text                                      |
| allowsDerivative| boolean  | Whether derivatives are allowed                        |
| allowsCommercial| boolean  | Whether commercial use is allowed                      |
| obligations     | array    | e.g. `[“Attribution”, “ShareAlike”]`                   |
| version         | string   | e.g. “4.0”                                             |

---

## 3. Contributor Metadata Schema

```jsonc
{
  "$id": "https://example.com/schemas/contributor.json",
  "type": "object",
  "required": ["contributorId", "name", "roles"],
  "properties": {
    "contributorId": { "type": "string", "format": "uuid" },
    "name":          { "type": "string" },
    "email":         { "type": "string", "format": "email" },
    "roles":         { "type": "array", "items": { "type": "string" } },
    "affiliation":   { "type": "string" },
    "profileUrl":    { "type": "string", "format": "uri" }
  }
}
```

---

## 4. Asset Metadata Schema

- **audioFile**  
  *assetId, fileType (`wav`, `mp3`), duration, checksum, storagePath*  

- **scoreFile**  
  *assetId, format (`LilyPond`, `PDF`), pages, checksum*  

- **imageFile**  
  *assetId, format (`SVG`, `PNG`), dimensions, checksum*  

All `assetId` link back to a central `assets` table for uniform indexing and retrieval.

---

## 5. Thematic Tags & Taxonomy

- **tags** (free-form keywords)  
- **categories** (controlled vocabulary; e.g. `Ambient`, `Ethereal`, `Numerology`)  
- **symbols** (iconography references; e.g. `angel`, `feather`)  

Store tags in a separate `tags` table with usage counts for analytics and auto-suggestion.

---

## 6. Implementation Strategies

1. JSON Schema Registry  
   Host all schemas in a versioned GitHub repo. Automate validation via CI (e.g., GitHub Actions).  
2. Database Layer  
   - Use PostgreSQL with foreign-key constraints for relational integrity.  
   - Consider a document store (MongoDB) for highly variable `metadataExt` fields.  
3. Indexing  
   - Index on `trackId`, `licenseId`, `tags`.  
   - Create GIN indexes for array fields (`tags`, `roles`).  
4. Caching  
   Leverage Redis for hot lookups (e.g., licenses, top-tag queries).  
5. Sharding & Partitioning  
   Partition large tables by date or category to maintain query performance.

---

## Next-Level Enhancements

- Graph Database Integration  
  Represent contributors, tracks, licenses, and tags in Neo4j for advanced relationship queries (e.g., finding all derivative chains).  

- Schema Extensions  
  - Add `reviewStatus`, `approvalDate` to enforce licensing governance workflows.  
  - Embed `usageMetrics` (play counts, downloads) for real-time analytics.  

- Automated Documentation  
  Generate human-readable docs with tools like Redoc or Stoplight from your JSON Schemas.

---

By decoupling concerns and enforcing strict schema validation, you’ll enable effortless scaling—both in data volume and feature complexity—while preserving a clear, maintainable metadata model.