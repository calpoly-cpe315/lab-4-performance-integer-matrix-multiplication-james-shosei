# cpe315-matmul
## Shosei Anegawa, James Rounthwaite

### To build:
```shell
make clean; make
To change from matmul to matmul-mul change the make file subisution
```

### To modify the size:
1. edit the matmul.h file
2. edit the line with: 
```C
#define MATRIX_SIZE
```
3. Save the file
4. Rebuild

### State of the Lab
The lab says if we don't have a working a mul we will recieve, but we never recived one. 
So our mul subroutine works with all numbers except negative numbers so we made the 
matrixes all positive. 

Other than that, matmul.s and matmul-mul.s work as expected. So all the new content for this lab work as intended
