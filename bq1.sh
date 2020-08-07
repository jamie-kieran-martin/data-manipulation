# export subjects
cut -f7 -d ',' biopics_v2.csv | 
# remove csv header
tail -n +2 | 
# unescape escaped strings
tr -d "\"" | 
# clean up whitespace errors
sed 's/^[ \t]*//;s/[ \t]*$//' |  
# sort alphabetically
sort | 
# get count of uniqueness
uniq -c | 
# format [count] [subject] to subject,count
sed 's|^ *\([0-9]*\) \(.*\)|\u\2,\1|g' > ba1.txt 