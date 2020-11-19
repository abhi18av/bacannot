process platon {
  publishDir "${params.outdir}/${prefix}", mode: 'copy', saveAs: { filename ->
    if (filename.indexOf("_version.txt") > 0) "tools_versioning/$filename"
    else if (filename == "platon") "plasmids/$filename"
    else null
  }
  tag "Detecting plasmid contigs with platon"
  label 'main'

  input:
  tuple val(prefix), file(genome)

  output:
  file("platon")
  file("platon/${prefix}.tsv")
  file("platon_version.txt")

  script:
  """
  # Activate conda environment
  source activate PLATON ;

  # Get version
  platon --version > platon_version.txt ;

  # Unpack database
  tar zxvf /work/platon/db.tar.gz

  # Run platon
  platon --db db/ --output platon --threads ${params.threads} -c $genome ;
  """
}
