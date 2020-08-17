# run python command if biopics.sqlite does not exist
if [ ! -e "biopics.sqlite" ]; then
	echo "creating biopics.sqlite..."
    python3 csv2sqlite.py --table-name biopics --input biopics_v2.csv --output biopics.sqlite
fi