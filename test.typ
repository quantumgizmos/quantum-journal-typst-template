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
    // affiliations: ("University Two", "Univeristy One"),
    email: "author@two.edu",
    homepage: "https://en.wikipedia.org/wiki/two",
    ),

    (
    name: "Author Three",
    // affiliations: "University Three",
    homepage: "https://en.wikipedia.org/wiki/three"
    ),
    
  ),
  
  font-size: 11pt, // choose the font
  columns: 2, //set the number of columns
  font: "serif", //choose between 'serif' or 'sans' or any typst.app font.
  title_url: "https://typst.app" //this the link when you click on the title
  
)

#Abstract[
  #lorem(40)
]

= Introduction

#lorem(50)

$ ket(psi) = alpha ket(0) + beta ket(1) $

= Sections

#lorem(700)

= Acknowledgements
#lorem(25)

= References




#Appendix[
  #lorem(25)

  == Sub-appendix
  #lorem(40)
  
]
