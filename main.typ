#import "quantum-journal-template.typ": *
#show: quantum-journal-template.with(

  title: "Typst Template for Quantum Journal",

  authors: (

    (
    name: "Author One",
    affiliations: ("Univeristy One"),
    email: "author@one.edu",
    homepage: "https://en.wikipedia.org/wiki/one"
    ),

    (
    name: "Author Two",
    affiliations: ("University Two", "Univeristy One"),
    email: "author@two.edu",
    homepage: "https://en.wikipedia.org/wiki/two",
    ),

    (
    name: "Author Three",
    affiliations: "University Three",
    homepage: "https://en.wikipedia.org/wiki/three"
    ),

  ),

  font-size: 11pt, // choose the font
  columns: 2, //set the number of columns
  font: "serif", //choose between 'serif' or 'sans' or any typst.app font.
  title_url: "https://typst.app" //this the link when you click on the title

)

#Abstract[
  This is a first attempt at a Typst template for Quantum Journal. Efforts have been made to replicate the look and feel of the existing LaTeX template. The current version includes basic functionality, but various features, e.g., citation formatting, still need to be developed.
]

= Introduction
== Introduction

Typst is a modern document preparation system that serves as an alternative to LaTeX. Written from the ground up in Rust, it offers faster compilation times and a more intuitive markup language, making it straightforward to create custom layouts and extensions. The developers are currently working on HTML export, which will  improve the accessibility of academic literature.

= Equations

Typst has support for rendering mathematical equations. The syntax is different to that of LaTex. Inline equations are written as follows: $a^2 + b^2 = c^2$. Numbered equation can be entered as:

$ ket(psi) = alpha ket(0) + beta ket(1) $

Note, `braket` notation is enabled through the `physica` extension which is imported in the template file.

= Citations

Typst supports the `.bib` citation format. For example, here is a citation for the Numpy paper #cite(<Harris_2020>). Currently, this template uses the IEEE citation style file.

= Figures

The `#figure` command can be used to insert images into the document.

#figure(
  image("quantum_journal_logo.png",width: 100%),
  caption: [The Quantum-Journal logo]
)

= Acknowledgements
#lorem(25)

// = References
#bibliography("refs.bib")

#Appendix[
  #lorem(15)

  == Sub-appendix
  #lorem(20)

]
