<html>
<body>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>

<%   Statement smt=null;
        String user="",pass="",nm="",ps="",target_check="";
        int i=0;
        ResultSet rs=null;
        
session.setAttribute("login_id","0");
try
{ 
       
       
          
        smt=con.createStatement();
        user=request.getParameter("T1");
            if(user!=null){
       rs=smt.executeQuery("select * from  login_digisafe ");
       while(rs.next()){
     
       nm= rs.getString(1);
      
       if((nm.equals(user)))
              {  i=1;
                  session.setAttribute("usr",user);                  
                  response.sendRedirect("forget_b.jsp");
              }
                  }   
if(i==0)
{ response.sendRedirect("forgot_a_invalid.htm");
}
}else{  response.sendRedirect("error.htm");}        }catch(Exception e)
      {out.println(e);
       
      }              
      %>                                     
                                   
 </body>
</html>