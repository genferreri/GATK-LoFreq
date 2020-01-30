#Add sample name to *_coverage files

for f in *.txt
do 
	NAME=${f%%.*}
	echo $NAME
	##add name of the sample
	awk -F, -v s="$NAME" '{$6=s; print }' "$NAME".SNPdat.txt > "$NAME".SNPdat.temp.txt

	rm "$NAME".SNPdat.txt

	##remove "-" from name
	tr -d '-' < "$NAME".SNPdat.temp.txt > "$NAME".SNPdat.txt

	rm "$NAME".SNPdat.temp.txt
done