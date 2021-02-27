import java.io.*;
import java.sql.*;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addPatient")
public class addPatient extends HttpServlet {

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/RISdb";
	static final String USER = "root";
	static final String PASS = "";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			
			String query = "INSERT INTO Patients (PatientName) VALUES (?)";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, request.getParameter("patientName"));	//getParameter just strings, must cast for other
			stmt.executeUpdate();		//executeUpdate() for INSERT,
			
			System.out.println("Added Successfully.");
			out.println("Added Successfully.");
			
			//Closes open DB communication
			stmt.close();
			conn.close();
	
		}catch(SQLException se){
			out.println("SQL Error");
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			out.println("Likely Class error");
			//Handle errors for Class.forName
			e.printStackTrace();
		} 
		
		out.println("Goodbye from Servlet");
		System.out.println("Goodbye!");
	}
}