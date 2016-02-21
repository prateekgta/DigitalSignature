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
        String receive="",subject="",date1="",date2="",rc="";
        int i=0,j=0;
        
        ResultSet rs=null;
       ResultSet rs1=null;
        
        String receiver=session.getAttribute("receiver").toString();
          if(receiver==null)
{
  response.sendRedirect("error.htm");
}
         int count1 = Integer.parseInt(session.getAttribute("counter1").toString());

System.out.println("a");
                  int skip1=count1;
           int disp1=0;
      PreparedStatement smt1=null;
Object login_id=session.getAttribute("login_id");
System.out.println("b");
        if( login_id == null)
         {
             response.sendRedirect("error.htm");
         }
try
{
            smt=con.createStatement();
        smt1 = con.prepareStatement("select count(*) from sent_digisafe where user_sender = ?");
System.out.println("c");
        smt1.setString(1,receiver);
        rs1=smt1.executeQuery();
        int no_of_records=0;  
        if(rs1.next())
        no_of_records=rs1.getInt(1);  
        rs1.close();
       System.out.println("d");
       int d=Integer.parseInt(session.getAttribute("display1").toString());

       if(no_of_records == count1 )
          {skip1=count1-d;
            count1=count1-d;
           }System.out.println("e");
      rs=smt.executeQuery("select user_receiver,user_sender,subject,message,TO_CHAR(message_date,'YYYY-MM-DD HH:MI:SS') from  sent_digisafe order by message_date desc");
System.out.println("f");
%>
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


     
<%   
   System.out.println("g");
   while(rs.next())
	{
          rc= rs.getString(2);
         System.out.println("h");
         if((receiver.equals(rc)))
           {
            System.out.println("iskip="+skip1);
            if(skip1<=0)
		{System.out.println("j");
		disp1++;
		if(disp1<=15)
		  {
		   System.out.println("j");
		   i=1;j++;
                   receive= rs.getString(1);
          	   subject= rs.getString(3);  
         	   date1=rs.getString(5); 
                   System.out.println("k");
                   date2=date1.substring(0,10);
%>
        <tr>
		<td width="27"bgcolor="#B9DCFF" ><input type="checkbox" name="C" value="<%= date1%>"></td>
		<td width="233"bgcolor="#B9DCFF">&nbsp;<%= receive%></td>
		<td width="504"bgcolor="#B9DCFF" >&nbsp;<a href="read_sent.jsp?abc=<%= date1%>"><%= subject%></a></td>
		<td width="95"bgcolor="#B9DCFF" >&nbsp;<%= date2%></td>
	</tr>
         
                      
<% 
     System.out.println("j");
}//disp
         }//skip

          if(skip1==0);else skip1--;
	}//receiver        
       }//while
session.setAttribute("display1",String.valueOf(disp1));

 session.setAttribute("counter1",String.valueOf( count1+disp1 ));     

if(i==0)
{response.sendRedirect("sent_pre.jsp");}
        }catch(Exception e)
      {
       out.println(e);
      }              
      %>       
</table>                              
              
 </body>
</html>

	

	

