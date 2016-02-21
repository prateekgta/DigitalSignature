<html>
<body bgcolor="#ECF5FF">
<form name="sign" Onsubmit="return true" action="sign.jsp" method="POST">
<%@ page language="java" %> 
<%@ page import="java.io.*,java.util.Properties.*,javax.crypto.*,java.security.*,sun.misc.BASE64Decoder,javax.crypto.spec.*" %>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>
<%      
         PreparedStatement smt=null;
        String msg="",key="",sub="",sender="",str="";
        int i=0;
        
        ResultSet rs=null;
  try{         Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         } 
          str= request.getParameter("abc");
     if(str!=null)
{
       session.setAttribute("dateMsg",str);
           
             smt = con.prepareStatement("Select * from inbox_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
            smt.setString(1,str);
            rs=smt.executeQuery();
            while(rs.next())
            {
             sender=rs.getString(2);
             sub=rs.getString(3);
             msg= rs.getString(4);
             key= rs.getString(6);  
            }    
        

}else{  response.sendRedirect("error.htm");}                
              } catch(Exception e){
                    out.println(e);}
    %>    

<table border="0" width="100%" id="table1">
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<b>From :</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <%= sender%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <b>Date:</b><%= str%></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Subject</b>&nbsp;:&nbsp; 
        <%= sub%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<textarea rows="12" name="S1" cols="79" tabindex="3" disabled><%= msg%></textarea>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
                 <input type="submit" value="Ok" name="B1" onclick="this.form.action='inbox.jsp';" >&nbsp;&nbsp;
		<input type="submit" value="Delete" name="B2" onclick="this.form.action='delete_read.jsp';" ></p>
		</td>
	</tr>
</table>

                                 
                                  
 </body>
</html>