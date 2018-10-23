
rule plot_bbmap_coverage:
    input:
        "cov/bbmap/"
    output:
        "cov/plots/bbmap_coverage.pdf"
    script:
        "../scripts/bbmap_coverage.R"



rule plot_depthofcoverage:
    input:
        "cov/"
    output:
        "cov/plots/gatk_coverage.pdf"
    script:
        "../scripts/depthofcoverage.R"



rule plot_bbmap_coverage_singlesample:
    input:
        "cov/bbmap/"
    output:
        "cov/plots/singlesamples/{sample.sample}.coverage_bbmap_CHROMOSOME.pdf"

    params:
        28
    script:
        "../scripts/bbmap_singlesample.R"



rule plot_bbmap_coverage_on_chromosomes:
    input:
        "cov/bbmap/"
    output:
        "cov/plots/mean_coverage_bbmap_from_covstats.pdf"
    params:
        28
    script:
        "../scripts/bbmap_cov_chroms.R"