rule active_gatkdoc_plugin:
    output:
        touch("logs/multiqc/gatkdoc_plugin_activation.done")

    params:
        repo=config.get("repository").get("gatkdoc_plugin")

    shell:
        "git clone {params.repo} && cd gatkdoc_plugin && python setup.py install "





rule multiqc:
    input:
       "logs/multiqc/gatkdoc_plugin_activation.done",
       expand("cov/{sample.sample}.depthOfCov.COUNT_READS.sample_summary", sample=samples.reset_index().itertuples()),
#       expand("cov/{sample.sample}.depthOfCov.COUNT_READS.sample_statistics", sample=samples.reset_index().itertuples()),
       expand("cov/bbmap/{sample.sample}.bbmap.covstats.txt", sample=samples.reset_index().itertuples()),
       expand("cov/bbmap/{sample.sample}.bbmap.hist.txt", sample=samples.reset_index().itertuples()),
       expand("cov/bbmap/{sample.sample}.bbmap.bincov.txt", sample=samples.reset_index().itertuples()),
       expand("cov/qualimap/{sample.sample}/report.pdf",
              sample=samples.reset_index().itertuples())


    output:
        report("qc/multiqc.html", caption="../report/multiqc.rst", category="MULTIQC")
    params:
        config.get("rules").get("multiqc").get("arguments")
    log:
        "logs/multiqc/multiqc.log"

    conda:
       "../envs/multiqc.yaml"

    wrapper:
        "0.27.0/bio/multiqc"