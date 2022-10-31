#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include "rijndael-api-fst.h"

#define KEY_SIZE_BITS 256
#define IV_SIZE_BITS 128
#define BLOCK_SIZE 128

//typedef unsigned int u32;
//typedef unsigned char BYTE;

void hex2bin( char *, char ** );
int bin_value( char );
void fileWrite( char *, BYTE *, int );
void fileRead( char *, BYTE *, int );
long fileLength( char * );

unsigned char IV[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, '\0'};
unsigned char KEY[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, '\0'};

int main( int argc, char *argv[] ) {
  int rc;
  keyInstance key_ptr;
  cipherInstance *cipher_ptr;
  BYTE *cipherText;
  BYTE *plainText;
  BYTE *key_text;
  BYTE *iv_text;
  char *ifname = argv[1];
  char *ofname = argv[2];
  char *keyfname = argv[3];
  char *ivfname = argv[4];
  int ofsize;
  int nfsize;
  int idx_i;

  if( argc != 5 ) {
    fprintf( stderr, "Usage: %s <ifname> <ofname> <key> <iv>\n", argv[0] );
    exit( 1 );
  }

  printf("*** start c rijndael_encrypt ***\n");
  key_text = (BYTE *) malloc(KEY_SIZE_BITS/8 * 2 + 1);
  memset(key_text, '\0', KEY_SIZE_BITS/8 * 2 + 1);
  fileRead(keyfname, key_text, KEY_SIZE_BITS/8 * 2);

  iv_text = (BYTE *) malloc((IV_SIZE_BITS/8) * 2 + 1);
  memset(iv_text, '\0', (IV_SIZE_BITS/8) * 2 + 1);
  fileRead(ivfname, iv_text, IV_SIZE_BITS/8 * 2);

  ofsize = fileLength(ifname);
  nfsize = ofsize + ((BLOCK_SIZE/8) - (ofsize % (BLOCK_SIZE/8)));
  printf("nfsize=%d\n", nfsize); 

  cipherText = (BYTE *)malloc(nfsize);
  plainText = (BYTE *)malloc(nfsize);

  memset(plainText, '\0', nfsize);
  memset(cipherText, '\0', nfsize);

  fileRead(ifname, plainText, ofsize);

  //padding chars for PKCS7
  for( idx_i = ofsize; idx_i < nfsize; idx_i++ ) {
    plainText[idx_i] = nfsize - ofsize;
  }

  cipher_ptr = (cipherInstance *)malloc( sizeof(cipherInstance));
  if( (rc = cipherInit( cipher_ptr, MODE_CBC, iv_text )) < 0 ) {
    printf( "ABORT: problem with cipherInit(), %d\n", rc );
    exit(rc);
  }

  //makeKey at 256 bits
  if( (rc = makeKey( &key_ptr, DIR_ENCRYPT, KEY_SIZE_BITS, key_text )) < 0 ) {
    printf( "ABORT: problem with makeKey(), %d\n", rc );
    exit( rc );
  }

  if( (rc = blockEncrypt( cipher_ptr, &key_ptr, plainText, 8 * nfsize, cipherText)) < 1 ) {
    printf( "ABORT: problem with blockEncrypt(), %d\n", rc);
    exit( rc );
  }

  fileWrite(ofname, cipherText, nfsize);

  return 0;
}

void fileWrite( char *ifname, BYTE *istring, int istring_sz ) {
  FILE *ifp;
  int rc;

  if((ifp = fopen( ifname, "wb" )) == NULL ) {
    fprintf( stderr, "ABORT: fopen() failed for '%s'.\n", ifname );
    exit( 1 );
  }

  if( (rc = fwrite( istring, 1, istring_sz, ifp )) == -1 ) {
    fprintf( stderr, "ABORT: fwrite() failed for '%s'.\n", ifname );
    exit( 1 );
  }

  fclose( ifp );
  
  printf("*** end c rijndael ***\n");
}

void fileRead( char *ifname, BYTE *ostring, int ostring_sz ) {
  int read_in = 0;
  FILE *ifp;
  int fsize = 0;

  if((ifp = fopen( ifname, "rb" )) == NULL ) {
    fprintf( stderr, "ABORT: fopen() failed for '%s'.\n", ifname );
    exit( 1 );
  }

  while((read_in = fread( ostring, 1, ostring_sz, ifp )) > 0 ) {
    //printf("read_in='%d'\n", read_in);
    fsize += read_in;
    //printf( "*ostring='%s'\n", *ostring );
  }

  fclose( ifp );
}

long fileLength( char *fname ) {
  struct stat file_stat;

  if( stat( fname, &file_stat ) != 0 ) {
    fprintf( stderr, "ABORT: stat() failed.\n" );
    exit( 1 );
  }

  return file_stat.st_size;
}

int bin_value( char ch ) {
  if('0'<=ch && ch<='9') {
    return ch - '0';
  } else if('a'<=ch && ch<='z') {
    return ch - 'a' + 0x0A;
  } else if('A'<=ch && ch<='Z') {
    return ch - 'A' + 0x0A;
  } else {
    return -1;
  }
}

void hex2bin( char *str, char **new ) {
  int len = 0;
  len = strlen(str);
  int idx_i;
  int a;
  int b;

  for( idx_i = 0; idx_i < (len/2); idx_i++ ) {
    a = (bin_value(str[idx_i * 2])<<4) & 0xF0;
    b = (bin_value(str[idx_i * 2 +1])   ) & 0x0F;
    (*new)[idx_i] = a | b;
  }
}
