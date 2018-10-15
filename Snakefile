import pandas as pd

##### load config and sample sheets #####

configfile: "config.yaml"

samples = pd.read_table(config["samples"], index_col="sample")

rule all:
    input:
        expand("reads/cov/{sample.sample}.depthOfCov.COUNT_READS.sample_summary", sample=samples.reset_index().itertuples()),
        expand("reads/cov/{sample.sample}.depthOfCov.COUNT_READS.sample_statistics", sample=samples.reset_index().itertuples()),
        expand("reads/cov/bbmap/{sample.sample}.bbmap.covstats.txt", sample=samples.reset_index().itertuples()),
        expand("reads/cov/bbmap/{sample.sample}.bbmap.hist.txt", sample=samples.reset_index().itertuples()),
        expand("reads/cov/bbmap/{sample.sample}.bbmap.bincov.txt", sample=samples.reset_index().itertuples())

##### load rules #####

include_prefix="rules"

include:
    include_prefix + "/functions.py"
include:
    include_prefix + "/depth_cov.smk"
include:
    include_prefix + "/bbmap.smk"
