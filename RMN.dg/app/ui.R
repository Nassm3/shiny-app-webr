node = read.csv("node.csv",sep = " ")
edge = read.csv("edge.csv",sep = " ")

ui = fluidPage(
  fluidRow(
    column(
      3,
      h1("VisNetwork")
    ),
    column(
      3,
      selectInput("selectednode", 
                  "Nodes to display", 
                  unlist(node$label), 
                  selected = NULL, 
                  multiple = TRUE,
                  width = '75%',
      )
    ),
    column(
      6,
      sliderInput("cutoff",
                  label = h3("Cutoff :"),
                  min = round(min(edge$value), 1),
                  max = round(max(edge$value), 1),
                  value = 0.6
      )
    )
  ),
  fluidRow(
    column(
      12,
      visNetworkOutput("net", width = "100%", height = "75vh")
    )
  ),
)
