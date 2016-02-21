<html>
<base target="b6">

<body bgcolor="#B9DCFF" topmargin="4">
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>

<%@include file="connection.jsp"%>
<%   Statement smt=null;
        String user="";
        int i=0;
        
        ResultSet rs=null;
String receiver=session.getAttribute("receiver").toString();
  Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
try
{
        smt=con.createStatement();
      
       
     
         rs=smt.executeQuery("select * from  certificate_digisafe ");
     
        while(rs.next()){
      
        user= rs.getString(1);
            	
      
         if(receiver.equals(user))
              {  i=1;
             %>           
             <table border="0" width="901" id="table1" cellspacing="0" cellpadding="0">
	     <tr>
		<td width="700">
		<p align="left"><font color="#242424" face="Times New Roman" size="4">
		<a target="b6" style="color: #0000FF" href="inbox.jsp"> Inbox</a>&nbsp;
		<font color="#242424"><a target="b6" href="compose_attach.jsp">Compose</a></font><a target="b6" href="compose_attach.jsp">
		</a>&nbsp; <a target="b6" href="sent.jsp">Sent mail </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></td>
		<td width="450">
		<p align="right"> <font color="#242424" face="Times New Roman" size="4">
		<a target="b6" style="text-decoration: none" href="previous.jsp">&lt;&lt;previous&nbsp;</a>
        <a target="b6" style="text-decoration: none" href="next.jsp">next&gt;&gt;</a></font></td>
	    </tr>
            </table>

                  
<%           }  
	    }  
         if(i==0){  %> 
	     <table border="0" width="100%" id="table1" cellspacing="0" cellpadding="0">
	     <tr>
		<td width="760">
		<p align="left"><font color="#242424" face="Times New Roman" size="4">
		<a target="b6" href="inbox.jsp">Inbox </a>&nbsp;&nbsp;<a target="b6" href="createCertificate.htm">Create Certificate&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
		<td>
		<p align="right"><font color="#242424" face="Times New Roman" size="4">
		&nbsp;<a target="b6" style="text-decoration: none" href="inbox_pre.jsp">&lt;&lt;</a><a target="b6" style="text-decoration: none" href="previous.jsp">previous&nbsp;</a>
        <a target="b6" style="text-decoration: none" href="next.jsp">next&gt;&gt;</a></font></td>
	    </tr>
            </table>

<%          }
 
        }catch(Exception e)
      {
       out.println(e);
      }              
      %>                                     
                                   
 </body>
</html>