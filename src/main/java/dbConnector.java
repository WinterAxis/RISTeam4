//dbConnector.java - Not a webpage
//call dbConnector.dbConnect() at start of db operations
import java.sql.*;

public class dbConnector 
{
	protected static Connection dbConnect() throws SQLException, ClassNotFoundException
	{
		final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		final String DB_URL = "jdbc:mysql://localhost:3306/RISdb";
		final String USER = "root";			//TODO: UNIQUE LOGINS
		final String PASS = "";
		
		Connection conn = null;

		try
		{
			System.out.println("Connecting To Database...");
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			System.out.println("Connected Successfully.");
		} catch(SQLException se){
			System.out.println("SQL Error");
			//Handle errors for JDBC
			se.printStackTrace();
		} catch(Exception e){
			System.out.println("Likely Class error");
			//Handle errors for Class.forName
			e.printStackTrace();
		}
		return conn;
	}
}