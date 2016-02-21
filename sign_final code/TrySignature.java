import java.security.*;
import java.io.*;
class TrySignature
{
public static void main(String args[])
{  
    String ksName="try1.jks";

 try{
    KeyStore ks = KeyStore.getInstance("JKS");
    FileInputStream ksfis = new FileInputStream(ksName); 
    BufferedInputStream ksbufin = new BufferedInputStream(ksfis);  
    
    ks.load(ksbufin,"digisafe".toCharArray());
    PrivateKey priv = (PrivateKey) ks.getKey("selfsigned","digisafe".toCharArray());
         
            /* Create a Signature object and initialize it with the private key */

            Signature dsa = Signature.getInstance("SHA1withDSA", "SUN"); 

            dsa.initSign(priv);

            /* Update and sign the data */
          

            FileInputStream fis = new FileInputStream("test.txt");
            BufferedInputStream bufin = new BufferedInputStream(fis);
            byte[] buffer = new byte[1024];
            int len;
            while (bufin.available() != 0) {
                len = bufin.read(buffer);
                dsa.update(buffer, 0, len);
                }

            bufin.close();

            /* Now that all the data to be signed has been read in, 
                    generate a signature for it */

            byte[] realSig = dsa.sign();

        
            /* Save the signature in a file */
            FileOutputStream sigfos = new FileOutputStream("sig.txt");
            sigfos.write(realSig);

            sigfos.close();


          

        } catch (Exception e) {
            System.err.println("Caught exception " + e.toString());
        }
  }
}