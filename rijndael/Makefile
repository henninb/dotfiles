LIBS=-Llib
INCLUDES=-Iinclude

all: linux

linux:
	@gcc rijndael-alg-fst.c rijndael-api-fst.c rijndael-encrypt.c -o rijndael-encrypt.exe $(INCLUDES) $(LIBS) -O2 -Wall
	@gcc rijndael-alg-fst.c rijndael-api-fst.c rijndael-decrypt.c -o rijndael-decrypt.exe $(INCLUDES) $(LIBS) -O2 -Wall
	@javac RijndaelEncrypt.java
	@jar cmf RijndaelEncrypt.mf RijndaelEncrypt.jar RijndaelEncrypt.class
	@rm -rf *.class
	@javac RijndaelDecrypt.java
	@jar cmf RijndaelDecrypt.mf RijndaelDecrypt.jar RijndaelDecrypt.class
	@rm -rf *.class
	@pip install -r requirements.txt
