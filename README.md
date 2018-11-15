 # COVerest
Snakemake enabled pipeline for coverage estimation


## Authors

* [Matteo Massidda](https://bitbucket.org/massiddaMT/)
* [Gianmauro Cuccuru](https://bitbucket.org/gmauro/)

## Tools
[GATK DepthOfCoverage](https://software.broadinstitute.org/gatk/documentation/tooldocs/3.8-0/org_broadinstitute_gatk_tools_walkers_coverage_DepthOfCoverage.php)\
[BBMAP](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbmap-guide/)\
[Qualimap](http://qualimap.bioinfo.cipf.es/)\
[MultiQC](https://multiqc.info/)


## Requirements

Conda must be present in your computer.
To install it, see [https://conda.io/miniconda.html](https://conda.io/miniconda.html)

GATK DepthOfCoverage is not implemented in GATK 4.*.\
For this reason you need the GATK 3.7 version.\
The pipeline installs a MultiQC plugin for DepthOfCoverage output inclusion in the report.
# Usage

## Getting started

### Prepare the environment

1. Create a conda virtual environment
    ```bash
    conda create -n _project_name_ -c bioconda --file requirements.txt
    ```

2. Activate the virtual environment
    ```bash
    source activate _project_name_
    ```

3. Clone the repository [COVerest](https://bitbucket.org/massiddaMT/coverest/)
    ```bash
       git clone https://bitbucket.org/massiddaMT/coverest/src/master/
    ```

4. Change directory to coverest
    ```bash
    cd coverest
    ```

5. Edit config file as needed
    ```bash
    vi config.yaml
    ```


### Execute workflow

1. Test your configuration by performing a dry-run via
    ```bash
    snakemake --use-conda --configfile config.yaml --directory test --dryrun
    ```

2. Execute the workflow locally with test data into a test directory
    ```bash
    snakemake --use-conda --cores $N --configfile config.yaml --directory test
    ```
using `$N` cores

More details to execute Snakemake at [Snakemake documentation](https://snakemake.readthedocs.io).
