library(readxl)
library(dplyr)
library(tidyr)
library(stringr)

# Run from the repository root. Only assignment fields enter pair generation.
data <- read_excel("data/raw/responses.xlsx", sheet = "Responses")
metadata <- read_excel("data/raw/theme_dictionary.xlsx", sheet = "Metadata")
metadata_long <- metadata %>% pivot_longer(everything(), names_to="identifier", values_to="name")
categories <- c(mares="1", biodiversidad="2", clima="3")
dir.create("data/processed", recursive=TRUE, showWarnings=FALSE)
for (category in names(categories)) {
  fields <- grep(paste0("^", categories[[category]], "\\.1\\.[0-9]+$"), names(data), value=TRUE)
  long <- data %>% select(Expert_ID, all_of(fields)) %>%
    pivot_longer(-Expert_ID, names_to="identifier", values_to="theme") %>%
    left_join(metadata_long, by="identifier")
  stopifnot(!anyNA(long$name))
  connections <- long %>% filter(!is.na(theme), !theme %in% c("Indeciso", "Tema Independiente")) %>%
    group_by(Expert_ID, theme) %>% summarise(columns=list(name), .groups="drop") %>%
    filter(lengths(columns)>1) %>%
    mutate(pairs=lapply(columns, function(x) combn(x, 2, simplify=FALSE))) %>%
    select(-columns) %>% unnest(pairs) %>% unnest_wider(pairs, names_sep="_") %>%
    rename(from=pairs_1, to=pairs_2)
  write.csv(connections, paste0("data/processed/connections_", category, ".csv"), row.names=FALSE, fileEncoding="UTF-8")
}
