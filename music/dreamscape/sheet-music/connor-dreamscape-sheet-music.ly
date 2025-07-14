% Dreamscape.ly
\version "2.24.2"

\header {
  title  = "Dreamscape"
  composer = "Connor"
  tagline = "Ambient · Ethereal · Uplifting"
}

\paper {
  tagline = ##f
}

\score {
  <<
    % Chord symbols for a pad-like progression
    \new ChordNames {
      \set ChordNames.midiChordChanges = ##t
      \chordmode {
        \time 4/4
        \repeat unfold 4 {
          fis:m     | d:maj    | b:m      | cis:maj
        }
      }
    }

    % Sustained voiced chords in the staff
    \new Staff {
      \clef "treble"
      \time 4/4
      \key fis \minor
      \repeat unfold 4 {
        <fis a cis>1\fermata | <d fis a>1\fermata
        | <b d fis>1\fermata   | <cis! e! gis!>1\fermata
      }
    }
  >>

  \midi {
    \tempo 4 = 72
  }

  \layout { }
}
