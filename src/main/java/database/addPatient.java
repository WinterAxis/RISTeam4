//addPatient.java
//adds one patient entry into Patients table
package database;

import java.io.*;
import java.sql.*;
import java.util.Enumeration;

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

		// outputs the request - Commented for now
		Enumeration<String> params = request.getParameterNames();
		while(params.hasMoreElements()){
			String paramName = params.nextElement();
			out.println("Parameter Name - "+paramName+", Value - "+request.getParameter(paramName));
		}
		try
		{
			Connection conn = database.dbConnector.dbConnect();
			PreparedStatement stmt = null;
		//	ResultSet rs = null;		//No results needed for INSERT
			
			//Associates SQL attribute data with form input data from addPatient.jsp
			//getParameter() returns a String, so numbers and booleans must be casted
			String query = "INSERT INTO patient (doctor_id, first_name, middle_name, last_name, email, birthday, has_allergy_asthma, has_allergy_xraydye, has_allergy_mridye, has_allergy_latex, notes) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, Integer.parseInt(request.getParameter("doctor_id")));	//getParameter just strings, must cast for other
			stmt.setString(2, request.getParameter("first_name"));
			stmt.setString(3, request.getParameter("middle_name"));
			stmt.setString(4, request.getParameter("last_name"));
			stmt.setString(5, request.getParameter("email"));
			stmt.setString(6, request.getParameter("birthday"));
			stmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("has_allergy_asthma")));
			stmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("has_allergy_xraydye")));
			stmt.setBoolean(9, Boolean.parseBoolean(request.getParameter("has_allergy_mridye")));
			stmt.setBoolean(10, Boolean.parseBoolean(request.getParameter("has_allergy_latex")));
			stmt.setString(11, request.getParameter("notes"));
		//	stmt.setString(12, request.getParameter("phone_number"));		//TODO: No Phone # attribute in db
			stmt.executeUpdate();		//executeUpdate() for INSERT

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

	//	response.sendRedirect(request.getContextPath() + "/addOrder.jsp?pid=" + ""); TODO: ADD patientID

	}
}