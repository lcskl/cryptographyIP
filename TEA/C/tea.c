#include <stdint.h>
#include <stdio.h>

#define PRINT 0

void encrypt (uint32_t v[2], uint32_t k[4], uint32_t * enc_v) {
    uint32_t v0=v[0], v1=v[1], sum=0, i;           /* set up */
    uint32_t delta=0x9E3779B9;                     /* a key schedule constant */
    uint32_t k0=k[0], k1=k[1], k2=k[2], k3=k[3];   /* cache key */

    printf("K0: %08x | K1: %08x | K2: %08x | K3: %08x\n", k0, k1, k2, k3);
    printf("SUM: %08x \n", sum);
    printf("V1: %08x | V0: %08x\n", v1, v0);
    for (i=0; i<32; i++) {                         /* basic cycle start */
        sum += delta;
        v0 += ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
        v1 += ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
        printf("SUM: %08x \n", sum);
        printf("V1: %08x | V0: %08x\n", v1, v0);
    }                                              /* end cycle */
    enc_v[0]=v0; enc_v[1]=v1;
}

void decrypt (uint32_t v[2], uint32_t k[4], uint32_t * dec_v) {
    uint32_t v0=v[0], v1=v[1], sum=0xC6EF3720, i;  /* set up; sum is 32*delta */
    uint32_t delta=0x9E3779B9;                     /* a key schedule constant */
    uint32_t k0=k[0], k1=k[1], k2=k[2], k3=k[3];   /* cache key */

    printf("K0: %08x | K1: %08x | K2: %08x | K3: %08x\n", k0, k1, k2, k3);
    printf("SUM: %08x \n", sum);
    printf("V1: %08x | V0: %08x\n", v1, v0);

    for (i=0; i<32; i++) {                         /* basic cycle start */
        v1 -= ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
        v0 -= ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
        sum -= delta;
        printf("SUM: %08x \n", sum);
        printf("V1: %08x | V0: %08x\n", v1, v0);
    }                                              /* end cycle */
    dec_v[0]=v0; dec_v[1]=v1;
}


int main(int argc, char const *argv[])
{
    uint32_t key [4] = {1,2,3,4};
    uint32_t word [2] = {0xBEBACAFE, 0xDEADBEEF};
    uint32_t enc_word [2] = {0, 0};
    uint32_t dec_word [2] = {0, 0};

    encrypt(word, key, (uint32_t *)&enc_word);

    printf("ENC WORD: %08x | %08x\n", enc_word[1], enc_word[0]);

    decrypt(enc_word, key, (uint32_t *)&dec_word);

    printf("DEC WORD: %08x | %08x\n", dec_word[1], dec_word[0]);

    return 0;
}