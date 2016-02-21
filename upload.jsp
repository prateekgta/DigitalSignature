<html>
<head>
<base target="_self">
</head>
<body>
<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%  int k=0;Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
String add="",sub="",msg="";
       if(k==0)
       {
      add=request.getParameter("T1");
      sub=request.getParameter("T2");
      msg=request.getParameter("S1");
      k++;
      // if(add!=null)
    session.setAttribute("add",add);
 
  //  if(sub!=null)   
   session.setAttribute("sub",sub);
   //  if(msg!=null) 
    session.setAttribute("msg",msg);
      
     }
         
     
 %>

<form method="post" action="fileUpload.jsp" name="upform" enctype="multipart/form-data">  
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <div align="center">
    <center>
  <table width="546" border="0" cellspacing="1" cellpadding="1" class="style1">  
    <tr>  
      <td align="left" colspan="2" width="542"><b>Select a file to upload :</b></td>  
    </tr>  
    <tr>  
      <td align="left" colspan="2" width="542">  
        <input type="file" name="uploadfile" size="50">  
        </td>  
    </tr>  
    <tr>  
      <td align="left" width="139">  
  <input type="hidden" name="todo" value="upload">  
        <input type="submit" name="Submit" value="Upload">  
        <input type="reset" name="Reset" value="Cancel">  
        </td>  
      <td align="left" width="400">  
        <input type="submit" name="discard" value="Discard" onclick="this.form.action=' compose.jsp';"></td>  
    </tr>  
  </table>  
    </center>
  </div>
</form>  
&nbsp;
</body>
</html>