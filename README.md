# Metagenomics-Study-Microbial-Diversity-in-Forest-Gaps

## Overview

This repository contains the code and data for a metagenomic study exploring microbial diversity within different forest gaps using QIIME2 pipelines. The study, conducted during my internship, investigates the impact of forest structure on microbial communities in the Schwaebische Alb and Schorfheide Exploratories.

## Project Goals

- **Uncover Microbial Diversity:** Analyze microbial diversity in open and closed forest gaps.
- **Compare Forest Gaps:** Assess differences in microbial communities between the Schwaebische Alb and Schorfheide regions.
- **Use QIIME2 Pipelines:** Employ advanced QIIME2 tools for data processing and analysis.

## Data

The raw sequencing data from all samples were deposited in the NCBI-SRA database under project accession number `PRJNA1077245`. Samples were collected from two distinct European forest Exploratories: Schwaebische Alb and Schorfheide. 

In each exploratory, soil samples were taken from:
- Stumps located within the gap,
- Trees positioned at the edge of the gap, and
- Trees within the forest stand.

## Analysis

1. **Demultiplexing:** Processed using `demux.qzv` to ensure high-quality sequencing data with consistent Phred scores of 30 across all bases.
2. **Feature Table:** Summary from `table.qzv` showing sample counts and feature distributions across different forest gaps.
3. **Taxonomic Classification:** `taxa-bar-plots.qzv` visualization of microbial taxa distribution in samples.
4. **Alpha Diversity:** Analysis using the Shannon Index to evaluate microbial diversity within samples.
5. **Beta Diversity:** Principal Coordinates Analysis (PCoA) using Bray-Curtis distances to compare microbial communities between locations.

## Getting Started

### Prerequisites

- QIIME2 installed
- Access to raw sequencing data and metadata

### Usage

1. **Data Processing:** Follow the QIIME2 pipeline scripts included in the `qiime_script.sh` for processing and analyzing the sequencing data.
2. **Visualization:** Generate visualizations using [QIIME2 view tools](https://view.qiime2.org/) and review results in the `results/` directory.

## Acknowledgments

- Thanks to Mediomix for providing the facilities and opportunity.
- Special appreciation to Ms. Shilpa Rathod, Mr. Dilip, and Ms. Sakti Kavita for their guidance and support during the project.

## Contact

For any questions or suggestions, please contact (ajshettigar1253@gmail.com).
