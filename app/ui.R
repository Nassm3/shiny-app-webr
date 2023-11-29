node = read.csv("node.csv",sep = " ")
edge = read.csv("edge.csv",sep = " ")
ui = fluidPage(
  fluidRow(
    column(
      6,
      h1("VisNetwork")
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
