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

   - How to install?

   - ```shell
     # launch interactive session
     sinteractive -A PAS1755 -t 60
     
     # move to appropriate directory
     cd /fs/scratch/PAS1755/drw_wd/
     
     # load the latest python
     # module spider python
     # module load python/3.7-2019.10
     
     # OSC specific instructions?
     module load python/3.6-conda5.2
     conda create -y -n clustalo-env -c conda-forge python=3.9
     source activate clustalo-env
     conda install -y biopython
     
     # install?
     # mkdir clustalomega
     # cd clustalomega
     # python3 -m venv venv
     # source venv/bin/activate
     # 
     # pip install --upgrade pip # added to upgrade pip
     # conda install -y biopython
     ## TODO
     
     # test
     
     
     # exit environment
     deactivate
     
     # end interactive session
     exit
     ```

   - 

4. `assessmatricies.R` processes clustal omega results into a pairwise comparison of primer identity.

5. Split primary pools (designed by primalsceme) into secondary and tertiary pools to minimize identity while keeping pairs together.

   - [ ] write a script to automate this: `splitpools.R`

