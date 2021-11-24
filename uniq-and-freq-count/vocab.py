from collections import Counter
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--input_file')
parser.add_argument('--output_file')
args = parser.parse_args()

with open(args.input_file, 'r') as f:
    sents = f.readlines()

words = [line.split() for line in sents]
list_words = []
for line in words:
    for word in line:
        list_words.append(word)

counter = Counter(list_words)

with open(args.output_file, 'w') as f:
    for word, count in counter.most_common(len(counter)):
        f.write('{}\t{}\n'.format(word, count))
print('File saved!')
