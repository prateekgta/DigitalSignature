<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Welcome</title>
<base target="_top">
</head>

<body topmargin="0">
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>
<%Statement smt=null;
        String user="";
        int i=0;
        
        ResultSet rs=null;
        user=session.getAttribute("receiver").toString();
          Object login_id=session.getAttribute("login_id");
 if(user!=null && login_id!=null)
 {       
%>


<table border="0" cellpadding="0" style="border-collapse: collapse" width="101%" id="AutoNumber1" height="1">
  <tr>
    <td width="50%" height="1">
    <p align="left"><font color="#2D96FF">Welcome,&nbsp;<%= user%></font></p>
    
  </tr>
    <td width="50%" height="1">
    <p align="right"><font color="#2D96FF">
    <a target="_top" href="registration_admin.htm"><u><font color="#2D96FF">
    register</font></u><font color="#2D96FF"> </font>
    </a> </font>&nbsp;|<font color="#2D96FF">&nbsp; </font>
	<a target="_top" href="sign_out.jsp"><font color="#2D96FF">sign out</font></a><font color="#2D96FF">
    </font>| <a target="_top" href="changepassword.jsp"><font color="#2D96FF">change password</font></a></tr>
</table>
<%
}
else
{
  response.sendRedirect("error.htm");
}
%>
&nbsp;</body></html>