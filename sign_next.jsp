<html>
<body bgcolor="#ECF5FF">
<form name="sign" Onsubmit="return true" action="sign.jsp" method="POST">
<%@ page language="java" %> 
<%@ page import="java.io.*,javax.crypto.*,java.security.*,sun.misc.BASE64Encoder" %>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*,java.util.*" %>
<%@include file="connection.jsp"%>
<%  Statement smt=null;
        ResultSet rs=null;
        int i=0;
         FileOutputStream fos;
           FileInputStream fis;
           StringTokenizer st1=null;
String nm="" ,fl,fl1;  
 String s1="";
    try{    Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
       
         
         
         String user=session.getAttribute("receiver").toString(); 
         String add =request.getParameter("T1"); 
         String sub =request.getParameter("T2"); 
         session.setAttribute("add",add);
         session.setAttribute("sub",sub);
     
        String file=session.getAttribute("file").toString(); 
        
         out.println("file ="  +file);
       smt=con.createStatement();
        StringTokenizer st = new StringTokenizer(add,",");
        String s="";
        String sec_key=session.getAttribute("sec_key").toString(); 
       String ori_msg=session.getAttribute("ori_msg").toString(); 
  if(sec_key == null  && ori_msg == null && add == null  && sub== null && user==null)
{
  response.sendRedirect("error.htm");
}    
if(ori_msg==null)
 ori_msg=" ";
 
      String ksName=application.getRealPath("")+"\\keystore\\"+user+".jks";
    String msg =session.getAttribute("enc_msg").toString();
      String certpass=request.getParameter("T3"); 
    KeyStore ks = KeyStore.getInstance("JKS");
    FileInputStream ksfis = new FileInputStream(ksName); 
    BufferedInputStream ksbufin = new BufferedInputStream(ksfis);  
    ks.load(ksbufin,certpass.toCharArray());
    PrivateKey priv = (PrivateKey) ks.getKey("selfsigned",certpass.toCharArray());          
           Signature dsa = Signature.getInstance("SHA1withDSA", "SUN"); 
            dsa.initSign(priv);
            byte[] buffer = msg.getBytes();
            dsa.update(buffer);
          
            byte[] msg_digest = dsa.sign();

/* FILE SIGNING */
   out.println("file1 ="  +file);
 if(!(file.equals("")) || !(file ==null))
               {
                 st1 = new StringTokenizer(file,",");
                
             
                 while(st1.hasMoreTokens())
                    {
                       s1=st1.nextToken();
                   
                      fis = new FileInputStream(application.getRealPath("")+"\\attachment\\"+user+"\\enc_"+s1);
                          out.println("file2 ="  +file);
                      BufferedInputStream bufin = new BufferedInputStream(fis);
                      fos = new FileOutputStream(application.getRealPath("")+"\\attachment\\"+user+"\\sign_"+s1,true);
                        out.println("file3 ="  +file);
                      byte[] buffer1 = new byte[1024];
                       int len;
                       while (bufin.available() != 0) 
                             {    len = bufin.read(buffer1);
                                    dsa.update(buffer1, 0, len);
                              }                
                      byte[] fileSig = dsa.sign(); 
                         out.println("file4 ="  +file);
                      fos.write(fileSig);
                      bufin.close();
                      fis.close();
                      fos.close();
  }
}

synchronized(page)
{
  PreparedStatement smt1=null;
  PreparedStatement smt2=null;
  while (st.hasMoreTokens()) 
{   i=0;
    java.util.Date dt1=new java.util.Date();
    s=st.nextToken(); 
    rs=smt.executeQuery("select * from  login_digisafe ");
   
        while(rs.next()){
         nm= rs.getString(1);
         if(nm.equals(s))
           {  i=1;
             }}

if(i==1)
{
/* MESSAGE WRITING */
 smt1=con.prepareStatement("insert into inbox_digisafe values(?,?,?,?,?,?,?,?)");   
 smt1.setString(1,s); 
 smt1.setString(2,user);
 smt1.setString(3,sub);
 smt1.setString(4,msg);
 smt1.setBytes(5,msg_digest); 
 smt1.setString(6,sec_key);
 smt1.setTimestamp(7,new java.sql.Timestamp(dt1.getTime()));
 smt1.setInt(8,0);
 smt1.executeUpdate(); 
 smt2=con.prepareStatement("insert into sent_digisafe values(?,?,?,?,?)");
 smt2.setString(1,s); 
 smt2.setString(2,user);
 smt2.setString(3,sub);
 smt2.setString(4,ori_msg);
 smt2.setTimestamp(5,new java.sql.Timestamp(dt1.getTime()));
 smt2.executeUpdate(); 
 smt2.close();
/*FILE WRITING */

if(!(file.equals("")) || !(file ==null))
 {
st1 = new StringTokenizer(file,",");
                  s1="";
           
                

smt2=con.prepareStatement("insert into attachment_digisafe values(?,?,?,?,?,?,?,?,?,?,?)");
smt2.setTimestamp(1,new java.sql.Timestamp(dt1.getTime())); 
 if(st1.hasMoreTokens())
                    {
                       s1=st1.nextToken();
                  
                        fl=application.getRealPath("")+"\\attachment\\"+user+"\\enc_"+s1;
                        fl1=application.getRealPath("")+"\\attachment\\"+user+"\\sign_"+s1;
                     }
                   else
                    { 
                      fl="";
                      fl1="";
                    }
 smt2.setString(2,fl);
 smt2.setString(3,fl1);

 if(st1.hasMoreTokens())
                    {
                       s1=st1.nextToken();
                   
                        fl=application.getRealPath("")+"\\attachment\\"+user+"\\enc_"+s1;
                        fl1=application.getRealPath("")+"\\attachment\\"+user+"\\sign_"+s1;
                     }
                   else
                    { 
                      fl="";
                      fl1="";
                    }
 smt2.setString(4,fl);
 smt2.setString(5,fl1); 

 if(st1.hasMoreTokens())
                    {
                       s1=st1.nextToken();
                      
                        fl=application.getRealPath("")+"\\attachment\\"+user+"\\enc_"+s1;
                        fl1=application.getRealPath("")+"\\attachment\\"+user+"\\sign_"+s1;
                     }
                   else
                    { 
                      fl="";
                      fl1="";
                    }

 smt2.setString(6,fl);
 smt2.setString(7,fl1);

 if(st1.hasMoreTokens())
                    {
                       s1=st1.nextToken();
                       
                        fl=application.getRealPath("")+"\\attachment\\"+user+"\\enc_"+s1;
                        fl1=application.getRealPath("")+"\\attachment\\"+user+"\\sign_"+s1;
                     }
                   else
                    { 
                      fl="";
                      fl1="";
                    }

 smt2.setString(8,fl);
 smt2.setString(9,fl1);

 if(st1.hasMoreTokens())
                    {
                       s1=st1.nextToken();
                       
                        fl=application.getRealPath("")+"\\attachment\\"+user+"\\enc_"+s1;
                        fl1=application.getRealPath("")+"\\attachment\\"+user+"\\sign_"+s1;
                     }
                   else
                    { 
                      fl="";
                      fl1="";
                    }

 smt2.setString(10,fl);
 smt2.setString(11,fl1);
  smt2.executeUpdate(); 
  
  
 }//end of if

 } //end of i=1 if
 else
 {  
    smt1=con.prepareStatement("insert into inbox_digisafe values(?,?,?,?,?,?,?,?)");
   String msg_error="Hi. This is the qmail-send program at DigiSafe.\nI'm afraid I wasn\'t able to deliver your message to the following address.\nThis is a permanent error; I\'ve given up. \nSorry it didn\'t work out.\n< " + s + " >:failed after I sent the message.";

 smt1.setString(1,user); 
 smt1.setString(2,"DigiSafe");
 smt1.setString(3,"Failure Notice");
 smt1.setString(4,msg_error);
 smt1.setBytes(5,msg_digest); 
 smt1.setString(6,sec_key);
 smt1.setTimestamp(7,new java.sql.Timestamp(dt1.getTime()));
 smt1.setInt(8,2);
 smt1.executeUpdate(); 

}

Thread.sleep(1000);
 smt1.close(); 

} //end of while
session.setAttribute("file","");
}//end of synchronization
 response.sendRedirect("compose_success.htm") ;               
}catch(Exception e){if((e.toString()).equals("java.io.IOException: Keystore was tampered with, or password was incorrect"))
                                          response.sendRedirect("invalid_keypassword.jsp");
                                 else           
                                 out.println(e);}
%>
</body>
</html>