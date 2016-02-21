<html>
<body>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>

<%@include file="connection.jsp"%>
<%   Statement smt=null;
        String user="",pass="",nm="",ps="",target_check="",npass="";
        int i=0;
        
        ResultSet rs=null;
       
try
{ Object login_id=session.getAttribute("login_id");
       
      
        smt=con.createStatement();
        user=request.getParameter("T1");
        pass=request.getParameter("T2");
        npass=request.getParameter("T3");
if(user!=null && pass!=null && npass!=null && login_id!=null)
{
       rs=smt.executeQuery("select * from  login_digisafe ");

        while(rs.next()){
      
         nm= rs.getString(1);
         ps = rs.getString(2);    	
      
         if((nm.equals(user))&&(ps.equals(pass)))
              { i=1;
                   PreparedStatement state=con.prepareStatement("update login_digisafe set" + " username = ? , password = ?   where username= ?");
  
                                         state.setString(1,user);
                                         state.setString(2,npass);
                                         state.setString(3,user);

                                         state.executeUpdate();
              }
}
                  if(i==0)
 {
   response.sendRedirect("change_password_invalid.jsp");
 }

   String receiver=session.getAttribute("receiver").toString(); 
  if(receiver.equals("admin"))
  {
     response.sendRedirect("change_password_admin.htm");
 }
 else{
            response.sendRedirect("change_password_master.htm");
       }
   }
else
{  response.sendRedirect("error.htm");
}     
 }
catch(Exception e)
      {
         if(e.equals("java.lang.NullPointerException"))
               response.sendRedirect("error.htm");      
      }              
      %>                                     
                                   
 </body>
</html>

	

	

