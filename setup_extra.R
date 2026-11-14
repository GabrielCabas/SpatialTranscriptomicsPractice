# Paquetes que no están en conda para R 4.5
options(repos = "https://cloud.r-project.org", Ncpus = 4)

# Rfast2: acelera el cálculo de Moran's I en FindSpatiallyVariableFeatures (~10x)
if (!requireNamespace("Rfast2", quietly = TRUE)) install.packages("Rfast2")

for (p in c("Seurat", "BayesSpace", "Rfast2"))
  cat(sprintf("%-12s %s\n", p, as.character(packageVersion(p))))
