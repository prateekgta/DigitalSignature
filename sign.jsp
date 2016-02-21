<html>

<title>compose</title>
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
  

   var s2,s3,s4;
 s2=a.length
 s3=b.length
         
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

           var flag1=confirm("you want to send message without any subject?");
           if(flag1==false)
           {
           flag=false
           }
           else
           document.reg.T2.value="No subject"

    
        } 
        
       }        
        return flag
  }
  </script>

<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Signing</title>
</head>
<%@ page language="java" %> 
<%@ page import="java.io.*,javax.crypto.*,java.security.*,sun.misc.BASE64Encoder" %>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%String add="",sub="",msg=""; 
try{Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
  add =request.getParameter("T1"); 
  sub =request.getParameter("T2"); 
   msg =session.getAttribute("enc_msg").toString(); 
   if(msg == null)
{
  response.sendRedirect("error.htm");
}
}catch(Exception e){out.println(e);  }
%>

<body bgcolor="#ECF5FF">
	<FORM NAME="reg" ONSUBMIT="return check()" action ="sign_next.jsp" method=post >
<table border="0" width="100%" id="table1">
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Address&nbsp;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="text" name="T1" value = "<%= add%>" size="104" maxlength="500" tabindex="1" ></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Subject</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="text" name="T2" value = "<%= sub%>"  size="104" maxlength="500" tabindex="2" ></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Write your message here&nbsp;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" i-maximum-length="4000" --><textarea rows="12" name="S1" cols="79" tabindex="3" disabled><%= msg%></textarea>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <b>Enter Your 
        Certificate Password : </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="password" name="T3" size="19" tabindex="4" maxlength="50" >&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" value="Ok" name="B3" onclick="this.form.action='sign_next.jsp';" tabindex="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a target="_self" href="inbox.jsp">
		<input type="submit" value="Discard" name="B2" onclick="this.form.action='compose_attach.jsp';" tabindex="6"></a></p>
		</td>
	</tr>
</table>

</body>

</html>