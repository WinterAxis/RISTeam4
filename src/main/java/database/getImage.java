package database;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/getImage")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class getImage extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
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
    try {
      String query = "SELECT photo FROM `image` WHERE `image_id` = ?";
      PreparedStatement stmt = conn.prepareStatement(query);
      stmt.setString(1, request.getParameter("iid"));
      ResultSet rs = stmt.executeQuery();
      while(rs.next()){
        OutputStream output = response.getOutputStream();
        response.setContentType("image/gif");
        response.setHeader("expires", "0");

        OutputStream os = response.getOutputStream();
        os.write(rs.getBytes("photo")); 
      }
    } catch (SQLException ex) {
      ex.printStackTrace();
    } 
    return; 
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
    doGet(request, response);
  }
}