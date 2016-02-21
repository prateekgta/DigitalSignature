<html>
<body>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>

<%@ include file="connection.jsp"%>
<%   
PreparedStatement smt=null;
String user="",pass="",nm="",ps="",target_check="";
int i=0,check=0;
System.out.println("1");
ResultSet rs=null;
session.setAttribute("counter",String.valueOf(i));  
session.setAttribute("display",String.valueOf(i));
session.setAttribute("counter1",String.valueOf(i));  
session.setAttribute("display1",String.valueOf(i)); session.setAttribute("file","");
session.setAttribute("login_id",String.valueOf(i));  
 try
   {    
	out.println("1"+con);
        user=request.getParameter("T1");
        pass=request.getParameter("T2");
        smt=con.prepareStatement("select * from login_digisafe where username=? and password=?");
	smt.setString(1,user);
	smt.setString(2,pass);
	out.println("2");
        rs=smt.executeQuery();
        System.out.println("1");
        if(rs.next())
	{i=1;
         check=rs.getInt(5);
	 out.println("4");                                                  System.out.println("2");
         session.setAttribute("receiver",user);                                 if(check==0)
	      {
	       System.out.println("check=="+check);
               response.sendRedirect("Question_answer.htm");                     }
	    else if(check==2)
              {                       	                                           System.out.println("3");
		out.println("6");
                response.sendRedirect("admin.htm"); 
              }
	    else
              {                       	                                           System.out.println("3");
		out.println("6");
                response.sendRedirect("master.htm"); 
              }
        }            
          
        if(i==0)
	{ 
	System.out.println("i=="+i);
	response.sendRedirect("frame_invalid.htm");
	out.println("8");
	}
   }
   catch(Exception e)
      {
       out.println(e);
      } 
             
      %>                                     
                                   
 </body>
</html>