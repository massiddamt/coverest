import pandas as pd

##### load config and sample sheets #####
report: "report/workflow.rst"

configfile: "config.yaml"

samples = pd.read_table(config["samples"], index_col="sample")

localrules: all, active_gatk, active_gatkdoc_plugin

rule all:
    input:
#        "logs/gatk/gatk_activation.done",
#        "logs/multiqc/gatkdoc_plugin_activation.done",
#        "cov/plots/testfile2.html",
        expand("cov/{sample.sample}.depthOfCov.COUNT_READS.sample_summary", sample=samples.reset_index().itertuples()),
#        expand("cov/{sample.sample}.depthOfCov.COUNT_READS.sample_statistics", sample=samples.reset_index().itertuples()),
#        expand("cov/bbmap/{sample.sample}.bbmap.covstats.txt", sample=samples.reset_index().itertuples()),
#        expand("cov/bbmap/{sample.sample}.bbmap.hist.txt", sample=samples.reset_index().itertuples()),
#        expand("cov/bbmap/{sample.sample}.bbmap.bincov.txt", sample=samples.reset_index().itertuples()),
        "qc/multiqc.html"
#        expand("cov/qualimap/{sample.sample}.pdf", sample=samples.reset_index().itertuples()),
#        "cov/plots/bbmap_coverage.png",
#        "cov/plots/gatk_coverage.png"

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
include:
    include_prefix + "/qualimap.smk"

