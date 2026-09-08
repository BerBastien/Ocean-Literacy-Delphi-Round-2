set.seed(2025)
library(igraph)
library(ggraph)
library(dplyr)
library(tidyr)
library(ggplot2)
library(inflection)

# Define categories and files
categorias <- list(
  mares = "data/processed/connections_mares.csv",
  biodiversidad = "data/processed/connections_biodiversidad.csv",
  clima = "data/processed/connections_clima.csv"
)

# Store elbow cutoffs
cutoffs <- list()
theme_clusters <- list()
library(inflection)

cutoffs <- list()
theme_clusters <- list()

# Step 1: Determine cutoff thresholds using elbow method
for (cat in names(categorias)) {
  df <- read.csv(categorias[[cat]]) %>%
    filter(!is.na(from), !is.na(to))

  # Create undirected graph of themes
  g <- graph_from_data_frame(df %>% select(from, to), directed = FALSE)

  layout <- create_layout(g, layout = "eigen") %>% select(x, y, theme = name)
  dist_matrix <- dist(layout %>% select(x, y))
  hc <- hclust(dist_matrix, method = "average")

  heights <- seq(0, max(hc$height), length.out = 100)
  n_clusters <- sapply(heights, function(h) length(unique(cutree(hc, h = h))))

  # Get the inflection point list
  inflections <- findiplist(heights, n_clusters, 1)
  elbow_index <- inflections["EDE", "j1"]  # Same scalar selected by [2] in threshold script
  stopifnot(length(elbow_index) == 1L, is.finite(elbow_index))
  cutoff_height <- heights[elbow_index]

  cutoffs[[cat]] <- cutoff_height
}

# Step 2: Apply clustering using determined cutoffs
for (cat in names(categorias)) {
  df <- read.csv(categorias[[cat]]) %>%
    filter(!is.na(from), !is.na(to))
  
  g <- graph_from_data_frame(df %>% select(from, to), directed = FALSE)
  
  layout <- create_layout(g, layout = "eigen") %>%
    select(x, y, theme = name)
  
  dist_matrix <- dist(layout %>% select(x, y))
  hc <- hclust(dist_matrix, method = "average")
  
  k <- cutoffs[[cat]]
  layout$cluster <- cutree(hc, h = k)
  layout$category <- cat
  
  theme_clusters[[cat]] <- layout
}

# Step 3: Group by cluster and list themes
grouped_theme_clusters <- bind_rows(theme_clusters) %>%
  group_by(category, cluster) %>%
  summarise(themes = paste(sort(theme), collapse = ", "), .groups = "drop") %>%
  arrange(category, cluster)

# View result
print(grouped_theme_clusters, n = Inf)
library(writexl)

# Save the data frame to an Excel file
write_xlsx(grouped_theme_clusters, "outputs/tables/theme_clusters.xlsx")
