# <img src="https://raw.githubusercontent.com/thaumaturgists/SDCM/main/images/MusicLicenseRepository/Logos/UTC-Large.png" alt="Music License Repository Image" width="32"> Music-License-Repository

[![License](https://img.shields.io/badge/license-Custom%20Music%20License-brightgreen)](./LICENSE)

<img src="https://raw.githubusercontent.com/thaumaturgists/Music-License-Repository/main/legal-paper-icon.png" alt="License Repository Image" width="200"> <!-- Adjust width and height as needed -->

Welcome to the **Music-License-Repository**, a secure platform for sharing and licensing original music. This repository provides artists with a lightweight licensing framework that safeguards their work while encouraging ethical reuse and collaboration.

---

## 📁 Recommended Folder Structure

```plaintext
Music-License-Repository/
├── docs/                            # 📚 General documentation
├── music/
│   ├── your-song-name/
│   │   ├── audio/                   # 🎵 Music files (MP3, WAV, FLAC)
│   │   │   └── your-name_your-song.mp3
│   │   ├── graphics/                # 🎨 Visual assets (SVG)
│   │   │   ├── your-name_album-art.svg
│   │   │   └── your-name_logo.svg
│   │   ├── docs/                    # 📄 Documentation (PDF)
│   │   │   ├── your-name_contract.pdf
│   │   │   └── your-name_user-guide.pdf
│   │   ├── sheet-music/             # 🎼 Music notation
│   │   │   ├── your-name_your-song.ly
│   │   │   └── your-name_your-song.pdf       # 📄 PDF sheet music
│   │   ├── midi/                    # 🎹 MIDI files
│   │   │   └── your-name_your-song.mid
│   │   ├── lyrics/                  # 📝 Lyrics files
│   │   │   └── your-name_your-song.txt
│   │   ├── project-files/           # 🛠️ DAW project files
│   │   │   └── your-name_your-song.als       # 🎚️ Example for Ableton Live
│   │   └── soundfonts/              # 🎶 Sound font files
│   │       └── your-name_your-song.sf2       # 🎵 Example sound font file
│   └── your-next-song/
│       └── audio/                   # 🎵 Next Music files (MP3, WAV, FLAC)
│           └──...
├── metadata/                        # ℹ️ Track information
│   ├── your-song                    
│   ├── dreamscape.json
│   └── lullaby.yaml
├── license-forms/                   # 📝 License acceptance submissions
│   ├── user123_LICENSE_ACCEPTED.md
│   └── alice_LICENSE_ACCEPTED.md
├── LICENSE_ACCEPTED.md              # ✅ Used for workflow
├── LICENSE.md                       # 📜 Music License Agreement
├── CONTRIBUTING.md                  # 🤝 Contribution guidelines
├── README.md                        # 📖 Project overview
└── .github/
    ├── workflows/
    │   └── license-check.yml        # ⚙️ GitHub Actions workflow
    └── CODEOWNERS                   # 👥 Ownership settings
```

---

## 🧭 Metadata Format Example (`dreamscape.json`)

```json
{
  "title": "Dreamscape",
  "artist": "Connor",
  "genre": "Ambient",
  "bpm": 72,
  "key": "F# Minor",
  "mood": ["ethereal", "uplifting"],
  "licenseStatus": "Evaluation Only"
}
```

---

## 🧩 Bonus: Add Tags in README Index

You can display uploaded works with visual icons or tags, like:

| Track        | File        | Lyrics       | License Status    | Mood         |
|--------------|-------------|--------------|--------------------|--------------|
| Dreamscape   | ✅ MP3       | ✅ TXT        | 🚫 Pending Consent | 🌌 Ethereal  |
| Lullaby      | ✅ WAV       | ✅ Markdown   | ✅ Licensed        | 😌 Calm      |

---

## 🚀 Getting Started

To upload your own music and take advantage of this licensing model:

1. **Fork This Repo**  
2. **Replace Placeholder Info**  
   Update `[Your Name]`, `[Effective Date]`, `[Contact Info]`, and other bracketed fields in both the `README.md` and `LICENSE` file.  
3. **Upload Your Music Files**  
   Include MP3, WAV, or other audio formats alongside lyric sheets (optional).
4. **Review the License Terms**  
   Make sure your audience understands your licensing rules before they use your work.

---

## 🎼 Uploading Your Music

Users may upload the following types of content:

- 🎤 **Lyrics** — plain text or formatted files  
- 🎧 **Audio files** — MP3, WAV, FLAC, etc.  
- 📄 **License Agreement** — a customized version of the provided license

**Filename Convention**:  
`[Your Repository Name] - [Song Title].[mp3|wav|txt]`

---

## 📜 Licensing Terms Summary

This repository is governed by the **Custom Music License Agreement** located in the [LICENSE](./LICENSE) file.

### ✅ Evaluation-Only Rights
Without written permission, users may:
- Clone or fork this repo for personal, non-commercial exploration  
- Preview music using GitHub's interface or local playback

### 🚫 Restricted Uses (Require Written Consent)
- Commercial use in advertisements, apps, or monetized content  
- Public performance, broadcast, or live events  
- Synchronization with video, games, or interactive media  
- Remixes, sampling, or derivative works  
- Redistribution in any form

### ✍️ Attribution Format
If permission is granted, users must credit you like this:  
> “Music by [Your Name]”

### 📧 License Requests
To request permission, reach out via `[Your Contact Info]`. Licenses are granted on a per-work basis.

---

## ⚖️ Legal Details

- Jurisdiction: `[Insert Your Jurisdiction]`  
- All rights revert to the Licensor upon termination  
- Usage without written permission constitutes a breach of license  
- See full terms in the LICENSE file

---

## 💡 Project Purpose

This repository empowers artists to share music under their own terms—without compromising ownership. It offers flexibility for future monetization while protecting creators from unauthorized use.

---

## 📚 Resources

- [U.S. Copyright Office](https://www.copyright.gov)  
- [ASCAP](https://www.ascap.com)  
- [BMI](https://www.bmi.com)  
- [MPA](https://www.mpaonline.org)

---

## 🙋 Questions or Contributions?

Open an issue or submit a pull request.  
Let’s build a licensing ecosystem where creators thrive and users respect the art they engage with.

---

_This README was crafted with care by Microsoft Copilot and adapted for your custom license, Feel free to modify, enhance, and remix it as needed. Just like great music—it’s meant to evolve._
