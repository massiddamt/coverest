import pandas as pd
import os
from os import listdir, system

##### load config and sample sheets #####

configfile: "config.yaml"




samples = pd.read_table(config["samples"], index_col="sample")

rule all:
    input:
        expand("reads/cov/{sample.sample}.depthOfCov.COUNT_READS", sample=samples.reset_index().itertuples())


##### load rules #####

include_prefix="rules"


include:
    include_prefix + "/functions.py"
include:
    include_prefix + "/depth_cov.smk"
