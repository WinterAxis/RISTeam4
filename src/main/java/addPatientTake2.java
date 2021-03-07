/* Legacy File - Ignore
import java.io.*;		//Legacy File - Ignore
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addPatientTake2")
public class addPatientTake2 extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
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
		try
		{
			System.out.println("Connecting to database...");
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			
			String query = "select * from Patients";
			stmt = conn.prepareStatement(query);
			//stmt.setString(1, "*");
			
			
			ResultSet rs = stmt.executeQuery();
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
			out.println("Class error");
			//Handle errors for Class.forName
			e.printStackTrace();
		} finally {
		}
		out.println("Goodbye from Servlet");
		System.out.println("Goodbye!");
	}
}

*/
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