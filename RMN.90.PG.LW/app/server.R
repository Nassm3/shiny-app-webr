node = read.csv("node.csv",sep = " ")
edge = read.csv("edge.csv",sep = " ")

server = function(input, output) {
  output$net <- renderVisNetwork({
    visNetwork(node, edge) %>%
      visGroups(groupname = "Transcriptome", color = "lightcoral", shape = "square") %>%
      visGroups(groupname = "Metabolome", color = "steelblue", shape = "circle") %>%
      visGroups(groupname = "Phenotype", color = "orange", shape = "hexagon") %>%
      visLegend(main = "Legend", useGroups = TRUE, width = 0.1) %>%
      visPhysics(
        repulsion = list(nodeDistance = 50),
        timestep = 0.3,
        adaptiveTimestep = TRUE,
      )
  })
  
  network <- visNetworkProxy("net")
  
  observe ({
    if (!is.null(input$selectednode)){ # if user filter nodes manually:
      filteredEdges <- edge %>% filter(value >= input$cutoff)
      filteredEdges <- filteredEdges %>% filter(from %in% node[node[,"label"] %in% input$selectednode,"id"] |
                                                  to %in% node[node[,"label"] %in% input$selectednode,"id"])
      filteredNodes <- subset(node, id %in% filteredEdges$from | id %in% filteredEdges$to)
      hiddenNodes <- anti_join(node, filteredNodes)
      hiddenEdges <- anti_join(edge, filteredEdges)
      visRemoveNodes(network, id = hiddenNodes$id)
      visRemoveEdges(network, id = hiddenEdges$id)
      visUpdateNodes(network, filteredNodes)
      visUpdateEdges(network, filteredEdges)
    }
    else {
      filteredEdges <- edge %>% filter(value >= input$cutoff)
      filteredNodes <- subset(node, id %in% filteredEdges$from | id %in% filteredEdges$to)
      hiddenNodes <- anti_join(node, filteredNodes)
      hiddenEdges <- anti_join(edge, filteredEdges)
      visRemoveNodes(network, id = hiddenNodes$id)
      visRemoveEdges(network, id = hiddenEdges$id)
      visUpdateNodes(network, filteredNodes)
      visUpdateEdges(network, filteredEdges)
    }
  })
}


