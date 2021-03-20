<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="database.dbConnector"%>




<%
  int role = 0;
  int user = 0;
  Boolean error = false;
	Connection conn = dbConnector.dbConnect();	
	PreparedStatement stmt = null;
	ResultSet rs = null;
  if (request.getParameter("password") != null) {
    MessageDigest digest = MessageDigest.getInstance("SHA-256");
    byte[] encodedhash = digest.digest(request.getParameter("password").getBytes(StandardCharsets.UTF_8));
    StringBuilder hexString = new StringBuilder(2 * encodedhash.length);
    for (int i = 0; i < encodedhash.length; i++) {
        String hex = Integer.toHexString(0xff & encodedhash[i]);
        if(hex.length() == 1) {
            hexString.append('0');
        }
        hexString.append(hex);
    }
    String passwordHash = hexString.toString();

    String query = "SELECT `user_id`, `role_id`, `username`, `first_name`, `middle_name`, `last_name` FROM `user` WHERE `username` = ? AND `password` = ?";
    stmt = conn.prepareStatement(query);
    stmt.setString(1, request.getParameter("username"));
    stmt.setString(2, passwordHash);
    rs = stmt.executeQuery();
    if (!rs.isBeforeFirst()) {
      error = true;
    } else {
      while(rs.next()) { 
        user = rs.getInt("user_id");
        role = rs.getInt("role_id");
        String name = rs.getString("first_name");
        if (rs.getString("middle_name") != null) {
          name += " "+rs.getString("middle_name");
        }
        name += " "+rs.getString("last_name");
        session.setAttribute("user_id", user);
        session.setAttribute("role_id", role);
        session.setAttribute("username", rs.getString("username"));
        session.setAttribute("name", name);
      }
      response.sendRedirect("index.jsp");
    }
  }
  
%>
<!DOCTYPE html>
<html>
<head>
	<%-- include shared head links --%>
	<jsp:include page="\headLinks.jsp" />	
	<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>
  <div class="container">
    <div class="row ">
      <div class="col">
        <br>
        <br>
        <div class="card mt-4">
          <div class="card-body text-center">
            <form action="login.jsp" name="login" method="post"">
              <h1><i class="fas fa-x-ray"></i></h1>
              <h1 class="h3 mb-3 font-weight-normal">Xamine RIS</h1>
              <%
                if (error) {
                  out.print("<h6>Incorect Username or Password</h6>");
                }
              %>
              <div id="div_id_username" class="form-group"> 
                <label for="id_username" class=" requiredField">
                  Username<span class="asteriskField">*</span> 
                </label> 
                <div class=""> 
                  <input type="text" name="username" autofocus autocapitalize="none" autocomplete="username" maxlength="150" class="textinput textInput form-control" required id="id_username"> 
                </div> 
              </div> 
              <div id="div_id_password" class="form-group"> 
                <label for="id_password" class=" requiredField">
                  Password<span class="asteriskField">*</span> 
                </label> 
                <div class=""> 
                  <input type="password" name="password" autocomplete="current-password" class="textinput textInput form-control" required id="id_password"> 
                </div> 
              </div>
          
              <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    
  </div>
	
</body>
</html>
