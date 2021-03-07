//addPatient.java
//adds one patient entry into Patients table
import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addPatient")
public class addPatient extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//Do POST to pass patient data
		PrintWriter out = response.getWriter();
		out.println("This page is intended to be accessed through a POST with patient data to pass to server. Try addPatient.jsp");
		//doPost(request, response);
	}

	//public static void main(String[] args) 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		PrintWriter out = response.getWriter();
		System.out.println("Hello from Servlet");
		
		try
		{
			Connection conn = dbConnector.dbConnect();
			PreparedStatement stmt = null;
			ResultSet rs = null;	//No results needed for INSERT

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
			out.println("Likely Class error or SQL server not running");
			//Handle errors for Class.forName
			e.printStackTrace();
		} 
		
		out.println("Goodbye from Servlet");
		System.out.println("Goodbye!");
	}
}