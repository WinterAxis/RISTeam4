package database;
//displayPatients.java

//fetches ALL entries in Patients table
import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/displayPatients")
public class displayPatients extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request, response);
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
			ResultSet rs = null;
		
			String query = "select * from patient";
			stmt = conn.prepareStatement(query);
			//stmt.setString(1, "*");
			
			
			rs = stmt.executeQuery();	//executeQuery() for SELECT
			out.println("Patient List\nFirst\tLast\tID");
			while(rs.next())
			{
				out.println(rs.getString("first_name")+"\t"+rs.getString("last_name")+"\t"+rs.getInt("patient_id"));
			}
			
			//Closes open DB communication
			stmt.close();
			rs.close();
			conn.close();

		}catch(SQLException se){
			out.println("SQL Error");
			//Handle errors for JDBC
			se.printStackTrace();
		}catch(Exception e){
			out.println("Likely Class Error");
			//Handle errors for Class.forName
			e.printStackTrace();
		}

		out.println("Goodbye from Servlet");
		System.out.println("Goodbye!");
	}
}