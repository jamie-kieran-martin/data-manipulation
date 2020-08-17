# export subjects
cut -f7 -d ',' biopics_v2.csv |
# remove csv header
tail -n +2 | 
# unescape escaped strings
sed 's/"//;s|"$||' |
tr -s "\"" \' |
# clean up whitespace errors
sed 's/^[ \t]*//;s/[ \t]*$//' |  
# sort alphabetically
sort | 
# get count of uniqueness
uniq -ic |
# format [count] [subject] to subject,count
awk '{ print substr($0, index($0,$2)) "," $1}' |
# finally sort again and send to txt file
sort > ba1.txt