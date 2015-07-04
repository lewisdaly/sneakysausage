import sys

print "{\"industries\":["
line_number = 0;
for line in sys.stdin:
	if line_number is 7:
		industry_number = 0;
		for industry in line.split(","):
			if industry_number >= 27 and industry_number <= 51:
				print "\"" +industry.replace('\"', "").strip() + "\","
			industry_number = industry_number + 1

	line_number  = line_number + 1;

print "]}"