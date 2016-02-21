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
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*,java.util.*" %>
<%  String file=session.getAttribute("file").toString();
         int attach=Integer.parseInt(session.getAttribute("attach").toString());
      
     String add=session.getAttribute("add").toString();
      String sub=session.getAttribute("sub").toString();
      String msg=session.getAttribute("msg").toString();
       Object login_id=session.getAttribute("login_id");
       if(login_id == null )
{
  response.sendRedirect("error.htm");
} 

      attach++;
       session.setAttribute("attach",attach);
      try{
  
    String f="";
   if(file.equals("") || file ==null)
     file="";
   else
     {f=file;
      StringTokenizer st=new StringTokenizer(f,","); 
       String s="";
       file="";
       while(st.hasMoreTokens())
      {
       s=st.nextToken();
       s=s.substring(0,(s.length()-22));
       file=file+"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#"+s;
     }
    }    }catch(Exception e){out.println(e);}
   %>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Compose</title>
</head>

<body bgcolor="#ECF5FF">
	<form   name="reg" onsubmit="return check()" method=post>
		
<table border="0" width="100%" id="table1" height="425">
	<tr>
		<td height="99">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>insert addresses ( separated by commas)</b><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Address</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-minimum-length="1" i-maximum-length="500" --><input type="text" name="T1" size="104" maxlength="500" tabindex="1" value ="<%= add%>"></p>
	
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Subject&nbsp;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="500" --><input type="text" name="T2" size="104" maxlength="500" tabindex="2" value ="<%= sub%>"></p></td>

	</tr>	  
   
  
  <tr>
		<td height="318">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <%= file%>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<% if(attach < 5) {%>
        <input type="submit" value="Attach files" name="B3" onclick="this.form.action='upload.jsp';"></p>
    <% } else { %>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="#FF0000">You are not allowed to attach more files</font></p>
    <% }  %>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <b>Write your message here&nbsp;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="2000" --><textarea rows="12" name="S1" cols="79" tabindex="3"><%= msg%></textarea>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

		<input type="submit" value="Encrypt" name="B1" onclick="this.form.action='encrypt.jsp';" tabindex="4">&nbsp;&nbsp;&nbsp;
		
		
		&nbsp;<input type="reset" value="Cancel"  name="B2" tabindex="5" >
		&nbsp;</p>
		</td>
	</tr>
</table>
</form>
</body></html>