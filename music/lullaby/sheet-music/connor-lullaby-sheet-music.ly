% Lullaby.ly
\version "2.24.2"

global = {
  \tempo 4 = 72
  \key c \major
  \time 4/4
  \set Staff.midiInstrument = #"pad 1"
}

melPhrase = \relative c' {
  \global
  c4   e4   g4   a4
  g4   f4   e4   d4
  c4   d4   e4   f4
  g2   e2

  a4   c4   b4   g4
  f4   d4   e4   c4
  d4   f4   g4   a4
  c1
}

accPhrase = \relative c {
  \global
  c1
  f1
  g1
  e1

  a,1
  d,1
  d,1
  c1
}

melodyVoice = \repeat unfold 8 { \melPhrase }
bassVoice   = \repeat unfold 8 { \accPhrase }

\header {
  title    = "Lullaby"
  subtitle = "A soothing lullaby designed to create a peaceful atmosphere, perfect for relaxation and sleep."
  composer = "Connor"
  date     = "2025-07-12"
  tagline  = "Ambient • Calm • Relaxing • Ethereal • 72 BPM • Duration 3:30"
}

\score {
  \new PianoStaff <<
    \new Staff = "Melody" {
      \melodyVoice
    }
    \new Staff = "Accompaniment" \with {
      midiInstrument = #"pad 1"
    } {
      \clef bass
      \bassVoice
    }
  >>
  \layout { }
  \midi { }
}
