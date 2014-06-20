.PHONY: clean

nhc_analysis: create_table.sql
	sqlite3 nhc_analysis < create_table.sql

clean:
	rm -rf nhc_analysis