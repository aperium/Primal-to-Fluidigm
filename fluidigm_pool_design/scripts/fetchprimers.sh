# get the primers form primal scheme into a single file with the names of the genes

# set file name and clear existing file
FILE=allprimers.tsv
if test -f "$FILE"; then
	rm $FILE
fi


#pull all of the primalscheme primers into a temporary file
cd ../primalscheme/overlap_70
LIST=(*/*.primer.tsv)
for name in ${LIST[@]}; do
	(awk 'BEGIN{FS = "\t"}{OFS="\t"}NR>1{print FILENAME,$1,$2,$3,$4,$5,$6}' $name) >> ../../clustal_on_primers/$FILE.tmp
done

# prepare the column headers for the new file
(awk 'BEGIN{OFS="\t"}NR<=1{print "gene",$0}' ${LIST[1]}) > ../../clustal_on_primers/$FILE

# fill the new file with the primer data and clean up the "gene" and "name" columns
cd ../../clustal_on_primers
awk 'BEGIN{FS="\t|\tGene1_|/"}{OFS="\t"}{print $1,$3,$4,$5,$6,$7,$8}' $FILE.tmp >> $FILE

# delte the temporary file
rm $FILE.tmp
