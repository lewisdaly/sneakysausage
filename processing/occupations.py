import sys
import csv

print "{"
line_number = 0;
with open("occupations.csv", "rb") as csvfile:
	rowreader = csv.reader(csvfile)
	for line in rowreader:
		print_string =  "\"" + line[0] + "\":{" + "\"occupationName\":" + "\"" + line[1].replace("\"", "") + "\"" + ",\"industries\":" + str(line[2:]).replace("'", "").replace("\\r\\n", "") + "},"
		print_string.replace("\\r", "")
		print print_string

print "}"
		


