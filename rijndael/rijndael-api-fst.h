#ifndef __RIJNDAEL_API_FST_H
#define __RIJNDAEL_API_FST_H

//#include <stdio.h>
#include "rijndael-alg-fst.h"

#define     DIR_ENCRYPT           0 /*  Are we encrpyting?  */
#define     DIR_DECRYPT           1 /*  Are we decrpyting?  */
#define     MODE_CBC              2 /*  Are we ciphering in CBC mode?   */
#define     TRUE                  1
#define     FALSE                 0
#define     BITSPERBLOCK        128 /* Default number of bits in a cipher block */

/*  Error Codes  */
#define     BAD_KEY_DIR          -1 /*  Key direction is invalid, e.g., unknown value */
#define     BAD_KEY_MAT          -2 /*  Key material not of correct length */
#define     BAD_KEY_INSTANCE     -3 /*  Key passed is not valid */
#define     BAD_CIPHER_MODE      -4 /*  Params struct passed to cipherInit invalid */
#define     BAD_CIPHER_STATE     -5 /*  Cipher in wrong state (e.g., not initialized) */
#define     BAD_BLOCK_LENGTH     -6
#define     BAD_CIPHER_INSTANCE  -7
#define     BAD_DATA             -8 /*  Data contents are invalid, e.g., invalid padding */
#define     BAD_OTHER            -9 /*  Unknown error */

#define     MAX_KEY_SIZE         64 /* # of ASCII char's needed to represent a key */
#define     MAX_IV_SIZE          16 /* # bytes needed to represent an IV  */

typedef unsigned char BYTE;

typedef struct {
    BYTE  direction;                /* Key used for encrypting or decrypting? */
    int   keyLen;                   /* Length of the key  */
    BYTE keyMaterial[MAX_KEY_SIZE+1];  /* Raw key data in ASCII, e.g., user input or KAT values */
    int   Nr;                       /* key-length-dependent number of rounds */
    u32   rk[4*(MAXNR + 1)];        /* key schedule */
    u32   ek[4*(MAXNR + 1)];        /* CFB1 key schedule (encryption only) */
} keyInstance;

typedef struct {                    /* changed order of the components */
    BYTE  mode;                     /* MODE_ECB, MODE_CBC, or MODE_CFB1 */
    BYTE  IV[MAX_IV_SIZE];          /* A possible Initialization Vector for ciphering */
} cipherInstance;

int makeKey(keyInstance *key, BYTE direction, int keyLen, unsigned char *keyMaterial);
int cipherInit( cipherInstance *cipher, BYTE mode, unsigned char *IV );
int blockEncrypt(cipherInstance *cipher, keyInstance *key, BYTE *input, int inputLen, BYTE *outBuffer);
int padEncrypt(cipherInstance *cipher, keyInstance *key, BYTE *input, int inputOctets, BYTE *outBuffer);
int blockDecrypt(cipherInstance *cipher, keyInstance *key, BYTE *input, int inputLen, BYTE *outBuffer);
int padDecrypt(cipherInstance *cipher, keyInstance *key, BYTE *input, int inputOctets, BYTE *outBuffer);

#endif
