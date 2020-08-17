./check_sql.sh

# overwrite initial html doc and table header into file 
echo "<!DOCTYPE html>
<html>
	<body>
		<table>
			<tr><th>Country</th><th>Gross Total</th></tr>
" > sa2.html 

# **working inwards -> outwards for SQL**
# create a cleaned selection of country, gross 
# ignoring null gross values and grouping by title for uniqueness

# from that create a selection of country, grossTotal
# grouped by country

# from that select the country and a cleaned version of the grossTotal 
# grossTotal (round to nearest whole number with $ appended to front) 
sqlite3 biopics.sqlite -html "
SELECT country, printf(\"$%.0f\", grossTotal) as grossAmount
from (
	SELECT country, SUM(gross) as grossTotal 
	from (
		SELECT country, replace(gross, '$', '') as gross
		FROM biopics 
		WHERE gross != '-' 
		GROUP BY title
		) 
 	GROUP BY country);" >> sa2.html

# append end html closing tags
echo "
		</table>
	</body>
</html>" >> sa2.html