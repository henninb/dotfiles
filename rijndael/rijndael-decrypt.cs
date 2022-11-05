using System;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Configuration;

public class RijndaelDecrypt {
  public static void Main( string[] args ) {
	  string ifname = string.Empty;
      string ofname = string.Empty;
      string key_fname = string.Empty;
      string iv_fname = string.Empty;   
   if ( args.Length != 4 ) {      
	  Console.Error.WriteLine("Usage: " + Environment.GetCommandLineArgs()[0] + " <ifname> <ofname> <key> <iv>");
      Environment.Exit(1);
    }
	
	ifname = args[0];
	ofname = args[1];
	key_fname = args[2];
	iv_fname = args[3];

if( !File.Exists(ifname) ) { 
    Environment.Exit(2);
}
	
    rijndael_decrypt(fileReadBytes(args[0]), args[1], args[2], args[3]);
  }

  public static byte[] hexStringToByteArray( string s ) {
    int len = s.Length;
    byte[] data = new byte[len / 2];
    for( int idx = 0; idx < len; idx += 2 ) {
      data[idx/2] = (byte) ((Convert.ToInt32(s[idx].ToString(), 16) << 4) + Convert.ToInt32(s[idx+1].ToString(), 16));
    }

    return data;
  }

  public static byte[] rijndael_decrypt( byte[] cipher, string ofname, string ifkey, string ifiv ) {
    //length 32
    byte[] KEY = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
    //length 16
    byte[] IV = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};

    //byte[] KEY;
    //byte[] IV;
    MemoryStream memoryStream;
    CryptoStream cryptoStream;
    Rijndael rijndael = Rijndael.Create();
    byte[] plainBytes;

    //length 16
    IV = hexStringToByteArray(Encoding.ASCII.GetString(fileReadBytes(ifiv)));
    //length 32
    KEY = hexStringToByteArray(Encoding.ASCII.GetString(fileReadBytes(ifkey)));

    rijndael.Key = KEY;
    rijndael.IV = IV;
    rijndael.Padding = PaddingMode.PKCS7;
    //rijndael.Padding = PaddingMode.None;
    //rijndael.Padding = PaddingMode.Zeros;

    Console.WriteLine("rijndael_decrypt()");
    Console.WriteLine("rijndael BlockSize : " + rijndael.BlockSize);
    Console.WriteLine("rijndael Mode : " + rijndael.Mode);
    Console.WriteLine("rijndael Padding : " + rijndael.Padding);
    Console.WriteLine("rijndael KeySize : " + rijndael.KeySize);

    memoryStream = new MemoryStream();
    cryptoStream = new CryptoStream(memoryStream, rijndael.CreateDecryptor(), CryptoStreamMode.Write);
    cryptoStream.Write(cipher, 0, cipher.Length);
    cryptoStream.Close();
    plainBytes = memoryStream.ToArray();

    for( int idx_i = 0; idx_i < plainBytes.Length; idx_i++ ) {
      //Console.WriteLine(idx_i + "=" + (char) plainBytes[idx_i]);
    }

    fileWrite(ofname, plainBytes, plainBytes.Length);
    // Console.WriteLine("rijndael_decrypt()");
    return plainBytes;
  }

  public static void fileWrite( string fileName, byte[] message, int length ) {
    FileStream fileStream = null;

    try {
      fileStream = new FileStream(fileName, FileMode.Create, FileAccess.Write, FileShare.None);
      fileStream.Write(message, 0, length);
    }

    catch( Exception e ) {
      throw e;
    }

    finally {
      fileStream.Close();
    }
  }

  public static byte[] fileReadBytes( string fname ) {
    byte[] in_bytes = null;
    Stream stream = null;
    FileInfo file = null;

    try {
      file = new FileInfo(fname);
      stream = file.OpenRead();

      in_bytes = new byte[stream.Length];
      stream.Read(in_bytes, 0, (int)stream.Length);
      stream.Close();

    }
    catch( Exception e ) {
      Console.WriteLine("ABORT: " + e.Message);
      stream.Close();
      in_bytes = null;
    }
    return in_bytes;
  }
}
