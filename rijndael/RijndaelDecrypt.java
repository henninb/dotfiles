import java.lang.*; 
import java.io.*; 
import javax.crypto.*;
import javax.crypto.spec.*;
import java.security.spec.*;

public class RijndaelDecrypt {
  private static byte[] fileRead( String ifname ) {
    long flength = new File(ifname).length();
    byte[] buf = null;
    InputStream in = null;

    try {
      buf = new byte[(int) flength];
      in = new FileInputStream(ifname);
      if(in.read(buf) < 0) {
        return null;
      }
      in.close();
    }
	catch(FileNotFoundException fnf) {
      System.out.println("ABORT: file not found");
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    return buf;
  }

  private static void decrypt(String ifname, String ofname, Cipher cipher) {
    byte[] buf = null;
    InputStream in = null;
    OutputStream out = null;
    int numRead = 0;

    try {
      in = new FileInputStream(ifname);
      out = new FileOutputStream(ofname);
      in = new CipherInputStream(in, cipher);
      
      // Read in the decrypted bytes and write the cleartext to out
      buf = new byte[1024];
      numRead = 0;
      while ((numRead = in.read(buf)) >= 0) {
        out.write(buf, 0, numRead);
      }
      out.close();
    }
    catch (IOException e) {
      e.printStackTrace();
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

  private static byte[] hexStringToByteArray( String s ) {
    int len = s.length();
    byte[] data = new byte[len / 2];
    for (int i = 0; i < len; i += 2) {
      data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                             + Character.digit(s.charAt(i+1), 16));
    }
    return data;
  }

  public static void main( String args[] ) {
    Cipher cipher = null;
    SecretKey secretKey = null;
    String ifname;
    String ofname;
    String if_key;
    String if_iv;
    byte[] IV;
    byte[] KEY;
    byte[] plainText;
    byte[] cipherText;

    if( args.length != 4 ) {
      System.err.println("Usage: java -jar <jarFile> <ifname> <ofname> <if_key> <if_iv>");
      System.exit(1);
    }

    ifname = args[0];
    ofname = args[1];
    if_key = args[2];
    if_iv = args[3];

File f = new File(ifname);
if(!f.exists() || f.isDirectory()) { 
    System.exit(2);
}
	
    IV = fileRead(if_iv);
    IV = hexStringToByteArray(new String(IV));

    KEY = fileRead(if_key);
    KEY = hexStringToByteArray(new String(KEY));

    System.out.println("******* Decrypt AES/CBC/PKCS5Padding *******");

    try {
      cipherText = fileRead(ifname);
      secretKey = new SecretKeySpec(KEY, "AES");
      System.out.println("Algorithm = " + secretKey.getAlgorithm());
      AlgorithmParameterSpec paramSpec = new IvParameterSpec(IV);

      cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
      //cipher = Cipher.getInstance("AES/CBC/NoPadding");
      //cipher = Cipher.getInstance("AES/CBC/NoPadding");
      //cipher = Cipher.getInstance("AES/CBC/ZerosPadding");
      //cipher = Cipher.getInstance("AES/CBC/ZerosPadding");
      
      // CBC requires an initialization vector
      cipher.init(Cipher.DECRYPT_MODE, secretKey, paramSpec);
      plainText = cipher.doFinal(cipherText); 
      fileWrite(ofname, plainText);

      // Decrypt
      //decrypt(ifname, ofname, cipher);
    }
	
	catch (java.security.InvalidKeyException ike) {
		System.out.println("ABORT: InvalidKeyException");
	}
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}
