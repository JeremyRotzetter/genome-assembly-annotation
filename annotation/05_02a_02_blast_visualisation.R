# Install and load the VennDiagram package
# install.packages("VennDiagram")
library(VennDiagram)

# Load in filtered BLASTP output file and initial unaligned annotated proteins to get the amount of proteins with homology to known proteins
# blastp_output <- read.csv("blastp_output", sep = "\t", header = FALSE)
MAKER_proteins <- read.csv("annotated_proteins.txt", sep = "\t", header = FALSE)
blastp_filtered <- read.csv("blastp_filtered.tsv", sep = "\t", header = FALSE)
# annotated_proteins <- blastp_output[, 1]
annotated_proteins <- MAKER_proteins[, 1]
known_proteins <- blastp_filtered[, 1]

# Create the Venn diagram
venn.diagram(
  x = list(Annotated = annotated_proteins, Homologous = known_proteins),
  filename = "venn_diagram.png",  # Specify the output file name
  imagetype = "png", # Specification of the image format (e.g. tiff, png or svg)
  col = "transparent",  # Set the color of the circles
  fill = c("cornflowerblue", "darkorange1"),  # Set the fill color of the circles
  alpha = 0.5,  # Set the transparency of the circles
  label.col = rep("black", 3),  # Set the color of the labels
  cex = 1.5,  # Set the size of the labels
  fontfamily = "sans",  # Set the font family of the labels
  cat.col = c("cornflowerblue", "darkorange1"),  # Set the color of the category labels
  cat.cex = 1.2,  # Set the size of the category labels
  cat.fontfamily = "sans",  # Set the font family of the category labels
  main = "Proteins with Homology",  # Set the title of the Venn diagram
  sub = "(percentage identity >= 98)",
  print.mode = "raw",
  force.unique = TRUE, # because there are proteins that map to multiple known ones in the uniprot database
  width = 3000
)

# if (!require(devtools)) install.packages("devtools")
# devtools::install_github("yanlinlin82/ggvenn")

library("ggvenn")

list_venn <- list(Annotated = annotated_proteins, Homologous = known_proteins)

diag <- ggvenn(list_venn, c("Annotated", "Homologous"))
ggsave("ggvenn.png", plot = diag)