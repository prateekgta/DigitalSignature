<html>

<body bgcolor="#ECF5FF" style="color: #B9DCFF; border-left-style: solid; border-left-width: 3; border-right-style: solid; border-right-width: 3">

<%@ page language="java" %> 
<%@ page import="java.io.*,java.security.*,java.security.spec.*, java.sql.*" %>
<%@include file="connection.jsp"%>
<% ResultSet rs=null;
String filename="",filesig="";
   try{Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
       
            String msg="",str="";
        byte msg_digest[]=null;
        
        PreparedStatement smt,smt1;

        String str1= request.getParameter("abc1");

        session.setAttribute("dateMsg",str1);

smt = con.prepareStatement("Select * from inbox_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
smt.setString(1,str1);
rs=smt.executeQuery();
while(rs.next())
{ str=rs.getString(2);
  msg=rs.getString(4);
  msg_digest=rs.getBytes(5);  

 }
out.println(msg);
out.println(str);
out.println(msg_digest);
smt=con.prepareStatement("Select cfile from certificate_digisafe where username=?");
smt.setString(1,str);
rs=smt.executeQuery();
while(rs.next())
{
str=rs.getString(1);

 }
out.println("hdh"+str);
String certName=str;

FileInputStream certfis = new FileInputStream(certName);

	java.security.cert.CertificateFactory cf =java.security.cert.CertificateFactory.getInstance("X.509");
	java.security.cert.Certificate cert = cf.generateCertificate(certfis);
	PublicKey pubKey = cert.getPublicKey();

            /* create a Signature object and initialize it with the public key */
            Signature sig = Signature.getInstance("SHA1withDSA", "SUN");
            sig.initVerify(pubKey);

            /* Update and verify the data */

            

            byte[] buffer = msg.getBytes();
            
                sig.update(buffer);
            boolean verifies = sig.verify(msg_digest);
         if(!verifies)
             response.sendRedirect("validate_invalid.htm");
           /*File verification*/
         smt1 = con.prepareStatement("Select * from attachment_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
          smt1.setString(1,str1);
         rs=smt1.executeQuery();
         Signature sig1;
          FileInputStream datafis,fis;
          byte buffer1[]=null,buffer2[]=null;
          BufferedInputStream bufin,bufin1;
          int len;
        while(rs.next())
        { if(!verifies)
             response.sendRedirect("validate_invalid.htm");
          for(int i=2;i<=11 &&  verifies;i=i+2)
            { filename=rs.getString(i);
            out.println("---3please read------------------"+i+"=-=9099");
                 if( filename!=null)
                 { filesig=rs.getString(i+1);
                 out.println("sigfile"+filesig);
                   sig1 = Signature.getInstance("SHA1withDSA", "SUN");
                    sig1.initVerify(pubKey);
                   datafis = new FileInputStream(filename);
                      out.println("sigfile"+filename);
                     bufin= new BufferedInputStream(datafis);
                    buffer1 = new byte[1024];
                    while (bufin.available() != 0)
                    {
                      len = bufin.read(buffer1);
                      sig1.update(buffer1, 0, len);
                    }
                   bufin.close();
                   fis= new FileInputStream(filesig);
                      out.println("---3sigfile"+filesig);
                   bufin1 = new BufferedInputStream(fis);
                  buffer2 = new byte[1024];
                  out.println("---4sigfile");
                   int len1;
                    while (bufin1.available() != 0) {
                    len1 = bufin1.read(buffer2);} 
                    out.println("---5sigfile");
                    bufin1.close();
                    out.println("---6sigfile");
            	      verifies = sig1.verify(buffer2);}
            	      else
            	       break;
            	     } 
     }
         out.println("---7sigfile");
           if(verifies)
             {         smt=con.prepareStatement("UPDATE  inbox_digisafe SET check1=? WHERE  TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS')=?");
                       smt.setInt(1,1);
                       smt.setString(2,str1);
                       smt.executeUpdate();
            response.sendRedirect("read.jsp");
             }
           else ;
            // response.sendRedirect("validate_invalid.jsp");

      }catch(Exception e){
                                    out.println(e);
                         }
%>

     
                   
              
 </body>
</html>