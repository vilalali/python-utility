import sys

with open(sys.argv[1]) as fp:
    for line in fp:
       # print(' '.join(list(line.strip())))
       print(' '.join(list(line.strip().decode('utf-8'))).encode('utf-8'))

