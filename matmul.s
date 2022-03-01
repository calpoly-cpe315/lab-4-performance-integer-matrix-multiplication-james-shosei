////////////////////////////////////////////////////////////////////////////////
// You're implementing the following function in ARM Assembly
//! C = A * B
//! @param C          result matrix
//! @param A          matrix A 
//! @param B          matrix B
//! @param hA         height of matrix A
//! @param wA         width of matrix A, height of matrix B
//! @param wB         width of matrix B
//
//  Note that while A, B, and C represent two-dimensional matrices,
//  they have all been allocated linearly. This means that the elements
//  in each row are sequential in memory, and that the first element
//  of the second row immedialely follows the last element in the first
//  row, etc. 
//
//void matmul(int* C, const int* A, const int* B, unsigned int hA, 
//    unsigned int wA, unsigned int wB)
//{
//  for (unsigned int i = 0; i < hA; ++i)
//    for (unsigned int j = 0; j < wB; ++j) {
//      int sum = 0;
//      for (unsigned int k = 0; k < wA; ++k) {
//        sum += A[i * wA + k] * B[k * wB + j];
//      }
//      C[i * wB + j] = sum;
//    }
//}
////////////////////////////////////////////////////////////////////////////////

	.arch armv8-a
	.global matmul
matmul:
     ////////////////////////////////////////////////////////////////////////////////
// You're implementing the following function in ARM Assembly
//! C = A * B
//! @param C          result matrix
//! @param A          matrix A 
//! @param B          matrix B
//! @param hA         height of matrix A
//! @param wA         width of matrix A, height of matrix B
//! @param wB         width of matrix B
//
//  Note that while A, B, and C represent two-dimensional matrices,
//  they have all been allocated linearly. This means that the elements
//  in each row are sequential in memory, and that the first element
//  of the second row immedialely follows the last element in the first
//  row, etc. 
//
//void matmul(int* C, const int* A, const int* B, unsigned int hA, 
//    unsigned int wA, unsigned int wB)
//{
//  for (unsigned int i = 0; i < hA; ++i)
//    for (unsigned int j = 0; j < wB; ++j) {
//      int sum = 0;
//      for (unsigned int k = 0; k < wA; ++k) {
//        sum += A[i * wA + k] * B[k * wB + j];
//      }
//      C[i * wB + j] = sum;
//    }
//}
////////////////////////////////////////////////////////////////////////////////

	.arch armv8-a
	.global matmul
matmul:
     stp x29, x30, [sp, -96]!
     stp x19, x20, [sp, 16]
     stp x21, x22, [sp, 32]
     stp x23, x24, [sp, 48]
     stp x25, x26, [sp, 64]
     stp x27, x28, [sp, 80]

     mov x19, x0 // int *C - result matrix
     mov x20, x1 // int *A - mat A
     mov x21, x2 // int *B - mat B
     mov x22, x3 // int hA - height of A
     mov x23, x4 // int wA - width of A, height of B
     mov x24, x5 // int wB - width of B

     mov x25, #0 // counter for outer for loop - i

for1:
     mov x26, #0 //Counter for for loop 2 - j

for2:

     mov x28, #0 //SUMge

     mov x27, #0 //Counter for loop 3  - k

for3:
     mov x0, x25
     mov x1, x23  
     bl mymul

     mov x1, x27
     bl myadd
     ////mul x0, x25, x23 // i * wA
     ////add x0, x0, x27 // _ + k

     mov x1, #4 
     bl mymul
     ///mul x0, x0, x3 //integer size

     mov x1, x20
     bl myadd
    /////add x0, x0, x20 // A + _
     ldr x0, [x0]

     str x0, [sp, -16]! //storing x0 on the fucking cocksucking stack

     mov x0, x27
     mov x1, x24
     bl mymul

     mov x1, x26
     bl myadd
     ///mul x0, x27, x24 // k * wB
    ////add x0, x0, x26 // _ + j

     mov x1, #4
     bl mymul
     /////mul x0, x0, x3 //integer size
     
     mov x1, x21
     bl myadd
     ////add x0, x0, x21 // B + _
     ldr x0, [x0]

     ldr x1, [sp], 16 

     bl myadd
     ////add x0, x0, x1 // A[] + B[]

     mov x1, x28
     bl myadd
     mov x28, x0
     ////add x28, x0, x28 // sum += _

cringefor3:
     /////add x27, x27, #1
     mov x0, x27
     mov x1, #1
     bl myadd
     mov x27, x0

     cmp x27, x23
     b.LT for3
     
     mov x0, x25
     mov x1, x24
     bl mymul
     ////mul x0, x25, x24 // i * wB

     mov x1, x26
     bl myadd
     ///add x0, x0, x26 // _ + j

     mov x1, #4
     bl mymul
     ////mul x0, x0, x3

     mov x1, x19
     bl myadd
     ////add x0, x19, x0

     str x28, [x0]

cringefor2:
     ////add x26, x26, #1
     mov x0, x26
     mov x1, #1
     bl myadd
     mov x26, x0

     cmp x26, x24
     b.LT for2

endfor1:

     ////add x25, x25, #1 //ADDGE
     mov x0, x25
     mov x1, #1
     bl myadd
     mov x25, x0

     cmp x25, x22
     b.LT for1

end:
     
     ldp x19, x20, [sp, 16]
     ldp x21, x22, [sp, 32]
     ldp x23, x24, [sp, 48]
     ldp x25, x26, [sp, 64]
     ldp x27, x28, [sp, 80]
     ldp x29, x30, [sp], 96

     ret

.data
decimal: 
     .asciz "%d"
