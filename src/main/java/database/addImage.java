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

@WebServlet("/addImage")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class addImage extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
  {
    //Do POST to pass patient data
    doPost(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
    InputStream inputStream = null; // input stream of the upload file
    
    // obtains the upload file part in this multipart request
    Part filePart = request.getPart("photo");
    if (filePart != null) {
      // prints out some information for debugging
      System.out.println(filePart.getName());
      System.out.println(filePart.getSize());
      System.out.println(filePart.getContentType());

      // obtains input stream of the upload file
      inputStream = filePart.getInputStream();
    }

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
      // connects to the database
      // constructs SQL statement
      String sql = "INSERT INTO image (label, photo, user) values (?, ?, ?)";
      PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
      stmt.setString(1, request.getParameter("label"));
      stmt.setString(3, request.getParameter("user"));
        
      if (inputStream != null) {
        // fetches input stream of the upload file for the blob column
        stmt.setBlob(2, inputStream);
      }

      // sends the statement to the database server
      stmt.executeUpdate();
      ResultSet rs=stmt.getGeneratedKeys();
      int id = 0;
      if(rs.next()){
        id = rs.getInt(1);
        conn = DriverManager.getConnection(DB_URL,USER,PASS);
        stmt = null;
        String query = "UPDATE `order` SET `image_id` = ?, `status_id` = 3 WHERE `order`.`order_id` = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, id);
        stmt.setString(2, request.getParameter("oid"));
        stmt.executeUpdate();
      }
      response.sendRedirect("index.jsp");


    } catch (SQLException ex) {
        ex.printStackTrace();
    } 
  }
}