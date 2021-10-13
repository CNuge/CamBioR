# bioreadr
## an r package for input and output of biological sequence data
---
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
---

#TODO - change the read_fasta and read_fastq functions so that they exclude the > and @ 
#possibly add a paramater so this can be controlled by the user. (do the same for the write functions)



## Installation

```
#install.packages("devtools")
#library(devtools) 
devtools::install_github("CNuge/bioreadr")
library(bioreadr)
```
 


## TODO

- write some unittest using example data
- add some warnings/error messages for bad fmtd data