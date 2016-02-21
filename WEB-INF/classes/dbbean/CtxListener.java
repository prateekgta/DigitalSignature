package dbbean;
import java.io.File;
import javax.servlet.*;
public class CtxListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent c) {
		
	}

	public void contextInitialized(ServletContextEvent c) {
		ServletContext ctx=c.getServletContext();
		String param=ctx.getInitParameter("createTables");
		if (param.equals("yes"))
		{
			System.out.println("creating tables...");
			
		String p=ctx.getRealPath("WEB-INF/classes/tables/tables.sql");	
			DBInitializer db=new DBInitializer();
			db.createTables(p);
		}
	}

}
