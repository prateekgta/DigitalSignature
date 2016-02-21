<html>
<body bgcolor="#ECF5FF">
<form name="sign" Onsubmit="return true"  method="POST">
<%@ page language="java" %> 
<%@ page import="java.io.*,java.util.Properties.*,javax.crypto.*,java.security.*,sun.misc.BASE64Decoder,javax.crypto.spec.*" %>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>
<%       String clear="";
         PreparedStatement smt=null,smt1=null;
        String msg="",key="",date="",disp="",nm="",sub="",sender="",str="",filename="",file="";
        int i=0;
        
        ResultSet rs=null;
        try{  str=session.getAttribute("dateMsg").toString();
         Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
                if(str != null)
             {
               
          smt = con.prepareStatement("Select * from inbox_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
            smt.setString(1,str);
            rs=smt.executeQuery();
            while(rs.next())
            {
             sender=rs.getString(2);
             sub=rs.getString(3);
             msg= rs.getString(4);
             key= rs.getString(6);  
            }    
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(key));
        SecretKeySpec key1 = (SecretKeySpec)ois.readObject();
        ois.close();
        Cipher desCipher = Cipher.getInstance("DES"); 
                 desCipher.init(Cipher.DECRYPT_MODE,key1);
                   BASE64Decoder decoder = new BASE64Decoder();
                 byte[] msg_decode = decoder.decodeBuffer(msg);
                byte[] byteCipherText = desCipher.doFinal(msg_decode);  
                 clear = new String(byteCipherText, "UTF8"); 
            /*Decrypt file*/
           
            smt1 = con.prepareStatement("Select * from attachment_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
            smt1.setString(1,str);
             rs=smt1.executeQuery();
             while(rs.next())
           {   for(int j=2;j<=11;j=j+2)
               { filename=rs.getString(j);
                 if(filename!=null)
                 { 
                 byte [] buf = new byte[1024];
                   InputStream in = new CipherInputStream(new FileInputStream(filename), desCipher);
                   String fstr=application.getRealPath("")+"\\attachment\\"+sender+"\\"+"enc_";
                   String fileout=application.getRealPath("")+"\\attachment\\"+sender+"\\"+filename.substring((fstr.length()),(filename.length()-22));
                   FileOutputStream fout=new FileOutputStream(fileout);
                   // Read in the decrypted bytes and write the cleartext to out
                   int numRead = 0;
                   while ((numRead = in.read(buf)) >= 0) 
                   {
                     fout.write(buf, 0, numRead);
                   }
                 fout.close();

                 }
                } 
            }
            
                 
smt = con.prepareStatement("Select * from inbox_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
smt.setString(1,str);
date=str;
rs=smt.executeQuery();
while(rs.next())
{ str=rs.getString(2);
  sub=rs.getString(3);
  msg=rs.getString(4);
}
smt = con.prepareStatement("Select * from attachment_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
smt.setString(1,date);
rs=smt.executeQuery();
%>


<table border="0" width="100%" id="table1">
	<tr>
	
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<b>From</b>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <%= sender%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<b>Date</b>:<%= date%></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <b>&nbsp; Subject&nbsp;</b>:&nbsp; 
        <%= sub%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<p>
		<%
String s=application.getRealPath("")+"\\attachment\\"+str+"\\enc_";

while(rs.next())
{for(int k=2;k<11;k=k+2) 
  { file=rs.getString(k);
    if(file!=null)
     { 
      disp="";
      String f="attachment\\"+str+"\\";        
      file=file.substring(s.length(),file.length());
         
      disp=file.substring(0,(file.length()-22)) ;
      f=f+disp;
      //out.println(f);
%>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
		<font color="#0000FF">&nbsp; #</font><a target="_blank" href="<%= f%>"><%= disp%><font color="#0000FF"> </font>
        </a>
        <br>          

		
<%	}//if
 }//for
}//while     
}/*if str!=null*/
            else{
                      response.sendRedirect("error.htm");
                 }        
                 
 } //try
 catch(Exception e){out.print(e);}
    %><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    	
		
		<textarea rows="12" name="S1" cols="79" tabindex="3" disabled><%= clear%></textarea>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
                 <input type="submit" value="Ok" name="B1" onclick="this.form.action='inbox.jsp';">&nbsp;&nbsp;
		<input type="submit" value="Delete" name="B2" onclick="this.form.action='delete_read.jsp';" ></p>
		</td>
	</tr>
</table>

                                 
                                  
 </body>
</html>