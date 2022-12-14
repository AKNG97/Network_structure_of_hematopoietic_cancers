# Step2: Differential gene expression analysis
#The unnormalized expression matrix was used to detect differentially expressed genes using the DESeq2 package.

library(DESeq2)

#The input for this script is the unnormalized rnas1 object and the factors object created in the Stage 1.

dds <- DESeqDataSetFromMatrix(countData = round(rnas1),
                              colData = factors,
                              design = ~ Group)

dds <- DESeq(dds)

#Set the NormalBM group as the reference in the analysis
dds$Group <- relevel(dds$Group, ref = "NormalBM")
dds <- DESeq(dds)

# Log fold change shrinkage for visualization and ranking
resLFC <- lfcShrink(dds, coef="Group_MM_vs_NormalBM", type="apeglm")

write.table(resLFC, file = "resLFC_MM_vs_NormalBM.tsv", row.names = TRUE, col.names = NA, sep = "\t", quote = FALSE)
