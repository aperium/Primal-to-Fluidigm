# Primal-to-Fluidigm

This is a workflow to produce well-designed primer pools for Fluidigm multiplexing on a 48.48 access array from the output of primal scheme and clustal omega.

## Workflow Summary

1. Clustering of homologs
   1. Generate a list of genomic sequences as fasta files.
   2. Submit to Clustal Omega. 
   3. Use tree to group highly related sequences.
   4. Each group or ungrouped individual sequences get their own fasta files.
2. Primer generation
   1. Submit each fasta file to primal scheme with desired parameters
   2. 

## TODO

- [ ] write up the basic scope, design, and expected behaviour.
- [x] copy over those files that are relevant to this improved version.
- [x] add access to data inputs, probably by coping the data into a subdirectory in this repository.
- [ ] add functionality to split pools designed by primal scheme into pools designed for multiplexing with the 48.48 access array.
  - no more than 10 primer pairs in any well on the daughter plate
  - no more than 80 primer pairs in any columb on the daughter plate (and 80 total on the mother plate, leaving the last two columns empty for buffers)
  - each multiplexing pool avoids overlapping amplicons.
  - extra space for primers in any pool can be filled with gSSRs or other kinds of markers.
    - may require running primal scheme on these gSSRs.
- [ ] improve flow with MAKE / Snakemake

## Notes

### Path on my local computer

```bash
/Users/$USER/Documents/GitHub/Primal-to-Fluidigm
```

