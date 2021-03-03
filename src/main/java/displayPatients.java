import java.io.*;
import java.sql.*;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/displayPatients")
public class displayPatients extends HttpServlet {

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/RISdb";
	static final String USER = "root";
	static final String PASS = "";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	//public static void main(String[] args) 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		PrintWriter out = response.getWriter();
		System.out.println("Hello from Servlet");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{
			System.out.println("Connecting to database...");
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			
			String query = "select * from Patients";
			stmt = conn.prepareStatement(query);
			//stmt.setString(1, "*");
			
			
			rs = stmt.executeQuery();	//executeQuery() for SELECT
			out.println("Patient List\nName\tID");
			while(rs.next())
			{
				out.println(rs.getString("PatientName")+"\t"+rs.getInt("PatientID"));
			}
	
		}catch(SQLException se){
			out.println("SQL Error");
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			out.println("Likely Class error");
			//Handle errors for Class.forName
			e.printStackTrace();
		} finally {
		}
		out.println("Goodbye from Servlet");
		System.out.println("Goodbye!");
	}
}

/*@WebServlet("/addPatientTake2")

private DataSource dataSource;

public Database(String jndiname) {
    try {
        dataSource = (DataSource) new InitialContext().lookup("java:comp/env/" + jndiname);
    } catch (NamingException e) {
        // Handle error that it's not configured in JNDI.
        throw new IllegalStateException(jndiname + " is missing in JNDI!", e);
    }
}

public Connection getConnection() {
    return dataSource.getConnection();
} */