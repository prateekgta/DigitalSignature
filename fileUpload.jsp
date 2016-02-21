<%@ page import="java.io.*,javax.servlet.http.HttpServletRequest,javax.servlet.ServletInputStream" %>  
<%@ page import="java.io.FileWriter,java.io.IOException" %>  
<%  
 String savePath = "", filepath = "", filename = "";  
 String contentType = "", fileData = "", strLocalFileName = "";  
 int startPos = 0;  
 int endPos = 0;  
String user=session.getAttribute("receiver").toString();
 Object login_id=session.getAttribute("login_id");
        if(user == null && login_id == null)
         {
             response.sendRedirect("error.htm");
         }
%>  
<%!  
 //copy specified number of bytes from main data buffer to temp data buffer  
 void copyByte(byte [] fromBytes, byte [] toBytes, int start, int len)  
 {  
  for(int i=start;i<(start+len);i++)  
  {  
   toBytes[i - start] = fromBytes[i];  
  }  
 }  
%>  
<%  
 int BOF = 0, EOF = 0;  
 contentType = request.getContentType();  
 
  if ((contentType != null) && (contentType.indexOf("multipart/form-data") >=0))  
 {  
  DataInputStream in = new DataInputStream(request.getInputStream());  
  DataInputStream in1 = in;  
  int formDataLength = request.getContentLength();  
  byte dataBytes[] = new byte[formDataLength];  
  int byteRead = 0;  
  int totalBytesRead = 0;  
  while (totalBytesRead < formDataLength)  
  {  
   byteRead = in1.read(dataBytes, totalBytesRead, formDataLength);  
   totalBytesRead += byteRead;  
  }  
  byte[] line = new byte[128];  
  if (totalBytesRead < 3)  
  {  
    return; //exit if file length is not sufficiently large  
  }  
  
  String boundary = "";  
  String s = "";  
  int count = 0;  
  int pos = 0;  
  
  //loop for extracting boundry of file  
  //could also be extracted from request.getContentType()  
  do  
  {  
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time  
   count+=1;  
   s = new String(line, 0, 1);  
   fileData = fileData + s;  
   pos = fileData.indexOf("Content-Disposition: form-data; name=\""); //set  the file name  
   if(pos != -1)  
    endPos = pos;  
  }while(pos == -1);  
  boundary = fileData.substring(startPos, endPos);  
  
  //loop for extracting filename  
  startPos = endPos;  
  do  
  {  
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time  
   count+=1;  
   s = new String(line, 0, 1);  
   fileData = fileData + s;  
   pos = fileData.indexOf("filename=\"", startPos); //set the file name  
   if(pos != -1)  
    startPos = pos;  
  }while(pos == -1);  
  do  
  {  
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time  
   count+=1;  
   s = new String(line, 0, 1);  
   fileData = fileData + s;  
   pos = fileData.indexOf("Content-Type: ", startPos);  
   if(pos != -1)  
    endPos = pos;  
  }while(pos == -1);  
  filename = fileData.substring(startPos + 10, endPos - 3); //to eliminate "from start & end  
  strLocalFileName = filename;  
  int index = filename.lastIndexOf("\\");  
  if(index != -1)  
   filename = filename.substring(index + 1);  
  else  
   filename = filename;  
  
  //loop for extracting ContentType  
  boolean blnNewlnFlag = false;  
  startPos = endPos; //added length of "Content-Type: "  
  do  
  {  
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time  
   count+=1;  
   s = new String(line, 0, 1);  
   fileData = fileData + s;  
   pos = fileData.indexOf("\n", startPos);  
   if(pos != -1)  
   {  
    if(blnNewlnFlag == true)  
     endPos = pos;  
    else  
    {  
     blnNewlnFlag = true;  
     pos = -1;  
    }  
   }  
  }while(pos == -1);  
  contentType = fileData.substring(startPos + 14, endPos);  
  
  //loop for extracting actual file data (any type of file)  
  startPos = count + 1;  
  do  
  {  
   copyByte(dataBytes, line, count ,1); //read 1 byte at a time  
   count+=1;  
   s = new String(line, 0, 1);  
   fileData = fileData + s;  
   pos = fileData.indexOf(boundary, startPos); //check for end of file data i.e boundry value  
  }while(pos == -1);  
  endPos = count - boundary.length();  
  //file data extracted  
  
  //create destination path & save file there  
  String appPath = application.getRealPath("/");  
                java.util.Date dt=new java.util.Date();
                java.sql.Timestamp ts=new java.sql.Timestamp(dt.getTime());
                String str_ts=(ts.toString()).substring(0,10);
                str_ts=str_ts.concat((ts.toString()).substring(11,(ts.toString().length())));
                StringBuffer str_ts1=new StringBuffer(str_ts);           
                 str_ts1.setCharAt(12, '.');
                 str_ts1.setCharAt(15, '.');
   String destFolder = appPath + "attachment\\"+user+"\\";  
   out.println("des folder"+destFolder);
  filename= destFolder + filename+str_ts1;  
  FileOutputStream fileOut = new FileOutputStream(filename);  
  fileOut.write(dataBytes, startPos, (endPos - startPos));  
  fileOut.flush();  
  fileOut.close();  
   String file=session.getAttribute("file").toString();
   //out.println("filesession"+file);
   String filename1=filename.substring((application.getRealPath("")+"\\attachment\\"+user+"\\").length(),filename.length());
   if(file==null || file.equals(""))
   { file=""; 
     session.setAttribute("file",filename1);
   }
   else
    { session.setAttribute("file",(file+","+filename1));}
 out.println("filename1="+filename);
  response.sendRedirect("compose.jsp"); 
 }  
 else  
 {  
  out.println("Error in uploading ");  
 }  
  
%>  
