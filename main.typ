#import "@preview/cetz:0.3.0"
#import "quantum-journal-template.typ": *
#show: quantum-journal-template.with(

  title: "Typst Template for Quantum Journal",

  authors: (

    (
    name: "Author One",
    affiliations: ("Univeristy One"),
    email: "author@one.edu",
    homepage: "https://wikipedia.org/wiki/one",
    orcid: "0000-0000-0000-0001"
    ),

    (
    name: "Author Two",
    affiliations: ("University Two", "Univeristy One"),
    email: "author@two.edu",
    homepage: "https://wikipedia.org/wiki/two",
    thanks: [A.O. would like to thank the family of real numbers who have supported them throughout every stage of their career.],
    orcid: "0000-0000-0000-0002"
    ),

    (
    name: "Author Three",
    affiliations: "University Three",
    homepage: "https://wikipedia.org/wiki/three",
    orcid: "0000-0000-0000-0003"
    ),

  ),

  font-size: 11pt, // choose the font
  columns: 2, //set the number of columns
  font: "serif", //choose between 'serif' or 'sans' or any typst.app font.
  title-url: "https://github.com/quantumgizmos/quantum-journal-typst-template" //this the link when you click on the title

)

#Abstract[
  This is a first attempt at a Typst template for Quantum Journal. Efforts have been made to replicate the look and feel of the existing LaTeX template. The current version includes basic functionality and many features still need to be added.
]

= Introduction
== Introduction

Typst is a modern document preparation system that serves as an alternative to LaTeX. Written from the ground up in Rust, it offers faster compilation times and a more intuitive markup language, making it straightforward to create custom layouts and extensions. The developers are currently working on HTML export, which will  improve the accessibility of academic literature.

= Equations

Typst has support for rendering mathematical equations. The syntax is different to that of LaTex. Inline equations are written as follows: $a^2 + b^2 = c^2$. Numbered equation can be entered as:

$ ket(psi) = alpha ket(0) + beta ket(1) $

Note, `braket` notation is enabled through the `physica` extension which is imported in the template file.

= Citations

Typst supports the `.bib` citation format. For example, here is a citation for the Numpy paper #cite(<Harris_2020>). ArXiv preprints can also be cited #cite(<gottesman2009introductionquantumerrorcorrection>). Currently, this template uses the IEEE citation style file.

= Figures

The `#figure` command can be used to insert images into the document.

#figure(
  cetz.canvas(length: 1in, {
  import cetz.draw: *

    circle((0, 0), name: "circle", radius: 1)
    set-style(content: (frame: "rect", stroke: none, fill: white, padding: .1))
    content((name: "circle", anchor: 0deg), [0deg], anchor: "west")
    content((name: "circle", anchor: 160deg), [160deg], anchor: "south-east")
    content("circle.north", [North], anchor: "south")
    content("circle.south-east", [South East], anchor: "north-west")
    content("circle.south-west", [South West], anchor: "north-east")
  
}),
  caption: [A circle with some labels. This figure is generated using `cetz` which is Typst's replacement for `tikz`.]
)

= Quantum Circuit Diagrams

Quantum circuit diagrams can be included using the `Quill` package.

#figure(
quill.quantum-circuit(
  
  quill.lstick($ket(0)$), [\ ],
  quill.lstick($ket(0)$), [\ ],
  quill.lstick($ket(0)$),
  ..tq.build(
    tq.h(0),
    tq.cx(0, 1),
    tq.cx(0, 2),
  ),
  
),

caption: [The `Quill` package can be used to draw quantum circuit diagrams. ]

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
