using System;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Configuration;

public class RijndaelEncrypt {
	
  public static void Main( string[] args ) {
    string ifname = string.Empty;
    string ofname = string.Empty;
    string key_fname = string.Empty;
    string iv_fname = string.Empty;
	
	if ( args.Length != 4 ) {
      Console.Error.WriteLine("Usage: " + Environment.GetCommandLineArgs()[0] + " <ifname> <ofname> <key> <iv_fname>");
      Environment.Exit(1);
    }

	ifname = args[0];
	ofname = args[1];
	key_fname = args[2];
	iv_fname = args[3];
	
if( !File.Exists(ifname) ) { 
    Environment.Exit(2);
}
	
    rijndael_encrypt(fileReadBytes(ifname), ofname, key_fname, iv_fname);
	byte[] signature = sign_message(fileReadBytes(ifname), fileReadBytes(key_fname));
	fileWrite(ofname + ".sig", signature);
	bool val = verify_message(fileReadBytes(ifname), fileReadBytes(key_fname), signature);
	Console.WriteLine(val);
  }

  public static byte[] hexStringToByteArray( string s ) {
    int len = s.Length;
    byte[] data = new byte[len / 2];
    for (int i = 0; i < len; i += 2) {
      data[i/2] = (byte) ((Convert.ToInt32(s[i].ToString(), 16) << 4) + Convert.ToInt32(s[i+1].ToString(), 16));
    }

    return data;
  }

  private static void fileWrite( string fileName, byte[] message ) {
    FileStream fileStream = null;

    try {
      fileStream = new FileStream(fileName, FileMode.Create, FileAccess.Write, FileShare.None);
      fileStream.Write(message, 0, message.Length);
    }

    catch( Exception e ) {
      throw e;
    }

    finally {
      fileStream.Close();
    }
  }

  private static byte[] fileReadBytes( string fname ) {
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


  public static bool verify_message( byte[] messageBytes, byte[] key, byte[] hash ) {
    HMACSHA512 hmac = new HMACSHA512(key);
	bool err = false;
	
    try {
      byte[] hashValue = hmac.ComputeHash(messageBytes);
	  
      for (int i = 0; i < hashValue.Length; i++) {
          if (hash[i] != hashValue[i]) {
              err = true;
          }
      }
	  
	  return err;
	}
	
	catch( Exception e ) {
      Console.WriteLine( e.Message );
      return false;
	}
  }
  
  public static byte[] sign_message( byte[] messageBytes, byte[] key ) {
    HMACSHA512 hmac = new HMACSHA512(key);

	try {
      byte[] hashValue = hmac.ComputeHash(messageBytes);
	  return hashValue;
	}
	
	catch( Exception e ) {
      Console.WriteLine( e.Message );
      return null;
	}
  }

  public static byte[] rijndael_encrypt( byte[] plainBytes, string ofname, string ifkey, string ifiv ) {
    RijndaelManaged rijndael = null;
    ICryptoTransform encryptor = null;
    MemoryStream memoryStream = null;
    CryptoStream cryptoStream = null;
    byte[] cipherBytes = null;
    byte[] KEY;
    byte[] IV;
    //int discarded;

    //length 32
    //byte[] KEY = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
    //length 16
    //byte[] IV = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};

    //length 16
    IV = hexStringToByteArray(Encoding.ASCII.GetString(fileReadBytes(ifiv)));
    //length 32
    KEY = hexStringToByteArray(Encoding.ASCII.GetString(fileReadBytes(ifkey)));

    try {
      for( int idx_i = 0; idx_i < plainBytes.Length; idx_i++ ) {
        //Console.WriteLine(idx_i + "=" + (char) plainBytes[idx_i]);
      }

      rijndael = new RijndaelManaged();
      rijndael.Key = KEY;
      rijndael.IV = IV;
      rijndael.Mode = CipherMode.CBC;
      //rijndael.Mode = CipherMode.ECB;
      //rijndael.Padding = PaddingMode.PKCS7;
      //rijndael.Padding = PaddingMode.None;
      //rijndael.Padding = PaddingMode.Zeros;
      rijndael.KeySize = 256;
      rijndael.BlockSize = 128;
	  
      encryptor = rijndael.CreateEncryptor(KEY, IV);

      Console.WriteLine("*** csharp rijndael_encrypt() ***");
      Console.WriteLine("rijndael BlockSize : " + rijndael.BlockSize);
      Console.WriteLine("rijndael Mode : " + rijndael.Mode);
      Console.WriteLine("rijndael Padding : " + rijndael.Padding);
      Console.WriteLine("rijndael KeySize : " + rijndael.KeySize);

      memoryStream = new MemoryStream();
      cryptoStream = new CryptoStream( memoryStream, encryptor, CryptoStreamMode.Write );

      //Write all data to the crypto stream and flush it.
      cryptoStream.Write( plainBytes, 0, plainBytes.Length );
      cryptoStream.FlushFinalBlock();

      cipherBytes = memoryStream.ToArray();
      cryptoStream.Close();

      for( int idx_i = 0; idx_i < cipherBytes.Length; idx_i++ ) {
        //Console.WriteLine(idx_i + "=" + (char) cipherBytes[idx_i]);
      }
      fileWrite(ofname, cipherBytes);
      Console.WriteLine("*** csharp rijndael_encrypt() ***");
      return cipherBytes;
    }
    catch( Exception e ) {
      Console.WriteLine( e.Message );
      return null;
    }
  }
}
