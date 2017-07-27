#!/usr/bin/env python
import sys
from collections import Counter
import numpy as np
import matplotlib.pyplot as plt
from operator import itemgetter

data = np.loadtxt(sys.argv[1], dtype='str')
print(data.shape)
c = Counter(data)

counts=sorted(c.values())
#plt.hist(counts)

#plt.show()
#plt.yscale('log')
#plt.show()

counts_pairs=sorted(c.items(), key=itemgetter(1), reverse=True)

counts = np.array(counts)

THRES = 0 

while np.sum(counts > THRES) > int(sys.argv[2]):
	THRES += 50

results = [t[0] for t in counts_pairs if t[1] >= THRES]
print(results)
