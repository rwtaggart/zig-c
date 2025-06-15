/**
 *  C API Example
 *  Simple example of including C files in a Zig project.
 *  Uses the c lib standard library
 */

#include <stdio.h>
#include <stdint.h>
//  #include "c_api.h"

uint32_t special_fn(uint32_t a) {
    return 12 * a;
}

void special_print(uint32_t a) {
    printf("Dis a number: %d\n", a);
}