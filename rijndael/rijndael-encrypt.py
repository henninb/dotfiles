#!/usr/bin/env python

import os, sys
from Crypto.Cipher import AES

def fileRead(ifname):
  with open(ifname, 'rb') as ifp:
    read_data = ifp.read()
  ifp.closed
  return read_data

def fileWrite(ofname, data):
  ofp = open(ofname, "wb")
  ofp.write(data)
  ofp.close()

def rijndael_encrypt(ifname, ofname, keyfname, ivfname):
  plainText = fileRead(ifname);
  key_hex = fileRead(keyfname);
  iv_hex = fileRead(ivfname);
  BLOCK_SIZE = 128
  # KEY_SIZE_BITS = 256
  # IV_SIZE_BITS = 128

  original_fsize = os.path.getsize(ifname)
  new_fsize = original_fsize + int((BLOCK_SIZE/8) - (original_fsize % (BLOCK_SIZE/8)));

  for _ in range(new_fsize - original_fsize):
    plainText = plainText + chr(new_fsize - original_fsize).encode()

  key = bytes.fromhex(key_hex.decode())
  iv = bytes.fromhex(iv_hex.decode())

  cipher = AES.new(key, AES.MODE_CBC, iv)
  cipherText = cipher.encrypt(plainText)
  fileWrite(ofname, cipherText);

def main():
  if len(sys.argv) != 5:
    print("Usage: %s <ifname> <ofname> <key> <iv>" % sys.argv[0])
    sys.exit()
  rijndael_encrypt(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
  # sys.exit(), end
  sys.exit()

main()
