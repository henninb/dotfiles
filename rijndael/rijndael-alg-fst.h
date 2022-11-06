#ifndef __RIJNDAEL_ALG_FST_H
#define __RIJNDAEL_ALG_FST_H

#define MAXKC    (256/32)
#define MAXKB    (256/8)
#define MAXNR    14

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

int rijndaelKeySetupEnc(u32 rk[/*4*(Nr + 1)*/], const u8 cipherKey[], int keyBits);
int rijndaelKeySetupDec(u32 rk[/*4*(Nr + 1)*/], const u8 cipherKey[], int keyBits);
void rijndaelEncrypt(const u32 rk[/*4*(Nr + 1)*/], int Nr, const u8 pt[16], u8 ct[16]);
void rijndaelDecrypt(const u32 rk[/*4*(Nr + 1)*/], int Nr, const u8 ct[16], u8 pt[16]);

#endif
