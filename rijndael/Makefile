LIBS=-Llib
INCLUDES=-Iinclude

ifeq "$(OS)" "Windows_NT"
PATH=C:\gnuwin32\bin;C:\MinGW\bin;C:\MinGW\libexec\gcc\mingw32\4.5.0;C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727
endif

all: unix

unix:
	@gcc rijndael-alg-fst.c rijndael-api-fst.c rijndael_encrypt.c -o rijndael_c_encrypt.exe $(INCLUDES) $(LIBS) -O2 -Wall
	@gcc rijndael-alg-fst.c rijndael-api-fst.c rijndael_decrypt.c -o rijndael_c_decrypt.exe $(INCLUDES) $(LIBS) -O2 -Wall
	@javac RijndaelEncrypt.java
	@jar cmf RijndaelEncrypt.mf RijndaelEncrypt.jar RijndaelEncrypt.class
	@rm -rf *.class
	@javac RijndaelDecrypt.java
	@jar cmf RijndaelDecrypt.mf RijndaelDecrypt.jar RijndaelDecrypt.class
	@rm -rf *.class
	@pip install -r requirements.txt
