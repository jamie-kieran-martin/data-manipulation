./check_sql.sh

# overwrite initial html doc and table header into file 
echo "<!DOCTYPE html>
<html>
	<body>
		<table>
			<tr><th>Year Released</th><th>Average Amount</th></tr>
" > sa3.html

# **working inwards -> outwards for SQL**
# create a cleaned selection of year_released, gross 
# ignoring null gross values and grouping by title for uniqueness
#
# from that create a selection of year_release, grossAvg
# grouped by year_released
#
# from that select the year_released and a cleaned version of the grossAvg 
# grossAvg (round to nearest whole number with $ appended to front) 
sqlite3 biopics.sqlite -html "
SELECT year_release, printf(\"$%.0f\", grossAvg) as grossAvg
from (
	SELECT year_release, ROUND(AVG(gross) - 0.5) as grossAvg
	from (
		SELECT year_release, replace(gross, '$', '') as gross
		FROM biopics 
		WHERE gross != '-' 
		GROUP BY title
		) 
	GROUP BY year_release);" >> sa3.html

# append end html closing tags
echo "
		</table>
	</body>
</html>" >> sa3.html