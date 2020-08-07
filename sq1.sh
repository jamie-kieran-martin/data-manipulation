# select subject and counts 
# grouped by trimmed subject 
# (remove whitespace errors)
sqlite3 biopics.sqlite '
SELECT subject, COUNT(subject) 
from biopics 
GROUP BY TRIM(subject);' |
# change | to , and write over file
tr '|' ',' > sa1.txt