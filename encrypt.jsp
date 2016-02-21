<html>
<head>
<SCRIPT LANGUAGE="javascript">

function IsNumeric1(sText)
{

   var ValidChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.@_,";
   var IsNumber=true;
   var Char;
   for (i = 0; i< sText.length && IsNumber==true; i++)  
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
           IsNumber = false;
         }
      }
   return IsNumber;
   
   }

 function check()
{ var a,b,c,d,flag=true;
  a =document.reg.T1.value
  b =document.reg.T2.value
  c =document.reg.S1.value

   var s2,s3,s4;
 s2=a.length
 s3=b.length
 s4=c.length
         
         if(IsNumeric1(a)){
         }
         else
         { flag=false
          alert("only numbers,alphabets . @ , and _ are allowed as valid usernames");
         }
         if(s2==0)
          {
           alert("Address can't be empty")
           flag=false
          }         
        else 
        {
         
         if((s3 == 0))
        {  

           var flag1=confirm("you want to send message without any subject?","yes","no");
           if(flag1==false)
           {
           flag=false
           }
           else
           document.reg.T2.value="No subject"

    
        } 
        if ((s4 == 0))
        {  
           var flag2=confirm("you want to send message without any body?");
           if(flag2==false)
           flag=false
                
        } 
       }        
        return flag
  }
  </script>


</head>
<body bgcolor="#ECF5FF">
<form name="reg" Onsubmit="return check()" action="sign.jsp" method="POST">
<%@ page language="java" %> 
<%@ page import="java.io.*,java.util.*,javax.crypto.spec.*,javax.crypto.*,java.security.*,sun.misc.BASE64Encoder" %>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>
<% 
      
        
        String  str_key1="";
        String str_key3="",str1="",f="";
        int i=0;
        
        ResultSet rs=null;
         FileOutputStream fos;
           FileInputStream fis;
        String user=session.getAttribute("receiver").toString();
         String file=session.getAttribute("file").toString();
 Object login_id=session.getAttribute("login_id");
        if(user == null && login_id == null)
         {
             response.sendRedirect("error.htm");
         }
        
            String file1=file;
          if(file1.equals("") || file1 ==null)
     file1="";
   else
     {f=file1;
      StringTokenizer st=new StringTokenizer(f,","); 
       String s="" ;
       file1="";
       while(st.hasMoreTokens())
      {
       s=st.nextToken();
       s=s.substring(0,(s.length()-22));
       file1=file1+"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#"+s;
     }
    }    
 

             
        String msg=request.getParameter("S1");
        String add=request.getParameter("T1");
        String sub=request.getParameter("T2");
       // session.setAttribute("add",add);  
        session.setAttribute("enc_msg",msg); 
        session.setAttribute("ori_msg",msg);  
       // session.setAttribute("sub",sub); 
        String strCipherText = new String();
 String strCipherText1 = new String();
  StringTokenizer st=null;
byte[] enc=null;
        if(user!=null )
       {
	try{ 
    
		
		KeyGenerator keyGen = KeyGenerator.getInstance("DES");
		SecretKey secretKey = keyGen.generateKey();
                String str=secretKey.toString();
                Cipher desCipher = Cipher.getInstance("DES");
		desCipher.init(Cipher.ENCRYPT_MODE,secretKey);
		byte[] byteDataToEncrypt = msg.getBytes();
		byte[] byteCipherText = desCipher.doFinal(byteDataToEncrypt); 
		strCipherText = new BASE64Encoder().encode(byteCipherText);
                i=0;
                java.util.Date dt=new java.util.Date();
                java.sql.Timestamp ts=new java.sql.Timestamp(dt.getTime());
                String str_ts=(ts.toString()).substring(0,10);
                
                str_ts=str_ts.concat((ts.toString()).substring(11,(ts.toString().length())));
                StringBuffer str_ts1=new StringBuffer(str_ts);           
                 str_ts1.setCharAt(12, '.');
                 str_ts1.setCharAt(15, '.');
                
                String unique =user+str_ts1;
                   ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(application.getRealPath("")+"\\key\\"+unique));
                oos.writeObject(secretKey);
                oos.flush();
                oos.close();
                           
               session.setAttribute("sec_key",application.getRealPath("")+"\\key\\"+unique); 
               session.setAttribute("enc_msg",strCipherText); 

/*FILE ENCRYPTION*/

               if(!(file.equals("")) || !(file ==null))
               {
                 st = new StringTokenizer(file,",");
                 String s="";
                 file="";
                 while(st.hasMoreTokens())
                    {
                       s=st.nextToken();
                      
                     InputStream in= new FileInputStream(application.getRealPath("")+"\\attachment\\"+user+"\\"+s);
                      //BufferedInputStream bufin = new BufferedInputStream(fis);
                      OutputStream fout= new FileOutputStream(application.getRealPath("")+"\\attachment\\"+user+"\\enc_"+s);
                      //byte[] buffer = new byte[1024];
                       //int len;
                      byte[] buf = new byte[1024];
    
                       fout = new CipherOutputStream(fout, desCipher);
                    // Read in the cleartext bytes and write to fout to encrypt
                int numRead = 0;
                while ((numRead = in.read(buf)) >= 0) {
                    fout.write(buf, 0, numRead);
                }
                fout.close();

                      
  


}}


               }catch(Exception e){
out.print(e);}
}else{  response.sendRedirect("error.htm");}
          %>    

	<table border="0" width="100%" id="table1">
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b> 
		insert addresses ( separated by commas)</b><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Address</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-minimum-length="1" i-maximum-length="500" --><input type="text" name="T1" size="104" value="<%= add%>" maxlength="500" tabindex="1"></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Subject&nbsp;&nbsp;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="500" --><input type="text" name="T2" size="104"value="<%= sub%>" maxlength="500" tabindex="2"></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= file1%></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Your encrypted message</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
		<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="4000" --><textarea rows="12" name="S1" cols="79" tabindex="3" disabled><%= strCipherText%></textarea></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
		
                 <input type="submit" value="Sign" name="B1" onclick="this.form.action='sign.jsp';" tabindex="4">&nbsp;&nbsp;
		<input type="submit" value="Discard" name="B2" onclick="this.form.action='compose_attach.jsp';" tabindex="5"></p>
		</td>
	</tr>
</table>

                                 
                                  
 </body>
</html>&nbsp;</form>