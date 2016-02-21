import java.io.*;
import java.security.*;
import java.security.spec.*;

class VerSig {

    public static void main(String[] args) {
try{
        /* Verify a DSA signature */
        String certName="digi1.cer";
        FileInputStream certfis = new FileInputStream(certName);
	java.security.cert.CertificateFactory cf =
	java.security.cert.CertificateFactory.getInstance("X.509");
	java.security.cert.Certificate cert = cf.generateCertificate(certfis);
	PublicKey pubKey = cert.getPublicKey();


            /* create a Signature object and initialize it with the public key */
            Signature sig = Signature.getInstance("SHA1withDSA", "SUN");
            sig.initVerify(pubKey);

            /* Update and verify the data */

            FileInputStream datafis = new FileInputStream("test.txt");
            BufferedInputStream bufin = new BufferedInputStream(datafis);

            byte[] buffer = new byte[1024];
            int len;
            while (bufin.available() != 0) {
                len = bufin.read(buffer);
                sig.update(buffer, 0, len);
                };

            bufin.close();
	    FileInputStream fis = new FileInputStream("sig.txt");
            BufferedInputStream bufin1 = new BufferedInputStream(fis);
            byte[] buffer1 = new byte[1024];
            int len1;
            while (bufin1.available() != 0) {
                len1 = bufin1.read(buffer1);} bufin.close();
              
	
           boolean verifies = sig.verify(buffer1);

            System.out.println("signature verifies: " + verifies);


        } catch (Exception e) {
            System.err.println("Caught exception " + e.toString());
}

    }

}
