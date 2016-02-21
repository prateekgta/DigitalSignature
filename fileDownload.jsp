<html>
<head><title>try</title></head>
<body>
<%@ page  import="java.io.FileInputStream" %>
<%@ page  import="java.io.BufferedInputStream"  %>
<%@ page  import="java.io.File"  %>
<%@ page import="java.io.IOException" %>


<%

        Object login_id=session.getAttribute("login_id");
        if(user == null && login_id == null)
         {
             response.sendRedirect("error.htm");
         }
   String filename="forget.jsp";

   String filepath="http://localhost:8090/digisafe/attachment/";

BufferedInputStream buf=null;
   ServletOutputStream myOut=null;
out.println(filepath+filename); 
try{

myOut = response.getOutputStream( );
     File myfile = new File(filepath+filename);
    out.println(filepath+filename); 
     //set response headers
     response.setContentType("text/plain");
     
     response.addHeader("Content-Disposition","attachment; filename="+filename );
     response.setContentLength( (int) myfile.length( ) );
     FileInputStream input = new FileInputStream(myfile);
     buf = new BufferedInputStream(input);
     int readBytes = 0;

     //read from the file; write to the ServletOutputStream
     while((readBytes = buf.read( )) != -1)
       myOut.write(readBytes);

} catch (IOException ioe){
     
        //throw new ServletException(ioe.getMessage( ));
         
     } finally {
         
     //close the input/output streams
         if (myOut != null)
             myOut.close( );
          if (buf != null)
          buf.close( );
         
   session.setAttribute("file",filepath+filename);
    response.sendRedirect("try.jsp");
     }

   
%>
</body>
</html>