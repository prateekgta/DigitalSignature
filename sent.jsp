<html>
<head>
<script language=javascript>

checked=false;
function checkedAll (myform) {
	var aa= document.getElementById('myform');
	 if (checked == false)
          {
           checked = true
          }
        else
          {
          checked = false
          }
	for (var i =0; i < aa.elements.length; i++) 
	{
	 aa.elements[i].checked = checked;
	}
      }
</script>
</head>


<body bgcolor="#ECF5FF" style="color: #B9DCFF; border-left-style: solid; border-left-width: 3; border-right-style: solid; border-right-width: 3">

<FORM onSubmit="return true" METHOD="post" NAME="myform" ACTION="delete.jsp">

<input type="submit" value="Delete" name="d1" style="width: 74; height: 24">

<%@ page language="java" %> 
<%@ page import="java.io.*, java.sql.*" %>
<%@include file="connection.jsp"%>

<%   Statement smt=null;
        String receive="",subject="",date1="",rc="",date2="";
        int i=0,j=0,k=1;
        
        ResultSet rs=null;
Object login_id=session.getAttribute("login_id");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
        String receiver=session.getAttribute("receiver").toString();
         if(receiver == null)
{
  response.sendRedirect("error.htm");
}
        session.setAttribute("goto1",String.valueOf(k));
        int skip1=0;
try
{
           smt=con.createStatement();
        rs=smt.executeQuery("select user_receiver,user_sender,subject,message,TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') from  sent_digisafe order by message_date desc");%>
        <table border="1" width="100%" bgcolor="#ECF5FF" cellspacing="1" style="color: #000000" cellpadding="2">
	<tr>
		<td width="27" bordercolor="#A6A6A6" >
		<input type="checkbox" name="checkall"  onclick='checkedAll(myform);'></td>
		<td width="233">
		<p align="center"><font color="#000000">Receiver</font></td>
		<td width="504" >
		<p align="center"><font color="#000000">Subject</font></td>
		
		<td width="95" >
		<p align="center"><font color="#000000">Date</font></td>
	</tr>


     
<%        while(rs.next()){
         rc= rs.getString(2);%>
         	
         
      <%
         if((receiver.equals(rc)))
              { if(skip1<15){i=1;j++;skip1++;
                  receive= rs.getString(1);
          	  subject= rs.getString(3);  
         	   date1= rs.getString(5);
                   date2=date1.substring(0,10);
                   
%>
                   <tr>
		<td width="27"bgcolor="#B9DCFF" ><input type="checkbox" name="C" value="<%= date1%>"></td>
		<td width="233"bgcolor="#B9DCFF">&nbsp;<%= receive%></td>
		<td width="504"bgcolor="#B9DCFF" >&nbsp;<a href="read_sent.jsp?abc=<%= date1%>"><%= subject%></a></td>
                 
		
			
		<td width="95"bgcolor="#B9DCFF" >&nbsp;<%= date2%></td>
	</tr>

                    
                      
   <%}
           }       
               }

session.setAttribute("counter1",String.valueOf(skip1));  

                    
if(i==0)
{%>
</table> <p align="center"><b><font color="#525252" size="5">No mails</font></b></p>

<%}

        }catch(Exception e)
      {
       out.println(e);
      }              
      %>       
         
              
 </body>
</html>