data_dir <- normalizePath(file.path("..", "data", "processed"), mustWork=TRUE)

library(shiny)
library(igraph)
library(ggraph)
library(dplyr)

library(dplyr)

  connections_mares <- read.csv(file.path(data_dir, "connections_mares.csv"))
  connections_biodiversidad <- read.csv(file.path(data_dir, "connections_biodiversidad.csv"))
  connections_clima <- read.csv(file.path(data_dir, "connections_clima.csv"))




ui <- fluidPage(
  titlePanel("Network Visualization by Expert and Category"),
  sidebarLayout(
    sidebarPanel(
      selectInput("categoryInput", "Choose a Category:",
                  choices = c("mares", "biodiversidad", "clima")),
      selectInput("nameInput", "Choose an Expert:", choices = "ALL")  # Initially empty
    ),
    mainPanel(
      plotOutput("networkPlot")
    )
  )
)




server <- function(input, output,session) {
    # Reactively update the name choices based on selected category
  observe({
    # Load the appropriate dataset
    data_path <- switch(input$categoryInput,
                        "mares" = file.path(data_dir, "connections_mares.csv"),
                        "biodiversidad" = file.path(data_dir, "connections_biodiversidad.csv"),
                        "clima" = file.path(data_dir, "connections_clima.csv"))
    
    connections <- read.csv(data_path)
    
    # Update name choices
    name_choices <- c("ALL", unique(connections$Expert_ID[connections$Expert_ID != "ALL"]))
    updateSelectInput(session, "nameInput", choices = name_choices)
  })

  output$networkPlot <- renderPlot({

    # Load the appropriate dataset again in case it's needed here
    data_path <- switch(input$categoryInput,
                        "mares" = file.path(data_dir, "connections_mares.csv"),
                        "biodiversidad" = file.path(data_dir, "connections_biodiversidad.csv"),
                        "clima" = file.path(data_dir, "connections_clima.csv"))
    
    connections <- read.csv(data_path)
    #connections <- read.csv(file.path(data_dir, "connections_clima.csv"))

    if (input$nameInput != "ALL") {
      # Filter data based on selected anonymized name
      connections_mares_person <- connections %>%
        filter(Expert_ID == input$nameInput) %>%
        select(from, to)
        prefered_layout="fr"
    } else {
      # Use all data if "ALL" is selected
      connections_mares_person <- connections %>%
        select(from, to) %>% filter(!is.na(from),!is.na(to))
        prefered_layout="eigen"
    }

    validate(need(nrow(connections_mares_person) > 0, "No connections for this selection"))
    set.seed(2025)
    # Create graph
    #glimpse(connections_mares_person)
    g <- graph_from_data_frame(connections_mares_person, directed = FALSE)
    
    
    layout <- create_layout(g, layout = prefered_layout)
    prefered_color <- ifelse(input$categoryInput=="mares","lightblue",ifelse(input$categoryInput=="biodiversidad","lightgreen","rosybrown1"))

    # Plot using ggraph
    ggraph(layout) +
      geom_edge_link(aes(edge_alpha = 0.5), color = "gray",show.legend=FALSE) +
      geom_node_point(color = prefered_color, size = 5) +
      geom_node_text(aes(label = name), vjust = 1.8, color = "darkblue") +
      theme_void() +
      ggtitle(ifelse(input$nameInput == "ALL", "Network Visualization for All", paste("Network Visualization for", input$nameInput)))
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
