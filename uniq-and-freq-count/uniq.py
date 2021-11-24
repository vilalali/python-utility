import sys
import re
import os
#import replace_list   #custom import file for word replacement
from argparse import ArgumentParser

parser = ArgumentParser(description='To make content of a file unique'+
						"How to Run?\n" +
						"python3 " + sys.argv[0] + " -i=inputfie"
						)

parser.add_argument("-i", "--input", dest="inputfile",
					help="provide .txt file name",required=True)

args = parser.parse_args()

inputfile = args.inputfile

#open input file using open file mode
fp1 = open(inputfile, encoding="utf-8") # Open file on read mode
lines = fp1.read().split("\n") # Create a list containing all lines
fp1.close() # Close file

uniq_hash = {}

fw1 = open("uniq.txt","w", encoding="utf-8")
fw2 = open("duplicates.txt","w", encoding="utf-8")

for line in lines:
	if(line == ""):
		continue
	cols = line.split("\t")
	if cols[0] in uniq_hash:
		t = uniq_hash[cols[0]]
		uniq_hash[cols[0]] = t + 1
	else:
		uniq_hash[cols[0]] = 1

print_hash = {}

for line in lines:
	if(line == ""):
		continue
	cols = line.split("\t")
	if cols[0] not in print_hash:
		fw1.write(line + "\n")
	if uniq_hash[cols[0]] > 1:
			fw2.write(line + "\t" + str(uniq_hash[cols[0]]) + "\n")

	#fw1.write(line + "\n")
	
	print_hash[cols[0]] = 1


fw1.close()
fw2.close()


