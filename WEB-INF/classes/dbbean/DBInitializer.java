package dbbean;

import java.sql.*;
import java.util.StringTokenizer;
import java.io.*;

public class DBInitializer extends DbBean {
public  void createTables(String path)
{
try{
	FileInputStream in=new FileInputStream(path);
	byte data[]=new byte[in.available()];
	in.read(data);
	in.close();
	StringTokenizer str=new StringTokenizer(new String(data),"/");
	Connection con=getConnect();
	Statement stmt=con.createStatement();
	System.out.println("creating tables...");
	while (str.hasMoreTokens())
	{       
		String Qr=str.nextToken();
		System.out.println(Qr);
		if(Qr.trim().equals("stop"))
		{
		break;
		}
		stmt.execute(Qr);
	}
	con.close();
	System.out.println("tables successfully created.");
	}catch(Exception e)
{
System.out.println(e);	
}
}

}
