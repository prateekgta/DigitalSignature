<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Welcome</title>
<base target="_top">
</head>
<%@include file="connection.jsp"%>
<body topmargin="0">
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%Statement smt=null;
        String user="";
        int i=0;
      
        ResultSet rs=null;
        user=session.getAttribute("receiver").toString();
        Object login_id=session.getAttribute("login_id");
        if(user == null && login_id == null)
         {
             response.sendRedirect("error.htm");
         }
         
%>
<table border="0" cellpadding="0" style="border-collapse: collapse" width="101%" id="AutoNumber1" height="1">
  <tr>
    <td width="71%" height="1">
    <p> <user><font color="#2D96FF"> &nbsp;Welcome,&nbsp; <%= user%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
    </font></p>
    
  </tr>
    <td width="29%" height="1">
    <p align="right"> <user><a target="_top" href="sign_out.jsp"><font color="#2D96FF">Sign out</font></a><font color="#2D96FF">
    |</font> <a target="_top" href="changepassword.jsp"><font color="#2D96FF">Change password</font></a><font color="#2D96FF">&nbsp; </font>
    
  </tr>
</table>

</body>

</html>