library(readxl)
responses <- read_excel("data/raw/responses.xlsx", sheet="Responses")
stopifnot(nrow(responses)==27, ncol(responses)==68, !anyDuplicated(responses$Expert_ID))
stopifnot(all(grepl("^Expert_[0-9]{3}$", responses$Expert_ID)))
key <- function(d) unname(sort(apply(as.data.frame(d), 1, paste, collapse="\t")))
for (category in c("mares", "biodiversidad", "clima")) {
  actual <- read.csv(paste0("data/processed/connections_", category, ".csv"))
  reference <- read.csv(paste0("data/reference/connections_", category, ".csv"))
  reference <- reference[!is.na(reference$from) & !is.na(reference$to), ]
  stopifnot(identical(key(actual), key(reference)))
  stopifnot(all(actual$Expert_ID %in% responses$Expert_ID))
}
a <- read_excel("outputs/tables/theme_clusters.xlsx")
b <- read_excel("outputs/tables/reference_theme_clusters.xlsx")
stopifnot(identical(key(a[c("category", "themes")]), key(b[c("category", "themes")])))
for (file in c(list.files("src", full.names=TRUE), "app/app.R", "run_analysis.R")) parse(file)
message("Validated: 27 experts, 67 assignment fields, all valid historical edges and cluster memberships.")
