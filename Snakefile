import pandas as pd


##### load config and sample sheets #####

#configfile: "config.yaml"

samples = pd.read_table(config["samples"], index_col="sample")

rule all:
    input:
        expand("cov/{sample.sample}.depthOfCov.COUNT_READS.sample_summary", sample=samples.reset_index().itertuples()),
#        expand("cov/{sample.sample}.depthOfCov.COUNT_READS.sample_statistics", sample=samples.reset_index().itertuples()),
        expand("cov/bbmap/{sample.sample}.bbmap.covstats.txt", sample=samples.reset_index().itertuples()),
        expand("cov/bbmap/{sample.sample}.bbmap.hist.txt", sample=samples.reset_index().itertuples()),
        expand("cov/bbmap/{sample.sample}.bbmap.bincov.txt", sample=samples.reset_index().itertuples()),
        "qc/multiqc.html",
        "cov/plots/bbmap_coverage_hist.pdf",
        "cov/plots/gatk_coverage_hist.pdf",
        "cov/plots/mean_coverage_bbmap_from_covstats.pdf"
##### load rules #####

include_prefix="rules"


include:
    include_prefix + "/functions.py"
include:
    include_prefix + "/depth_cov.smk"
include:
    include_prefix + "/bbmap.smk"
include:
    include_prefix + "/multiqc.smk"
include:
    include_prefix + "/plots.smk"

