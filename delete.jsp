<html>
<body bgcolor="#ECF5FF" style="color: #B9DCFF; border-left-style: solid; border-left-width: 3; border-right-style: solid; border-right-width: 3">
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>
<% try{
        
       
          String s="",goto1="";
        int i=0,check,j=0;
        PreparedStatement smt;
 String str[]=request.getParameterValues("C");
goto1=session.getAttribute("goto1").toString();
 Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
if(str!=null && goto1!= null)
{
int l=str.length;
      
  
  out.println(goto1); 
    if(goto1.equals("0")){ 
        while(i<l)
        {

smt = con.prepareStatement("delete from inbox_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
s=str[i];        
smt.setString(1,s);
        smt.executeQuery();
        i++; 
smt = con.prepareStatement("commit");

        smt.executeQuery();
        
         } 
     response.sendRedirect("delete_success.htm");}
    else
      {   while(i<l)
        {

smt = con.prepareStatement("delete from sent_digisafe where TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') =?");
s=str[i];        
smt.setString(1,s);
        smt.executeQuery();
        i++; 
smt = con.prepareStatement("commit");

        smt.executeQuery();
        
         } 
 response.sendRedirect("delete_success2.htm");}
}else
{
 goto1=session.getAttribute("goto1").toString();
  if(goto1!=null){
    if(goto1.equals("0"))
     response.sendRedirect("inbox.jsp");
    else
       response.sendRedirect("sent.jsp");
}

}

      }catch(Exception e){                         
                          out.println(e);
                         }
%>

      
 </body>
</html>