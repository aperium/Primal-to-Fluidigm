# Order of execution

1. `fetchprimers.sh` retrieves the full list of primers for all genes from Primalscheme results.

2. `separatepools.R` separates primers into unique csv and fasta files by pool designation.

3. Submit each pool separately to clustal omega for identity analysis.

   - Install ClustalOmega?

     ```shell
     # TODO IDK what to do here. Biopython needs the commandline version installed to work.
     ```

     

   - How to install biopython

     ```shell
     # launch interactive session
     sinteractive -A PAS1755 -t 60
     
     # move to appropriate directory
     cd /fs/scratch/PAS1755/drw_wd/
     
     # OSC specific instructions
     module load python/3.6-conda5.2
     conda create -y -n clustalo-env -c conda-forge python=3.9
     # conda activate clustalo-env
     source activate clustalo-env
     conda install -y biopython
     
     # test
     
     
     # exit environment
     # conda deactivate
     source deactivate
     
     # end interactive session
     exit
     ```

   - Can be accessed in Python via biopython package [ClustalOmegaCommandLine](https://biopython.org/docs/1.75/api/Bio.Align.Applications.html#Bio.Align.Applications.ClustalOmegaCommandline). Run this from inside the active python3 environment:

     ```python
     from Bio.Align.Applications import ClustalOmegaCommandline
     in_file = "../out/pools/poo1.fasta"
     out_file = "../out/pools/clustalout/pool1_aligned.fasta"
     clustalomega_cline = ClustalOmegaCommandline(infile=in_file, outfile=out_file, verbose=True, auto=True)
     print(clustalomega_cline)
     # clustalo -i unaligned.fasta -o aligned.fasta --auto -v
     
     # run with this command:
     clustalomega_cline()
     
     # exit python
     exit()
     ```

4. `assessmatricies.R` processes clustal omega results into a pairwise comparison of primer identity.

5. Split primary pools (designed by primalsceme) into secondary and tertiary pools to minimize identity while keeping pairs together.

   - [ ] write a script to automate this: `splitpools.R`

