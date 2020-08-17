# overwrite initial html doc and table header into file 
echo "<!DOCTYPE html>
<html>
	<body>
		<table>
			<tr><th>Country</th><th>Gross Total</th></tr>
" > ba2.html 

# export title|country|gross
cut -f 1,2,4 -d ',' biopics_v2.csv --output-delimiter='|' | 
# remove headers
tail -n +2 |
# remove $ signs (for gross cleanup) 
tr -d '$' | 
# remove gross with '-'
sed '/|-/d' |
# get unique values 
uniq |
# iterate over lines and add gross' to country key value store
# print in format country grossTotal 
awk -F'|' '
{
	a[$2]+=$3
}
END {
	for (i in a)
		print i,a[i]
}' | 
# sort and write over file
sort |
sed 's/ /<\/td><td>$/g' | 
sed 's/^/<tr><td>/g' | 
sed 's/$/<\/td><\/tr>/g' >> ba2.html

# append end html closing tags
echo "
		</table>
	</body>
</html>" >> ba2.html