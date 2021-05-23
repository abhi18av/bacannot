process digis {
  publishDir "${params.outdir}/${prefix}", mode: 'copy', saveAs: { filename ->
    if (filename.indexOf("_version.txt") > 0) "tools_versioning/$filename"
    else "$filename"
  }
  tag "Scanning for Insertion Sequences with digIS"
  label 'main'

  input:
  tuple val(prefix), file(genome), file(genbank)

  output:
  // Grab results
  file("digIS")

  script:
  """
  # activate env
  conda activate digIS ;
  
  # run digIS
  python3 /work/digIS/digIS_search.py -i $genome -g $genbank -o digIS
  """
}
