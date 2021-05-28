# Bacterial Annotation (bacannot) Pipeline

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3627669.svg)](https://doi.org/10.5281/zenodo.3627669) ![](https://img.shields.io/github/v/release/fmalmeida/bacannot) [![Build Status](https://travis-ci.com/fmalmeida/bacannot.svg?branch=master)](https://travis-ci.com/fmalmeida/bacannot) ![](https://img.shields.io/badge/dependencies-docker-informational) [![Documentation Status](https://readthedocs.org/projects/bacannot/badge/?version=latest)](https://bacannot.readthedocs.io/en/latest/?badge=latest) ![](https://img.shields.io/badge/Nextflow-v20.07-yellowgreen)

Bacannot is an easy to use nextflow docker-based pipeline that adopts state-of-the-art software for prokaryotic genome annotation. It is a wrapper around a several tools that enables a better understanding of prokaryotic genomes. It uses:

* [Prokka](https://github.com/tseemann/prokka) for generic annotation
* [barrnap](https://github.com/tseemann/barrnap) for rRNA prediction
* [mlst](https://github.com/tseemann/mlst) for classification within multi-locus sequence types (STs)
* [KofamScan](https://github.com/takaram/kofam_scan) for KO annotation
* [KEGGDecoder](https://github.com/bjtully/BioData/tree/master/KEGGDecoder) for drawing KO annotation
* [Nanopolish](https://github.com/jts/nanopolish) for methylation annotation
* [JBrowse](http://jbrowse.org/) for genome browser production
* [bedtools](https://bedtools.readthedocs.io/en/latest/) for annotation merging
* [AMRFinderPlus](https://github.com/ncbi/amr/wiki) and [RGI](https://github.com/arpcard/rgi) for antimicrobial genes annotation
* [Phigaro](https://github.com/bobeobibo/phigaro) for prophage sequences prediction
* [IslandPath-DIMOB](https://github.com/brinkmanlab/islandpath) for genomic islands prediction
* [Plasmidfinder](https://cge.cbs.dtu.dk/services/PlasmidFinder/) for in silico plasmid detection
* And the databases: [CARD](https://card.mcmaster.ca/analyze/rgi), [ARGminer](https://bench.cs.vt.edu/argminer/#/classify;gene_id=A0A0Z8UZL1), [PHASTER](https://phaster.ca/), [ICEberg](https://academic.oup.com/nar/article/47/D1/D660/5165266), [Victors](http://www.phidias.us/victors/) and [VFDB](http://www.mgc.ac.cn/VFs/main.htm)

## Note to users

The bacannot pipeline is currently undergoing a huge update (as in issue [#2](https://github.com/fmalmeida/bacannot/issues/2)). In this updating I am fixing a few problems that I have detected in the automatic reports conditionals (some of them were being incorrectely dealt with). Also, this update holds new processes such as Resfinder annotation, a shiny parser for the outputs, and the reestructuration of few contents.

This update is set to be released in January. If you come into an error please contact me so I can check if this error is already being handled in this update or not so I can tackle it in the same release.

Cheers.

## Further reading

This pipeline has two complementary pipelines (also written in nextflow) for [NGS preprocessing](https://github.com/fmalmeida/ngs-preprocess) and [Genome assembly](https://github.com/fmalmeida/MpGAP) that can give the user a complete workflow for bacterial genomics analyses.

## Table of contents

* [Requirements](https://github.com/fmalmeida/bacannot#requirements)
* [Quickstart](https://github.com/fmalmeida/bacannot#quickstart)
* [Documentation](https://github.com/fmalmeida/bacannot#documentation)
  * [Full usage](https://github.com/fmalmeida/bacannot#usage)
  * [Usage Examples](https://github.com/fmalmeida/bacannot#usage-examples)
  * [Configuration File](https://github.com/fmalmeida/bacannot#using-the-configuration-file)
  * [Interactive and graphical execution](https://github.com/fmalmeida/bacannot#interactive-graphical-configuration-and-execution)

## Requirements

* Unix-like operating system (Linux, macOS, etc)
* Java 8
* Docker
  * `fmalmeida/bacannot:{latest, kofamscan, jbrowse, renv}`

This images have been kept separate to not create massive Docker image and to avoid dependencies conflicts.

## Quickstart

1. If you don't have it already install Docker in your computer. Read more [here](https://docs.docker.com/).
    * You can give this [in-house script](https://github.com/fmalmeida/bioinfo/blob/master/dockerfiles/docker_install.sh) a try.
    * After installed, you need to download the required Docker images

          docker pull fmalmeida/bacannot:v2.1
          docker pull fmalmeida/bacannot:kofamscan
          docker pull fmalmeida/bacannot:jbrowse
          docker pull fmalmeida/bacannot:v2.1_renv

2. Install Nextflow (version 20.07 or higher):

       curl -s https://get.nextflow.io | bash

3. Give it a try:

       nextflow run fmalmeida/bacannot --help

> Users can get let the pipeline always updated with: `nextflow pull fmalmeida/bacannot`

## Documentation

### Usage

* Complete command line explanation of parameters:
    + `nextflow run fmalmeida/bacannot --help`
* See usage examples in the command line:
    + `nextflow run fmalmeida/bacannot --examples`
* However, users are encouraged to read the [complete online documentation](https://bacannot.readthedocs.io/en/latest/).

### Command line usage examples

Command line executions are exemplified [in the manual](https://bacannot.readthedocs.io/en/latest/examples.html).

## Using the configuration file

All the parameters showed above can be, and are advised to be, set through the configuration file. When a configuration file is set the pipeline is run by simply executing `nextflow run fmalmeida/bacannot -c ./configuration-file`

Your configuration file is what will tell to the pipeline the type of data you have, and which processes to execute. Therefore, it needs to be correctly set up.

Create a configuration file in your working directory:

      nextflow run fmalmeida/bacannot --get_config

### Interactive graphical configuration and execution

Users can trigger a graphical and interactive pipeline configuration and execution by using [nf-core launch](https://nf-co.re/launch) utility.

#### Install nf-core

```bash
# Install nf-core
pip install nf-core
```

#### launch the pipeline

nf-core launch will start an interactive form in your web browser or command line so you can configure the pipeline step by step and start the execution of the pipeline in the end.

```bash
# Launch the pipeline
nf-core launch fmalmeida/bacannot
```

It will result in the following:

<p align="center">
<img src="./images/nf-core-asking.png" width="500px"/>
</p>

<p align="center">
<img src="./images/nf-core-gui.png" width="400px"/>
</p>

#### nextflow tower

This pipeline also accepts that users track its execution of processes via [nextflow tower](https://tower.nf/). For that users will have to use the parameters `--use_tower` and `--tower_token`.

# Citation

Please cite this pipeline using our Zenodo tag or directly via the github url. Also, whenever used/helpful, remember to cite the following software:

* [Prokka](https://github.com/tseemann/prokka) for generic annotation
* [barrnap](https://github.com/tseemann/barrnap) for rRNA prediction
* [mlst](https://github.com/tseemann/mlst) for classification within multi-locus sequence types (STs)
* [KofamScan](https://github.com/takaram/kofam_scan) for KO annotation
* [KEGGDecoder](https://github.com/bjtully/BioData/tree/master/KEGGDecoder) for drawing KO annotation
* [Nanopolish](https://github.com/jts/nanopolish) for methylation annotation
* [JBrowse](http://jbrowse.org/) for genome browser production
* [bedtools](https://bedtools.readthedocs.io/en/latest/) for annotation merging
* [AMRFinderPlus](https://github.com/ncbi/amr/wiki) and [RGI](https://github.com/arpcard/rgi) for antimicrobial genes annotation
* [Phigaro](https://github.com/bobeobibo/phigaro) for prophage sequences prediction
* [IslandPath-DIMOB](https://github.com/brinkmanlab/islandpath) for genomic islands prediction
* [Plasmidfinder](https://cge.cbs.dtu.dk/services/PlasmidFinder/) for in silico plasmid detection
* And the databases: [CARD](https://card.mcmaster.ca/analyze/rgi), [ARGminer](https://bench.cs.vt.edu/argminer/#/classify;gene_id=A0A0Z8UZL1), [PHASTER](https://phaster.ca/), [ICEberg](https://academic.oup.com/nar/article/47/D1/D660/5165266), [Victors](http://www.phidias.us/victors/) and [VFDB](http://www.mgc.ac.cn/VFs/main.htm)
