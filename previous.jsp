<html>


<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>


<%   
try
{Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
    String goto1=session.getAttribute("goto1").toString(); 
     if(goto1 == null)
{
  response.sendRedirect("error.htm");
}
    if(goto1.equals("0"))
     response.sendRedirect("inbox_pre.jsp");
    else
       response.sendRedirect("sent_pre.jsp");

    }catch(Exception e)
      {
       out.println(e);
      }              
      %>       
</table>                              
              
 </body>
</html>

	

	

