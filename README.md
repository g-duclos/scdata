![Logo](inst/extdata/scdata_Logo.png)

***

# **scdata**
An R package for quickly loading pre-processed single-cell (sc) RNA-Seq data for downstream experimentation. The *scdata* package contains a library of public scRNA-Seq data and code required to update that library as needed.

***

## Installation

The **scdata** R package can be installed from Github using devtools:
```
devtools::install_github("g-duclos/scdata")
```

***

## Getting Started

#### View Available Data

```
library(scdata)

# Load MetaData
data(scdata_metadata, package="scdata")

# View available package data
print(scdata_metadata)
```

| Sample_ID | Source | Type | Unit |
| --- | --- | --- | --- |
| `PBMC_3p_10K` | 10x_Genomics | PBMC | Cells |
| `PBMC_5p_10K` | 10x_Genomics | PBMC | Cells |
| `Breast_Tumor_3p` | 10x_Genomics | Breast_Tumor | Cells |
| `Brain_Tumor_3p` | 10x_Genomics | Brain_Tumor | Cells |
| `Intestine_Nuc_3p` | 10x_Genomics | Intestine | Nuclei |


#### Load Example Data

```
# Load scRNA-Seq Data
data(PBMC_3p_10K, package="scdata")

# Print the top 5 genes detected in the 1st cell of 'PBMC_3p_10K' to confirm you have loaded data
PBMC_3p_10K_ordered <- PBMC_3p_10K[order(PBMC_3p_10K[,1], decreasing=TRUE), ]
print(PBMC_3p_10K_ordered[1:5, 1:2])
```

|     | AAACCCAGTATATGGA-1 | AAACCCAGTATCGTAC-1 |
| --- | --- | --- |
`ENSG00000251562` | 100 | 2 |
`ENSG00000198712` | 65 | 1 |
`ENSG00000198804` | 64 | 3 |
`ENSG00000198938` | 57 | 2 |
`ENSG00000198899` | 55 | 0 |


