// For bra ket notation
#import "@preview/physica:0.9.3": *

// For quantum circuit diagrams
#import "@preview/quill:0.5.0" as quill: tequila as tq

// Define custom colors for use in the template
#let quantum-violet = rgb("#53257F")
#let quantum-grey = rgb("#555555")

// Define the main template function 'quantum-journal-template'
#let quantum-journal-template(
    title: none,                    // Title of the document
    authors: (),  // Authors. Each entry is a dictionary. Optional keys are "name", "affiliations", "homepage", and "email"
    font-size: 11pt,                // Default font size
    columns: 2,                     // Number of columns in the document
    font: "New Computer Modern",    // Default font
    title-url: none, // The link when you click on the title
    bibliography: bibliography("refs.bib"),
    doc                             // Document content
) = {

  // Set the document meta data
  set document(title: title, author: authors.map(author => author.name))

  // Configure page settings: margins, columns, and page numbering
  set page(
    margin: (top: 2.5cm, bottom: 3cm, left: 2cm, right: 2cm),
    columns: columns,
    numbering: "1",
    footer: {
      rect(
        width: 100%,
        stroke: (top: 0.25pt),
      )[
        #set text(font: "New Computer Modern Sans", fill: quantum-violet)
        Draft for Quantum #h(1fr) #text(size: font-size, context counter(page).display())
      ]
    }
  )

  // Set paragraph justification for the document
  set par(justify: true)
  set par(leading: 0.55em, spacing: 0.7em)

  // Set equation numbering style
  set math.equation(numbering: "(1)")

  // Set the heading numbering and style
  set heading(numbering: (..nums) => nums.pos().map(str).join(".") )
  show heading: set text(font: "New Computer Modern Sans", weight: "regular", size: 1.0em)
  show heading: it => {
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(1em)
    }
    block(number + it.body, spacing: 1.2em)
  }
  show heading.where(body: [Acknowledgements]): set heading(numbering: none)

  // Set the default text size and font, ensuring consistency
  if font in ("Sans", "sans") {
    font = "New Computer Modern Sans"
  } else if font in ("Serif", "serif","",none) {
    font = "New Computer Modern"
  }
  set text(size: font-size, font: font)

  // Color setup.
  show link: set text(fill: quantum-violet)
  show footnote: set text(fill: quantum-violet)
  show ref: it => {
    show regex("\d+(\.?\p{L}*)?"): set text(fill: color.quantum-violet)
    it
  }

  
  //Figure formatting
  show figure.where(kind: image): set figure(supplement: [Fig], numbering: "1")
  show figure.caption: set text(size: font-size)
  show figure.caption: set align(start)

  // Figure setup.
  set figure(gap: 2em)
  show figure.caption: set text(font: "New Computer Modern Sans", size: 0.9em)
  show figure.caption: set par(leading: 0.5em)
  show figure.caption: set align(start)



  // Style bibliography.
  set std.bibliography(title: "References", style: "ieee")
  show std.bibliography: set heading(numbering: none)


  // Place the title and author block at the top left of the page
  place(
    top + left,
    scope: "parent",
    float: true,
    {
      // Display the title in a larger font with a custom color and font
      {
        set text(size: 2em, fill: quantum-violet, font: "New Computer Modern Sans")

        if title-url == none{
          title
        }
        else{
          link(title-url)[#title]
        }
      }

      linebreak()
      v(1em)

      // Initialize an empty set to collect unique affiliations
      let affiliation-set = ()
      // Get the number of authors
      let author-count = authors.len()

      // Loop over each author to display their information
      for (i, author) in authors.enumerate() {
        // Set the font for the author names
        set text(font: "New Computer Modern Sans", size: 1.1em)
        // Display the author's name with or without a link to their ORCID
        if "orcid" in author.keys() {
          link("https://orcid.org/" + author.orcid)[#text(fill:black,author.name)]
        } else {
          author.name
        }

        if "affiliations" in author.keys(){

          // Handle affiliations, ensuring compatibility with different formats
          let affiliations = if type(author.affiliations) == str {
            (author.affiliations,)
          } else {
            author.affiliations
          }

          // Initialize an empty list to store indices of affiliations for this author
          let affiliation-indices = ()

          // Loop through affiliations to determine unique indices
          for affiliation in affiliations {
            let index = affiliation-set.position(a => a == affiliation)
            if index != none {
              affiliation-indices.push(index + 1)
            } else {
              affiliation-set.push(affiliation)
              affiliation-indices.push(affiliation-set.len())
            }
          }

          // Display the affiliation indices as superscripts
          for (j, index) in affiliation-indices.enumerate() {
            text(super(str(index)))
            if j != affiliation-indices.len() - 1 {
              text(super(","))
            }
          }
        }

        // Add appropriate punctuation between author names
        if i < author-count - 2 {
          text(", ")
        } else if i == author-count - 2 {
          text(" and ")
        }
      }

      if authors.len()>0{
        linebreak()
        v(1em)
      }

      // Display the list of affiliations with their corresponding indices
      for (i, affiliation) in affiliation-set.enumerate() {
        set text(size: 0.8em, font: "New Computer Modern Sans", fill: quantum-grey,weight: "regular")
        text(super(str(i + 1)))
        affiliation
        linebreak()
      }
      v(1em)
    }
  )

  // Display homepage, emails and thanks at the bottom left of the page
  let has-bottom-display-info = author => ("email", "homepage", "thanks").any(key => key in author.keys())

  if authors.any(has-bottom-display-info) {
    place(
      bottom + left,
      scope: "column",
      float: true, {
        set par(leading: 0.5em)
        for author in authors {
          if not has-bottom-display-info(author) {
            continue
          }
          set text(size: 0.8em, font: "New Computer Modern Sans")
          
          [#author.name: ]
          if "email" in author.keys() {
            [#link("mailto:" + author.email)]
          }
          if "homepage" in author.keys() {
            if "email" in author.keys() {
              [, ]
            }
            [#link(author.homepage)]
          }
          if "thanks" in author.keys() {
            if "email" in author.keys() or "homepage" in author.keys() {
              [, ]
            }
            [#author.thanks]
          }
          linebreak()
        }
      }
    )
 }

 



  // Include the main document content
  doc
}

// Define a macro for the abstract section, setting the text in bold
#let Abstract(body) = {
  set text(weight: "bold")
  body
}

// Define a macro for the appendix section, adding specific heading numbering styles
#let Appendix(body) = {
  show: set heading(numbering: "A")
  show heading.where(level: 2): set heading(numbering: "A1")
  counter(heading).update(0)
  [= Appendix]
  body
}
