./check_sql.sh

# select subject and counts 
# grouped by trimmed case-insensitive subject 
# (remove whitespace errors)
sqlite3 biopics.sqlite "
SELECT TRIM(subject), COUNT(subject) 
from biopics 
GROUP BY UPPER(TRIM(subject));" |
# change | to ,
tr '|' ',' |
# fix double quote ("") -> (') issues
tr '\"' \' |
# sort and send to txt
sort > sa1.txt