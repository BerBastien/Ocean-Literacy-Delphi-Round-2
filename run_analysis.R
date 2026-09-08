if (!file.exists("data/raw/responses.xlsx")) stop("Run this script from the repository root")
dir.create("outputs/figures", recursive=TRUE, showWarnings=FALSE)
dir.create("outputs/tables", recursive=TRUE, showWarnings=FALSE)
for (script in c("src/01_prepare_connections.R", "src/02_export_networks.R", "src/03_thresholds.R", "src/04_clusters.R")) {
  message("Running ", script)
  source(script, local=new.env(parent=globalenv()))
}
