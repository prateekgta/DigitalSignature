<html>
<body>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*,sun.security.x509.*,java.security.*,java.security.cert.X509Certificate,java.security.KeyStore.*,javax.security.cert.*"%>

<%@ include file="connection.jsp"%>

<%   Statement smt=null;
       PreparedStatement smt1=null;
        String user="",pass="",nm="",ps="",certpass="",confirmpass="",fullname="",state="",city="",country="",deptname="";
        int i=0;
        
        ResultSet rs=null;
try{        user=session.getAttribute("receiver").toString();
 Object login_id=session.getAttribute("login_id");
        if(user == null && login_id == null)
         {
             response.sendRedirect("error.htm");
         }
       
        smt=con.createStatement();
 
        pass=request.getParameter("T1");
        certpass=request.getParameter("T2");
         session.setAttribute("certpass",certpass);  
        confirmpass=request.getParameter("T3");
	fullname=request.getParameter("T4");
	deptname=request.getParameter("T5");
	city=request.getParameter("T6");
	state=request.getParameter("T7");
	country=request.getParameter("T8");

      if(user!=null && pass !=null && certpass !=null && confirmpass!=null && fullname!=null && deptname!=null && city!=null && state !=null && country!=null)
    {
        rs=smt.executeQuery("select * from  login_digisafe ");
        while(rs.next()){
        nm= rs.getString(1);
        ps = rs.getString(2);    	
        if((nm.equals(user))&&(ps.equals(pass)))
        {  i=1;
        
                  
         }   }   

        
if(i==0)
{ response.sendRedirect("createCertificate_invalid.htm");
}
else
{
synchronized(page)
{

        KeyStore keyStore = KeyStore.getInstance(KeyStore.getDefaultType());
        keyStore.load(null,"".toCharArray()); 
        //create certificate
       CertAndKeyGen cakg = new CertAndKeyGen("DSA", "SHA1WithDSA");
        cakg.generate(1024);
        
        PublicKey publicKey = cakg.getPublicKey();
   
        
        PrivateKey privateKey = cakg.getPrivateKey();
 
        
        X500Name name = new X500Name(fullname, deptname, "DigiSafe", city, state, country);
      // "cn=full name;OU=Organisational unit;O=Organisation,L=city,S=state,IN(India)to char country code
       
     
        
         sun.security.x509.X509Cert cert = cakg.getSelfCert(name, 2000000);
         javax.security.cert.X509Certificate certificate = javax.security.cert.X509Certificate.getInstance(cert.getSignedCert());
       
            byte[] encoded = certificate.getEncoded();
            ByteArrayInputStream bis = new ByteArrayInputStream(encoded);
            java.security.cert.CertificateFactory cf= java.security.cert.CertificateFactory.getInstance("X.509");
            java.security.cert.X509Certificate certi=(java.security.cert.X509Certificate)cf.generateCertificate(bis);
                 java.security.cert.X509Certificate chain[]={certi};
         keyStore.setEntry("selfsigned",new KeyStore.PrivateKeyEntry(privateKey, chain),new KeyStore.PasswordProtection(certpass.toCharArray()));
          FileOutputStream fos = new FileOutputStream(application.getRealPath("")+"\\keystore\\"+user+".jks");
         
          char[] password =certpass.toCharArray();
          keyStore.store(fos,password);
          fos.close(); 
          //extract the certificate from keystore
            KeyStore ks = KeyStore.getInstance("JKS");
            String f=application.getRealPath("")+"\\keystore\\"+user+".jks";
            FileInputStream ksfis = new FileInputStream(f); 
       
            BufferedInputStream ksbufin = new BufferedInputStream(ksfis);
        
            ks.load(ksbufin, certpass.toCharArray());
            PrivateKey priv = (PrivateKey) ks.getKey("selfsigned", certpass.toCharArray());
        
            java.security.cert.Certificate cert2 = keyStore.getCertificate("selfsigned");
       
            byte[] encodedCert = cert2.getEncoded();
     
         /* save the certificate in a file named "usernamecert" */
            FileOutputStream certfos = new FileOutputStream( application.getRealPath("")+"\\certificate\\"+user+".cer");
            certfos.write(encodedCert);
            certfos.close();
}
 smt1=con.prepareStatement("insert into Certificate_digisafe values(?,?)");
smt1.setString(1,user);
smt1.setString(2,application.getRealPath("")+"\\certificate\\"+user+".cer");
smt1.executeQuery();
smt1.close();
response.sendRedirect("createCertificate_success.htm");
 } 
}else
{
    response.sendRedirect("error.htm");
} 
 }catch(Exception e)
      {
      // out.println(e);
      }              
      %>                                     
                                   
 </body>
</html>