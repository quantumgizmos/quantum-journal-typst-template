// Importing required packages
#import "@preview/physica:0.9.3": *

// Define custom colors for use in the template
#let quantum_violet = rgb("#53257F")
#let quantum_grey = rgb("#555555")

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

// Define the main template function 'quantum-journal-template'
#let quantum-journal-template(
    title: none,                    // Title of the document
    authors: (name: none, affiliations: ()),  // Authors list with their affiliations
    url: none,                      // Optional URL link for reference
    font-size: 11pt,                // Default font size
    columns: 2,                     // Number of columns in the document
    font: "New Computer Modern",    // Default font
    title_url: none,                // The link when you click on the title 
    doc                             // Document content
) = {

  // Set the document title and author(s)
  set document(title: title, author: authors.map(author => author.name))

  // Configure page settings: margins, columns, and page numbering
  set page(
    margin: (top: 2.5cm, bottom: 3cm, left: 2cm, right: 2cm),
    columns: columns,
    numbering: "1"
  )

  // Set the heading numbering and style
  set heading(numbering: "1.")
  show heading: text.with(font: "New Computer Modern Sans", weight: "regular", size: 1.0em)
  show heading.where(body: [References]): set heading(numbering: none)
  show heading.where(body: [Acknowledgements]): set heading(numbering: none)

  // Set the default text size and font, ensuring consistency
  if font in ("Sans", "sans") {
    font = "New Computer Modern Sans"
  } else if font in ("Serif", "serif","",none) {
    font = "New Computer Modern"
  }
  set text(size: font-size, font: font)

  // Place the title and author block at the top left of the page
  place(
    top + left,
    scope: "parent",
    float: true,
    {
      // Display the title in a larger font with a custom color and font
      {
        set text(size: 2em, fill: quantum_violet, font: "New Computer Modern Sans")

        if title_url == none{
          title
        }
        else{
          link(title_url)[#title]
        }
      }

      linebreak()
      linebreak()
    
      // Initialize an empty set to collect unique affiliations
      let affiliation_set = ()
      // Get the number of authors
      let author_count = authors.len()
      
      // Loop over each author to display their information
      for (i, author) in authors.enumerate() {
        // Set the font for the author names
        set text(font: "New Computer Modern Sans", size: 1.3em)
        // Display the author's name with or without a link to their homepage
        if "homepage" in author.keys() {
          link(author.homepage)[#author.name]
        } else {
          author.name
        }

        // Initialize an empty list to store indices of affiliations for this author
        let affiliation_indices = ()

        // Handle affiliations, ensuring compatibility with different formats
        let affiliations = ()
        if type(author.affiliations) == str {
          affiliations.push(author.affiliations)
        } else {
          affiliations = author.affiliations
        }
        
        // Loop through affiliations to determine unique indices
        for affiliation in affiliations {
          let affiliation_exists = false
          for (j, aff) in affiliation_set.enumerate() {
            if aff == affiliation {
              affiliation_indices.push(j + 1)
              affiliation_exists = true
              break
            }
          }
          if affiliation_exists == false {
            affiliation_set.push(affiliation)
            affiliation_indices.push(affiliation_set.len())
          }
        }
        
        // Display the affiliation indices as superscripts
        for (j, index) in affiliation_indices.enumerate() {
          text(super(str(index)))
          if j != affiliation_indices.len() - 1 {
            text(super(","))
          }
        }

        // Add appropriate punctuation between author names
        if i < author_count - 2 {
          text(", ")
        } else if i == author_count - 2 {
          text(" and ")
        }
      }

      linebreak()
      linebreak()
      
      // Display the list of affiliations with their corresponding indices
      for (i, affiliation) in affiliation_set.enumerate() {
        set text(size: 0.9em, font: "New Computer Modern Sans", fill: quantum_grey)
        text(super(str(i + 1)))
        affiliation
        linebreak()
      }
      linebreak()
    }
  )

  // Display emails at the bottom left of the page
  let emails_exist = false
  for author in authors{
    if "email" in author.keys(){
      emails_exist = true
      break
    }
  }

  if emails_exist{
    place(
      bottom + left,
      scope: "column",
      float: true, {
        show link: underline
        set text(size: 0.8em, font: "New Computer Modern Sans")
        text(weight: "bold")[Contact]
        set text(fill: quantum_grey)
        linebreak()
        for author in authors {
          if ("email" in author.keys()) {
            [#author.name: #link("mailto:" + author.email)]
            linebreak()
          }
        }
      }
    )
 }
  
  // Set paragraph justification for the document
  set par(justify: true)
  // Set equation numbering style
  set math.equation(numbering: "(1)")

  // Include the main document content
  doc
}
