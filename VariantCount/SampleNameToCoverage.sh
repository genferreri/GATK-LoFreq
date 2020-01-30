#Add sample name to *_coverage files

NAME=$(find . -maxdepth 1 -name "*_cutadapt_coverage" | xargs -I {} basename {} _cutadapt_coverage)

##add name of the sample
awk -F, -v s="$NAME" '{$4=s; print }' "$NAME"_cutadapt_coverage > "$NAME"_cutadapt_coverage.temp.txt

##remove "-" from name
tr -d '-' < "$NAME"_cutadapt_coverage.temp.txt > "$NAME"_cutadapt_coverage.txt

rm "$NAME"_cutadapt_coverage.temp.txt