rule multiqc:
    input:
       expand("reads/cov/{sample.sample}.depthOfCov.COUNT_READS.sample_summary", sample=samples.reset_index().itertuples()),
       expand("reads/cov/{sample.sample}.depthOfCov.COUNT_READS.sample_statistics", sample=samples.reset_index().itertuples()),
       expand("reads/cov/bbmap/{sample.sample}.bbmap.covstats.txt", sample=samples.reset_index().itertuples()),
       expand("reads/cov/bbmap/{sample.sample}.bbmap.hist.txt", sample=samples.reset_index().itertuples()),
       expand("reads/cov/bbmap/{sample.sample}.bbmap.bincov.txt", sample=samples.reset_index().itertuples())

    output:
        "qc/multiqc.html"
    params:
        config.get("rules").get("multiqc").get("arguments")
    log:
        "logs/multiqc/multiqc.log"
    wrapper:
        "0.27.0/bio/multiqc"