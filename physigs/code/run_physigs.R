library(PhySigs, warn.conflicts = FALSE)
library(graph, warn.conflicts = FALSE)
library(Rgraphviz, warn.conflicts = FALSE)
library(RColorBrewer, warn.conflicts = FALSE)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 3 || length(args) == 4) {
    tree_file = args[1]
    snv_file = args[2]
    o_pdf_file = base::paste(args[3], "plot.pdf", sep='.')
    o_tree_file = base::paste(args[3], "tree.tsv", sep='.')
    o_exposure_file = base::paste(args[3], "exposure.tsv", sep='.')
    if (length(args) == 4) {
       S = readLines(args[4])
    } else {
        S <- c(
            "Signature.1",
            "Signature.2",
            "Signature.3",
            "Signature.4",
            "Signature.5",
            "Signature.6",
            "Signature.7",
            "Signature.8",
            "Signature.9",
            "Signature.10",
            "Signature.11",
            "Signature.12",
            "Signature.13",
            "Signature.14",
            "Signature.15",
            "Signature.16",
            "Signature.17",
            "Signature.18",
            "Signature.19",
            "Signature.20",
            "Signature.21",
            "Signature.22",
            "Signature.23",
            "Signature.24",
            "Signature.25",
            "Signature.26",
            "Signature.27",
            "Signature.28",
            "Signature.29",
            "Signature.30"
        )
    }
} else {
    cat("Usage: run_physigs.R TREE SNV OUTPUT_PREFIX [SIGNATURES]\nOutput: OUTPUT_PREFIX.plot.pdf, \n")
    q(status=1)
}

# Input CSV file
# tree_file <- system.file("extdata", "tree.csv", package = "PhySigs", mustWork = TRUE)
tree_matrix <- read.csv(file=tree_file, header=TRUE, sep=",")

# V1/V2 contains clone label for first/second endpoint of edge
V1 <- as.character(tree_matrix$V1)
V2 <- as.character(tree_matrix$V2)

# Get nodes in the tree
node_ids <- unique(union(V1, V2))

# Initialize a tree 
T_tree <- new("graphNEL", nodes=node_ids, edgemode="directed")

# Add edges to the tree
for (i in 1:nrow(tree_matrix)){
    T_tree <- addEdge(V1[i], V2[i], T_tree, 1)
}

# Input CSV file
# snv_file <- system.file("extdata", "snv.csv", package = "PhySigs", mustWork = TRUE)
input_mat <- as.data.frame(read.csv(file=snv_file,
                                    colClasses = c("character", "character", "numeric", "character", "character")))

# Use deconstructSigs to convert SNVs to 96 Features
P <- deconstructSigs::mut.to.sigs.input(mut.ref = input_mat,
                                        sample.id = "Sample",
                                        chr = "chr",
                                        pos = "pos",
                                        ref = "ref",
                                        alt = "alt")

# Normalize feature matrix
P_Norm <- normalizeFeatureMatrix(P, "genome")

# Recover lowest error exposure matrix for every possible number of clusters. 
E_list <- allTreeExposures(T_tree, P_Norm, S)
len_E <- length(E_list)

error <- c()
for (k in 1:len_E){
    error[k] <- getError(P_Norm, E_list[[k]], S)
}

# Get BIC for exposure matrix from best set of k exposure shifts.
# Note that k exposure shifts corresponds to k+1 clusters.
bic <- c()
for (k in 1:len_E){
    bic[k] <- getBIC(P_Norm, E_list[[k]], S)
}

best <- which.min(bic)
print(paste("Best k: ", best))
print(paste("BIC: ", bic))

# Get tree output formatted for visualization.
tumorID <- "Tumor1"
tree_idx <- 1
o_trees <- outputTrees(tumorID, tree_idx, T_tree)
write.table(o_trees, file=o_tree_file, append=FALSE, quote=FALSE, sep='\t', row.names=FALSE)

# Get exposure output formatted for visualization
o_exposures <- outputExposures(tumorID, tree_idx, E_list, best)
write.table(o_exposures, file=o_exposure_file, append=FALSE, quote=FALSE, sep='\t', row.names=FALSE)

# Get tree figure with pie chart nodes showing exposures.
tumorID <- "Tumor1"
title <- "PhySigs Exposure-Tree"
pdf(o_pdf_file)
plotTree(tumorID, title, T_tree, E_list[[best]], tree_idx=1)
dev.off()
