#!/bin/sh

./rijndael_c_encrypt.exe input.txt output.txt.rij input.key input.iv
./rijndael_c_decrypt.exe output.txt.rij plain-c.txt input.key input.iv

java -jar RijndaelDecrypt.jar output.txt.rij plain-java.txt input.key input.iv

exit 0
