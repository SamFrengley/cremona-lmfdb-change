This is a short piece of code which will give you (via rather inefficient methods) the correspondence between LMFDB labels and Cremona labels of elliptic curves in Magma.

Usage:
- You should copy the `ecdata/alllabels` directory from John Cremona's [*ecdata repository*](https://github.com/JohnCremona/ecdata.git) somewhere locally.
- Point the `EC_LMFDB.m` file to where you have saved this directory by altering the variable `HERE_IS_ecdata` at the top of the file.