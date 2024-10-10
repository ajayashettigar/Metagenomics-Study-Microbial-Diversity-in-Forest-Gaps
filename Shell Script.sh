###CREATE A DIRECTORY TO SAVE THE QIIME OUTPUT FILES###

###RAW_READS TO ARTIFACTS###
qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path manifest.tsv --output-path qiime/paired-end-demux.qza --input-format PairedEndFastqManifestPhred33V2

###GET INTO THE QIIME DIRECTORY FOR FURTHER ANALYSIS###
mkdir qiime

###QIIME SUMMARISE###
qiime demux summarize --i-data paired-end-demux.qza --o-visualization demux.qzv

###DENOISING WITH DEBLUR###
qiime deblur denoise-16S --i-demultiplexed-seqs paired-end-demux.qza --p-trim-length 301 --o-representative-sequences rep-seqs-deblur.qza --o-table table-deblur.qza --p-sample-stats --o-stats deblur-stats.qza --verbose

###RENAME FILES###
mv rep-seqs-deblur.qza rep-seqs.qza
mv table-deblur.qza table.qza

###FEATURE TABLE SUMMARIZE###
qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file ../metadata.tsv

###FEATURE TABLE TABULATE###
qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv

###PHYLOGENITY AND DIVERSITY###
qiime phylogeny align-to-tree-mafft-fasttree --i-sequences rep-seqs.qza --o-alignment aligned-rep-seqs.qza --o-masked-alignment masked-aligned-rep-seqs.qza --o-tree unrooted-tree.qza --o-rooted-tree rooted-tree.qza

###ALPHA AND BETA DIVERSITY ANALYSIS###
qiime diversity core-metrics-phylogenetic --i-phylogeny rooted-tree.qza --i-table table.qza --p-sampling-depth 10 --m-metadata-file ../metadata.tsv --output-dir core-metrics-results

qiime diversity alpha-group-significance --i-alpha-diversity core-metrics-results/faith_pd_vector.qza --m-metadata-file ../metadata.tsv --o-visualization core-metrics-results/faith_pd_group_significance.qzv

qiime diversity alpha-group-significance --i-alpha-diversity core-metrics-results/evenness_vector.qza --m-metadata-file ../metadata.tsv --o-visualization core-metrics-results/evenness_group_significance.qzv

qiime diversity beta-group-significance --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza --m-metadata-file ../metadata.tsv --m-metadata-column location_name --o-visualization core-metrics-results/unweighted-unifrac-body-site-significance.qzv --p-pairwise

qiime emperor plot --i-pcoa core-metrics-results/unweighted_unifrac_pcoa_results.qza --m-metadata-file ../metadata.tsv --p-custom-axes colwithnumericvalue --o-visualization core-metrics-results/unweighted-unifrac-emperor-colwithnumericvalue.qzv

qiime emperor plot --i-pcoa core-metrics-results/bray_curtis_pcoa_results.qza --m-metadata-file ../metadata.tsv --p-custom-axes num_bases --o-visualization core-metrics-results/bray-curtis-emperor-colwithnumericvalue.qzv

qiime diversity alpha-rarefaction --i-table table.qza --i-phylogeny rooted-tree.qza --p-max-depth 150 --m-metadata-file ../metadata.tsv --o-visualization alpha-rarefaction.qzv

####TAXONOMY ANALYSIS###

###GET THE GG DATABASE OF YOUR WORKING QIIME2 VERSION (mine:2024.2)###
wget -O "gg-13-8-99-515-806-nb-classifier.qza" "https://data.qiime2.org/2024.2/common/gg-13-8-99-515-806-nb-classifier.qza"

qiime feature-classifier classify-sklearn --i-classifier gg-13-8-99-515-806-nb-classifier.qza --i-reads rep-seqs.qza --o-classification taxonomy.qza

qiime metadata tabulate --m-input-file taxonomy.qza --o-visualization taxonomy.qzv

qiime taxa barplot --i-table table.qza --i-taxonomy taxonomy.qza --m-metadata-file ../metadata.tsv --o-visualization taxa-bar-plots.qzv

qiime feature-table filter-samples --i-table table.qza --m-metadata-file ../metadata.tsv --p-where "[location_name] IN ('Schwaebische Alb', 'Schorfheide')" --o-filtered-table location-filtered-table.qza

qiime composition add-pseudocount --i-table location-filtered-table.qza --o-composition-table comp-location-filtered-table.qza
