
rule plot_bbmap_coverage:
    input:
        "cov/bbmap/"
    output:
        "cov/plots/bbmap_coverage_hist.pdf"
    conda:
        "../envs/plots.yaml"
    script:
        """../scripts/bbmap_coverage.R"""



rule plot_depthofcoverage:
    input:
        "cov/"
    output:
        "cov/plots/gatk_coverage_hist.pdf"
    conda:
        "../envs/plots.yaml"
    script:
        """../scripts/depthofcoverage.R"""



rule plot_bbmap_coverage_singlesample:
    input:
        "/home/matteo/Scrivania/coverest_plots/bbmap/"
    params:
        28
    conda:
        "../envs/plots.yaml"
    script:
        """../scripts/bbmap_singlesample.R"""



rule plot_bbmap_coverage_on_chromosomes:
    input:
        "cov/bbmap/"
    output:
        "cov/plots/mean_coverage_bbmap_from_covstats.pdf"
    params:
        28
    conda:
        "../envs/plots.yaml"
    script:
        """../scripts/bbmap_cov_chroms.R"""