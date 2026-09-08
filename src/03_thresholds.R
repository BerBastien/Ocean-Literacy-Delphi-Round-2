set.seed(2025)
library(igraph)
library(ggraph)
library(dplyr)
library(tidyr)
library(ggplot2)

# Define categories with file paths and plot colors
categories <- list(
  mares = list(file = "data/processed/connections_mares.csv", color = "steelblue"),
  biodiversidad = list(file = "data/processed/connections_biodiversidad.csv", color = "seagreen"),
  clima = list(file = "data/processed/connections_clima.csv", color = "indianred")
)

clust_results <- list()

for (cat in names(categories)) {
  # Load edges for all participants
  connections <- read.csv(categories[[cat]]$file) %>%
    filter(!is.na(from), !is.na(to)) %>%
    select(from, to)
  
  # Build graph of themes
  g <- graph_from_data_frame(connections, directed = FALSE)
  
  # Ensure node names are themes
  layout <- create_layout(g, layout = "eigen") %>% select(x, y, name)
  
  # Compute Euclidean distances between node coordinates
  pos <- layout %>% select(x, y) %>% as.matrix()
  rownames(pos) <- layout$name
  dist_matrix <- dist(pos)
  
  # Hierarchical clustering on theme distances
  hc <- hclust(dist_matrix, method = "average")
  
  # Try heights from 0 to max
  heights <- seq(0, max(hc$height), length.out = 100)
  n_clusters <- sapply(heights, function(h) length(unique(cutree(hc, h = h))))
  
  # Save result
  clust_results[[cat]] <- tibble(
    category = cat,
    height = heights,
    n_clusters = n_clusters
  )
}

# Combine all results
plot_data <- bind_rows(clust_results)

# Plot
ggplot(plot_data, aes(x = height, y = n_clusters, color = category)) +
  geom_line(size = 1.2) +
  geom_point(size = 1) +
  scale_color_manual(values = c(
    mares = categories$mares$color,
    biodiversidad = categories$biodiversidad$color,
    clima = categories$clima$color
  )) +
  labs(
    title = "Number of Theme Clusters vs. Distance Threshold",
    x = "Distance Threshold (Euclidean distance)",
    y = "Number of Theme Clusters",
    color = "Category"
  ) +
  theme_minimal(base_size = 14)


library(inflection)  # for elbow detection
library(dplyr)
library(ggplot2)



# Apply to plot_data (already created from previous step)
elbows <- plot_data %>%
  group_by(category) %>%
  summarise(
    cutoff_height = {
      # Use the 'findiplist' function to find the inflection point (elbow)
      h <- height
      k <- n_clusters
      elbow_index <- findiplist(h, k, 1)["EDE", "j1"]  # Explicit equivalent of original [2]

      h[elbow_index]
    }
  )

# Merge to plot
ggplot(plot_data, aes(x = height, y = n_clusters, color = category)) +
  geom_line(size = 1.2) +
  geom_point(size = 1) +
  geom_vline(data = elbows, aes(xintercept = cutoff_height, color = category),
             linetype = "dashed", size = 1) +
  scale_color_manual(values = c(
    mares = "steelblue",
    biodiversidad = "seagreen",
    clima = "indianred"
  )) +
  labs(
    title = "Number of Theme Clusters vs. Distance Threshold",
    subtitle = "Dashed line shows suggested cutoff via elbow method",
    x = "Distance Threshold",
    y = "Number of Theme Clusters",
    color = "Category"
  ) +
  theme_minimal(base_size = 14)
ggsave("outputs/figures/cutoff_graph.jpg",dpi=300)

write.csv(plot_data, "outputs/tables/threshold_curve.csv", row.names=FALSE)
write.csv(elbows, "outputs/tables/thresholds.csv", row.names=FALSE)
