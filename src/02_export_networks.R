set.seed(2025)
library(igraph)
library(ggraph)
library(dplyr)
library(stringr)
library(fs)

# List of categories and associated colors
categories <- list(
  mares = list(file = "data/processed/connections_mares.csv", color = "lightblue"),
  biodiversidad = list(file = "data/processed/connections_biodiversidad.csv", color = "lightgreen"),
  clima = list(file = "data/processed/connections_clima.csv", color = "rosybrown1")
)

# Create main output folder
dir_create("outputs/figures/networks")

# Loop over each category
for (cat in names(categories)) {
  cat_data <- categories[[cat]]
  connections <- read.csv(cat_data$file)
  prefered_color <- cat_data$color
  
  # Create subfolder
  dir_create(file.path("outputs/figures/networks", cat))
  
  # Get list of people (Expert_ID)
  people <- sort(unique(connections$Expert_ID))
  
  for (person in c("ALL", people)) {
    
    # Filter data for individual or full graph
    if (person == "ALL") {
      connections_person <- connections %>% select(from, to) %>% filter(!is.na(from), !is.na(to))
      layout_type <- "eigen"
    } else {
      connections_person <- connections %>% filter(Expert_ID == person) %>% select(from, to)
      layout_type <- "fr"
    }
    
    # Skip empty graphs
    if (nrow(connections_person) < 1) next
    
    # Create igraph object
    g <- graph_from_data_frame(connections_person, directed = FALSE)
    
    # Create layout
    layout <- create_layout(g, layout = layout_type)
    
    # Output filename
    safe_name <- str_replace_all(person, "\\s+", "_")
    filename <- file.path("outputs/figures/networks", cat, paste0("graph_", safe_name, ".png"))
    
    # Save plot to file
    png(filename, width = 500, height = 300)
    print(  # 👈 Required to render the ggplot/ggraph object inside png()
      ggraph(layout) +
        geom_edge_link(aes(edge_alpha = 0.5), color = "gray", show.legend = FALSE) +
        geom_node_point(color = prefered_color, size = 5) +
        geom_node_text(aes(label = name), vjust = 1.8, color = "darkblue") +
        theme_void() +
        ggtitle(ifelse(person == "ALL",
                       paste("Network Visualization for All in", cat),
                       paste("Network Visualization for", person, "in", cat)))
    )
    dev.off()
    
    message("Saved: ", filename)
  }
}
