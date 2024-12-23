# -*- coding: utf-8 -*-
"""
Created on Mon Dec 23 17:23:41 2024

@author: Olga
"""

import numpy as np


def split_at(num,m):
    return (int(num/(10**m)), int(num%(10**m)))


def karatsuba(num1, num2):
#    print('start Karztsuba')
    if (num1 < 10 or num2 < 10):
#        print('got to single digit')
        return num1 * num2 #/* fall back to traditional multiplication */
    
#     /* Calculates the size of the numbers. */
#    print('length of numbers')
#    print(len(str(num1)), len(str(num2)))
    m = max(len(str(num1)), len(str(num2)))
#    print('max leng')
#    print(m)
    m2 = int(np.floor(m / 2) )
#    print('half length')
#    print(m2)
#     /* m2 = ceil (m / 2) will also work */
    
#     /* Split the digit sequences in the middle. */
    (high1, low1) = split_at(num1, m2)
#    print('first split')
#    print(high1, low1)
    (high2, low2) = split_at(num2, m2)
#    print('second split')
#    print(high2, low2)
    
# #     /* 3 recursive calls made to numbers approximately half the size. */
    z0 = karatsuba(low1, low2)
    z1 = karatsuba(low1 + high1, low2 + high2)
    z2 = karatsuba(high1, high2)
#    print('components')
#    print(z0, z1, z2)
    return (z2 * 10 ** (m2 * 2)) + ((z1 - z2 - z0) * 10 ** m2) + z0


a = 1234
b = 5678

print(karatsuba(a, b))
