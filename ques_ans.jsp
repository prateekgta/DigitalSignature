<html>

<body>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>

<%@include file="connection.jsp"%>
<%   PreparedStatement smt=null;
        String ques="",ans="";
        int i=0;
        
         ResultSet rs=null;
         String user=session.getAttribute("receiver").toString();
         out.println(user);
         Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
try
{
         
       
        ques=request.getParameter("T1");
        ans=request.getParameter("T2");
        smt=con.prepareStatement("UPDATE login_digisafe SET question=?,answer=?,check1=1  WHERE  username=? ");
        smt.setString(1,ques);
        smt.setString(2,ans);
        smt.setString(3,user.toString());
        smt.executeQuery();      
        smt.close();

            if(user.equals("admin"))
                {
                  response.sendRedirect("admin.htm"); 
                } 
                          
         else{   response.sendRedirect("master.htm"); 
               }    
        }catch(Exception e)
      {
       out.println(e);
      }              
      %>                                     
                                   
 </body>
</html>

	

	

