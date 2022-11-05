#!/bin/sh

rm plain*.txt

./rijndael-encrypt.exe input.txt output.txt.rij input.key input.iv
./rijndael-encrypt.py input.txt output-python.txt.rij input.key input.iv
mono ./rijndael-mono-encrypt.exe input.txt output-mono.txt.rij input.key input.iv
java -jar RijndaelEncrypt.jar output-java.txt.rij input.txt input.key input.iv

./rijndael-decrypt.exe output.txt.rij plain-c.txt input.key input.iv
mono ./rijndael-mono-decrypt.exe output.txt.rij plain-mono.txt input.key input.iv
java -jar RijndaelDecrypt.jar output.txt.rij plain-java.txt input.key input.iv
./rijndael-decrypt.py output.txt.rij plain-python.txt input.key input.iv

echo plain
sha256sum plain*.txt input.txt

echo rij
sha256sum *.txt.rij

exit 0
