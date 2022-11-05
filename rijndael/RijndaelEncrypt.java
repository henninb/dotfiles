import java.lang.*;
import java.io.*; 
import javax.crypto.*;
import javax.crypto.spec.*;
import java.security.spec.*;


public class RijndaelEncrypt {
  public static byte[] fileRead( String ifname ) {
    long flength = new File(ifname).length();
    byte[] buffer = null;
    InputStream messageStream = null;

    try {
      buffer = new byte[(int) flength];
      messageStream = new FileInputStream(ifname);
      if(messageStream.read(buffer) < 0) {
        return null;
      }
      messageStream.close();
    }
	catch(FileNotFoundException fnf) {
      System.out.println("ABORT: file not found");
    }
    catch(IOException e) {
      e.printStackTrace();
    }
    return buffer;
  }

  public static byte[] sign_message( byte[] message, byte[] key ) {
    String result = null;
    Mac sha512_HMAC;
	SecretKeySpec secretkey;

    try {

      sha512_HMAC = Mac.getInstance("HmacSHA512");      
      secretkey = new SecretKeySpec(key, "HmacSHA512");
      sha512_HMAC.init(secretkey);       
      byte[] mac_data = sha512_HMAC.doFinal(message);        

      return mac_data;
   //result = Base64.encodeBase64String(mac_data);
   //result = Base64.getEncoder().encodeToString(mac_data);

    } catch( Exception e ) {
	  e.printStackTrace();
	  return null;
    }
  }
  
  private static void fileWrite( String ofname, byte[] buffer ) {
    OutputStream outputStream = null;
    try {
      outputStream = new FileOutputStream(ofname);
      outputStream.write(buffer, 0, buffer.length);
      outputStream.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  private static void encrypt( String ifname, String ofname, byte[] key, Cipher cipher ) {
    byte[] buffer = null;
    InputStream messageStream = null;
    OutputStream outputStream = null;
    int numRead = 0;
	InputStream signatureStream = null;
	byte[] signature = null;
	
	//

    try {
	  signature = cipher.getIV();
	  //signature = cipher.getKEY();
	  System.out.println(ofname + ".sig");
	  signature = sign_message(fileRead(ifname), key);
	  //fileWrite(ofname + ".sig", signature);
      signatureStream = new ByteArrayInputStream(signature);
      messageStream = new FileInputStream(ifname);
      outputStream = new FileOutputStream(ofname);
      // Bytes written to out will be encrypted
      outputStream = new CipherOutputStream(outputStream, cipher);
      
      // Read messageStream the cleartext bytes and write to out to encrypt
      buffer = new byte[1024];
      numRead = 0;
      while ((numRead = messageStream.read(buffer)) >= 0) {
        outputStream.write(buffer, 0, numRead);
      }
      outputStream.close();
    }

    catch (IOException e) {
      e.printStackTrace();
    }
  }

  private static byte[] hexStringToByteArray( String s ) {
    int len = s.length();
    byte[] data = new byte[len / 2];
    for (int i = 0; i < len; i += 2) {
      data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                             + Character.digit(s.charAt(i+1), 16));
    }
    return data;
  }
  
  
  private static void test1() {
	  try {
	  Class c = Class.forName("javax.crypto.JceSecurity");
	  System.out.println("test1()");
	  
	  } catch(Exception e) {}
  }

  public static void main( String args[] ) {
    Cipher cipher = null;
    SecretKey secretKey = null;
    String ifname;
    String ofname;
    String if_key;
    String if_iv;
	byte[] IV = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
    byte[] KEY = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

    if( args.length != 4 ) {
      System.err.println("Usage: java -jar <jarFile> <ifname> <ofname> <if_key> <if_iv>");
      System.exit(1);
    }

    ifname = args[0];
    ofname = args[1];
    if_key = args[2];
    if_iv = args[3];
	
    File f = new File(ifname);
    if( !f.exists() || f.isDirectory() ) { 
      System.out.println("cannot find file");
      System.exit(2);
    }	
	// test1();
	
    IV = fileRead(if_iv);
    IV = hexStringToByteArray(new String(IV));
	
    //IvParameterSpec ivspec = new IvParameterSpec(IV);

    KEY = fileRead(if_key);
    KEY = hexStringToByteArray(new String(KEY));

    try {
      System.out.println("******* Java Encrypt AES/CBC/PKCS5Padding *******");
      System.out.println("KEY.length = " + KEY.length);
	  System.out.println("IV.length = " + IV.length);
	
      secretKey = new SecretKeySpec(KEY, "AES");
      System.out.println("Algorithm = " + secretKey.getAlgorithm());
      AlgorithmParameterSpec paramSpec = new IvParameterSpec(IV);
	  
      cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
      int maxKeyLen = cipher.getMaxAllowedKeyLength("AES");
	  System.out.println("max key: " + maxKeyLen);
	  //cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
      //cipher = Cipher.getInstance("AES/CBC/NoPadding");	  
      //cipher = Cipher.getInstance("AES/CBC/NoPadding");
      //cipher = Cipher.getInstance("AES/CBC/ZerosPadding");
      //cipher = Cipher.getInstance("AES/CBC/ZerosPadding");
      
      // CBC requires an initialization vector
	  System.out.println("getBlockSize:" + cipher.getBlockSize());
	  System.out.println(cipher.getAlgorithm());
	  //System.out.println(cipher.getMaxAllowedKeyLength());
      cipher.init(Cipher.ENCRYPT_MODE, secretKey,  new IvParameterSpec(IV));
	   
	  //cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivspec);
 
      // Encrypt
      encrypt(ifname, ofname, KEY, cipher);  
    }
	catch (java.security.InvalidKeyException ike) {
		System.out.println("ABORT: InvalidKeyException");
	}
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}
