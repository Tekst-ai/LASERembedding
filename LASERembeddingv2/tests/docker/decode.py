import sys

import numpy as np

dim = 1024
X = np.fromfile(sys.argv[1], dtype=np.float32, count=-1)
X.resize(X.shape[0] // dim, dim)
print(X)
