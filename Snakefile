import pandas as pd


##### load config and sample sheets #####

configfile: "config.yaml"




samples = pd.read_table(config["samples"], index_col="sample")
units = pd.read_table(config["units"], index_col=["unit"], dtype=str)



rule all:
    input:
        expand("coverage/{sample.sample}.depthOfCov.COUNT_READS", sample=samples.reset_index().itertuples())


##### load rules #####

include_prefix="rules"

include:
    include_prefix + "/depth_cov.smk"
