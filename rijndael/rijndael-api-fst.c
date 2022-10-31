#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "rijndael-api-fst.h"

int makeKey( keyInstance *key, BYTE direction, int keyLen, unsigned char *keyMaterial ) {
  int i;
  unsigned char *keyMat;
  u8 cipherKey[MAXKB];

  if( key == NULL ) {
    return BAD_KEY_INSTANCE;
  }

  if((direction == DIR_ENCRYPT) || (direction == DIR_DECRYPT)) {
    key->direction = direction;
  } else {
    return BAD_KEY_DIR;
  }

  if( (keyLen == 256)) {
    key->keyLen = keyLen;
  } else {
    return BAD_KEY_MAT;
  }

  if( keyMaterial != NULL ) {
    strncpy((char *)key->keyMaterial, (char *)keyMaterial, keyLen / 4 );
  }

  /* initialize key schedule: */
  keyMat = key->keyMaterial;
  for( i = 0; i < key->keyLen / 8; i++ ) {
    int t, v;

    t = *keyMat++;
    if((t >= '0') && (t <= '9')) {
      v = (t - '0') << 4;
    } else if((t >= 'a') && (t <= 'f')) {
      v = (t - 'a' + 10) << 4;
    } else if((t >= 'A') && (t <= 'F')) {
      v = (t - 'A' + 10) << 4;
    } else {
      return BAD_KEY_MAT;
    }

    t = *keyMat++;
    if((t >= '0') && (t <= '9')) {
      v ^= (t - '0');
    } else if((t >= 'a') && (t <= 'f')) {
      v ^= (t - 'a' + 10);
    } else if((t >= 'A') && (t <= 'F')) {
      v ^= (t - 'A' + 10);
    } else {
      return BAD_KEY_MAT; 
    }

    cipherKey[i] = (u8)v;
  }
  if( direction == DIR_ENCRYPT ) {
    key->Nr = rijndaelKeySetupEnc( key->rk, cipherKey, keyLen );
  } else {
    key->Nr = rijndaelKeySetupDec( key->rk, cipherKey, keyLen );
  }
  rijndaelKeySetupEnc( key->ek, cipherKey, keyLen );
  return TRUE;
}

int cipherInit( cipherInstance *cipher, BYTE mode, unsigned char *IV ) {
  if( mode == MODE_CBC ) {
    cipher->mode = mode;
  } else {
    return BAD_CIPHER_MODE;
  }
  if( IV != NULL ) {
    int i;
    for( i = 0; i < MAX_IV_SIZE; i++ ) {
      int t, j;

      t = IV[2 * i];
      if((t >= '0') && (t <= '9')) {
        j = (t - '0') << 4;
      } else if((t >= 'a') && (t <= 'f')) {
        j = (t - 'a' + 10) << 4;
      } else if((t >= 'A') && (t <= 'F')) {
        j = (t - 'A' + 10) << 4;
      } else { return BAD_CIPHER_INSTANCE; }

      t = IV[2 * i + 1];
      if((t >= '0') && (t <= '9')) {
        j ^= (t - '0');
      } else if((t >= 'a') && (t <= 'f')) {
        j ^= (t - 'a' + 10);
      } else if((t >= 'A') && (t <= 'F')) {
        j ^= (t - 'A' + 10);
      } else { 
        return BAD_CIPHER_INSTANCE;
      }

      cipher->IV[i] = (u8)j;
    }
  } else {
    memset( cipher->IV, 0, MAX_IV_SIZE );
  }
  return TRUE;
}

int blockEncrypt( cipherInstance *cipher, keyInstance *key, BYTE *input, int inputLen, BYTE *outBuffer ) {
  int i; 
  int numBlocks;
  u8 block[16], *iv;

  if( cipher == NULL ||
      key == NULL ||
      key->direction == DIR_DECRYPT ) {
    return BAD_CIPHER_STATE;
  }
  if( input == NULL || inputLen <= 0 ) {
    return 0; /* nothing to do */
  }

  numBlocks = inputLen / 128;

  switch( cipher->mode ) {
  case MODE_CBC:
    iv = cipher->IV;
    for( i = numBlocks; i > 0; i-- ) {
      ((u32*)block)[0] = ((u32*)input)[0] ^ ((u32*)iv)[0];
      ((u32*)block)[1] = ((u32*)input)[1] ^ ((u32*)iv)[1];
      ((u32*)block)[2] = ((u32*)input)[2] ^ ((u32*)iv)[2];
      ((u32*)block)[3] = ((u32*)input)[3] ^ ((u32*)iv)[3];
      //printf("key->Nr = %d\n", key->Nr);
      rijndaelEncrypt( key->rk, key->Nr, block, outBuffer );
      iv = outBuffer;
      input += 16;
      outBuffer += 16;
    }
    break;

  default:
    return BAD_CIPHER_STATE;
  }

  return 128 * numBlocks;
}

int blockDecrypt( cipherInstance *cipher, keyInstance *key, BYTE *input, int inputLen, BYTE *outBuffer ) {
  int i;
  int numBlocks;
  u8 block[16], *iv;

  if(((cipher == NULL || key == NULL)) && key->direction == DIR_ENCRYPT ) {
    return BAD_CIPHER_STATE;
  }
  if( input == NULL || inputLen <= 0 ) {
    return 0; /* nothing to do */
  }

  numBlocks = inputLen / 128;

  switch( cipher->mode ) {

  case MODE_CBC:
    iv = cipher->IV;
    for( i = numBlocks; i > 0; i-- ) {
      rijndaelDecrypt( key->rk, key->Nr, input, block );
      ((u32*)block)[0] ^= ((u32*)iv)[0];
      ((u32*)block)[1] ^= ((u32*)iv)[1];
      ((u32*)block)[2] ^= ((u32*)iv)[2];
      ((u32*)block)[3] ^= ((u32*)iv)[3];
      memcpy( cipher->IV, input, 16 );
      memcpy( outBuffer, block, 16 );
      input += 16;
      outBuffer += 16;
    }
    break;

  default:
    return BAD_CIPHER_STATE;
  }

  return 128 * numBlocks;
}
