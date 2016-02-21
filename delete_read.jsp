<html>

<body bgcolor="#ECF5FF" style="color: #B9DCFF; border-left-style: solid; border-left-width: 3; border-right-style: solid; border-right-width: 3">

<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>
<% try{
        
       
          String s="",str="";
        int i=0,check,j=0;
       str=session.getAttribute("dateMsg").toString();
        Object login_id=session.getAttribute("login_id");
        if(login_id == null)
         {
             response.sendRedirect("error.htm");
         }
if(str!=null)
{
 PreparedStatement smt;

        
smt = con.prepareStatement("delete from inbox_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
    
smt.setString(1,str);
 smt.executeQuery();

smt = con.prepareStatement("commit");

        smt.executeQuery();
        
          
     response.sendRedirect("inbox.jsp");
    
}else
{
    response.sendRedirect("error.htm");
}      }catch(Exception e){out.println(e);}
%>

     
                   
              
 </body>
</html>