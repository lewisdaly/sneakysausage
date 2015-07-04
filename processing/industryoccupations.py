import json
import sys

print "{"

with open('industries.json') as industries:
	industries_data = json.load(industries)

	with open('occupations.json') as occupations:
		occupations_data = json.load(occupations);

		industry_index = 0;
		for industry in industries_data['industries']:
			print "\"" + industry + "\":{"

			print_string = ""
			for key in occupations_data:
				occupation = occupations_data[key]
				occupation_industries = occupation["industries"]
				print_string = print_string + "\"" + key + "\":"  + str(occupation_industries[industry_index]) + ","
				# print_string = print_string.rstrip(",")
			
			print print_string

			print "},"
			industry_index = industry_index + 1
print "}"