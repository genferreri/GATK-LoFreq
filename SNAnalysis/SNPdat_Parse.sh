#!/bin/bash
#20191227
#This is the latest version of ParseALT_SNPdat.sh
#This needs the reference sequence WF10_curated_varpatch.fa as well as the GTF file WF10ref.gtf.txt

#Run SNPdat
for f in *.txt; do FILENAME=${f%%.*};
perl SNPdat_v1.0.5.pl -i ${FILENAME}.AF.Cov.ALT.vcf.txt -f WF10_curated_varpatch.fa -g WF10ref.gtf.txt;
done; 

#Parse columns
for r in *.output; do FILENAME=${r%%.*};
cat ${FILENAME}.AF.Cov.ALT.vcf.txt.output | awk 'NR>1' | \
awk 'BEGIN{OFS"\t"} {split($21, a, "/"); print $1 "\t" $2 "\t" a[1] "\t" a[2] "\t" $22}' | \
awk 'BEGIN{OFS"\t"} {split($3, a, "["); split ($4, b, "]"); print $1 "\t" $2 "\t" a[2] "\t" b[1] "\t" $5}' \
> ${FILENAME}.SNPdat.txt; 
done;

rm *.summary 

mkdir SNPdat

mv *vcf.txt ./SNPdat
mv *.output ./SNPdat



