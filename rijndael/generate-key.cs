using System;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Configuration;

public class PasswdSetup {
  public static void Main( string[] args ) {
    byte[] KEY = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
    byte[] IV = {0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
	//StringBuilder sb = new StringBuilder();
	//int passwd_length = 16;
	//string hashed_passwd;
	
    if ( args.Length != 0 ) {
      Console.Error.WriteLine("Usage: " + Environment.GetCommandLineArgs()[0] + " <no args>");
      Environment.Exit(1);
    }
	
	KEY = getPasswd();

    fileWrite("input.key", hexConverter(KEY));
	Console.WriteLine("hexConverter(KEY): " + hexConverter(KEY));
	Console.WriteLine("toHexString(KEY): " + toHexString(KEY));
  }
  
  private static byte[] getPasswd() {
    string passwd = string.Empty;
    string repasswd = string.Empty;
	byte[] KEY = null; //new byte[keysize];
	string hashed_passwd = string.Empty;
	int keySizeStatus;
	
	do {
	  Console.Write("Please enter the password: ");
	  passwd = Console.ReadLine();
	  Console.Write("Please re-enter the password: ");
	  repasswd = Console.ReadLine();
	}
	while( passwd != repasswd || passwd == string.Empty );
    
	
	keySizeStatus = chooseOne("Choose a encryption KEY size", "128", "256");
	if( keySizeStatus == 0 ) {
	  //hashed_passwd = computeHash(passwd, new MD5CryptoServiceProvider());
	  hashed_passwd = computeHash(passwd, new SHA512CryptoServiceProvider());
	  Console.WriteLine("Md5(passphrase) substring for 128bit encryption key.");
      KEY = (hexStringToByteArray(hashed_passwd.Substring(0,32)));
	} else {
	  hashed_passwd = computeHash(passwd, new SHA512CryptoServiceProvider());
	  Console.WriteLine("SHA512(passphrase) substring for 256bit encryption key.");
      KEY = (hexStringToByteArray(hashed_passwd.Substring(0,64)));
	}
	
	return KEY;  
  }
  

  private static int chooseOne( string question, string one, string two ) {
    Console.Write(question + " (" + one + "/" + two + ")?");
	string s = Console.ReadLine();
	if( s.ToLower() == one ) {
	  return 0;
	} else if( s.ToLower() == two ) {
	  return 1;
	} else {
	  Console.WriteLine("WARN: your response to the question is invalid.");
	  return chooseOne(question, one, two);
	}
  }
  
  private static int yesNo( string question ) {
    Console.Write(question + " (y/n)?");
	string s = Console.ReadLine();
	if( s.ToLower() == "y" ) {
	  return 0;
	} else if( s.ToLower() == "n" ) {
	  return 1;
	} else {
	  Console.WriteLine("WARN: your response to the question is invalid.");
	  return yesNo(question);
	}
  }
  
  private static byte[] toHexString( byte[] bytes ) {
    StringBuilder sb = new StringBuilder();
	byte[] data;
	
    foreach( byte b in bytes ) {
       sb.AppendFormat("{0:x2}", b);
    }
	
	Console.WriteLine(sb.ToString());
	data = Encoding.ASCII.GetBytes(sb.ToString());
	//data = Encoding.ASCII.GetBytes(BitConverter.ToString(IV).Replace("-",""));
    return data;
  }

  private static byte[] hexStringToByteArray( string s ) {
    int len = s.Length;
    byte[] data = new byte[len / 2];
    for( int i = 0; i < len; i += 2 ) {
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

  //string hPassword = ComputeHash(passwd, new MD5CryptoServiceProvider());
  //string hPassword = ComputeHash(passwd, new SHA256CryptoServiceProvider());
  private static string computeHash( string input, HashAlgorithm algorithm ) {
    byte[] inputBytes = Encoding.ASCII.GetBytes(input);
    byte[] hashedBytes = algorithm.ComputeHash(inputBytes);

    return BitConverter.ToString(hashedBytes).Replace("-", string.Empty);
  }

  private static string computeHash( string input, HashAlgorithm algorithm, Byte[] salt ) {
    byte[] inputBytes = Encoding.ASCII.GetBytes(input);

    // Combine salt and input bytes
    byte[] saltedInput = new byte[salt.Length + inputBytes.Length];
    salt.CopyTo(saltedInput, 0);
    inputBytes.CopyTo(saltedInput, salt.Length);

    byte[] hashedBytes = algorithm.ComputeHash(saltedInput);

    return BitConverter.ToString(hashedBytes).Replace("-", string.Empty);
  }
    
  private static byte[] hexConverter( byte[] data ) {
    char[] hex;
	string hex_string;
	int num1;
	
	if( data == null ) {
        throw new ArgumentNullException("ABORT: null data value");
    }

    //int length = data.Length;
    hex = new char[data.Length * 2];
    num1 = 0;
    for( int idx_i = 0; idx_i < (data.Length * 2); idx_i += 2 ) {
        byte num2 = data[num1++];
        hex[idx_i] = GetHexValue(num2 / 0x10);
        hex[idx_i + 1] = GetHexValue(num2 % 0x10);
    }
    hex_string = new string(hex).ToLower();
    return (Encoding.ASCII.GetBytes(hex_string));	
  }

  private static char GetHexValue( int i ) {
    if ( i < 10 ) {
      return (char)(i + 0x30);
    }
    return (char)((i - 10) + 0x41);
  }
}
