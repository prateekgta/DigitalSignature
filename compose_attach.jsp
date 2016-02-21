<html>

<head>
<SCRIPT LANGUAGE="javascript">

function IsNumeric1(sText)
{

   var ValidChars = "0123456789abcdefghijklmnopqrstuvwxyz.@_,";
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
  getAdd()
  {
   a=document.reg.T1.value;
   return a;
  }
  getSub()
  {
   a=document.reg.T2.value;
   return a;
  }
  getMsg()
  {
   a=document.reg.S1.value;
   return a;
  }
  </script>


<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body bgcolor="#ECF5FF">
	<form   name="reg" onsubmit="return check()" method=post>
	<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*,java.util.*" %>
<% 
        String user=session.getAttribute("receiver").toString();
          String file=session.getAttribute("file").toString();
            session.setAttribute("attach",String.valueOf(0));
 Object login_id=session.getAttribute("login_id");
        if(user == null && login_id == null)
         {
             response.sendRedirect("error.htm");
         }
   if(!(file.equals("")) || !(file ==null))
     {
   StringTokenizer st = new StringTokenizer(file,",");
   String s="";
       file="";
       while(st.hasMoreTokens())
      {
       s=st.nextToken();
File f = new File(application.getRealPath("")+"\\attachment\\"+user+"\\"+s);
f.delete();
}}
session.setAttribute("file","");%>

		
<table border="0" width="100%" id="table1" height="425">
	<tr>
		<td height="99">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>insert addresses ( separated by commas)</b><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Address</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-minimum-length="1" i-maximum-length="500" --><input type="text" name="T1" size="104" maxlength="500" tabindex="1" ><input type="hidden" name="add" value="return getAdd()"></p>
	
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Subject&nbsp;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="500" --><input type="text" name="T2" size="104" maxlength="500" tabindex="2"><input type="hidden" name="sub" value="return getSub()"></p></td>

	</tr>	  
   
  
  <tr>
		<td height="318"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<input type="submit" value="Attach files" name="B4" onclick="this.form.action='upload.jsp';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Write your message here&nbsp;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="2000" --><textarea rows="12" name="S1" cols="79" tabindex="3"></textarea><input type="hidden" name="msg" value="return getMsg()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

		<input type="submit" value="Encrypt" name="B1" onclick="this.form.action='encrypt.jsp';" tabindex="4">&nbsp;&nbsp;&nbsp;
		
		
		&nbsp;<input type="reset" value="Cancel"  name="B2" tabindex="5" >
		&nbsp;</p>
		</td>
	</tr>
</table>
</body></html>