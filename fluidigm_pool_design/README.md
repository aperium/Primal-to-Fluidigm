# Order of execution

1. `fetchprimers.sh` retrieves the full list of primers for all genes from Primalscheme results.

2. `separatepools.R` separates primers into unique csv and fasta files by pool designation.

3. Submit each pool separately to clustal omega for identity analysis.

   - Can be accessed in Python via biopython package [ClustalOmegaCommandLine](https://biopython.org/docs/1.75/api/Bio.Align.Applications.html#Bio.Align.Applications.ClustalOmegaCommandline).

     ```python
     from Bio.Align.Applications import ClustalOmegaCommandline
     in_file = "unaligned.fasta"
     out_file = "aligned.fasta"
     clustalomega_cline = ClustalOmegaCommandline(infile=in_file, outfile=out_file, verbose=True, auto=True)
     print(clustalomega_cline)
     # clustalo -i unaligned.fasta -o aligned.fasta --auto -v
     ```

   - 

4. `assessmatricies.R` processes clustal omega results into a pairwise comparison of primer identity.

5. Split primary pools (designed by primalsceme) into secondary and tertiary pools to minimize identity while keeping pairs together.

   - [ ] write a script to automate this: `splitpools.R`

