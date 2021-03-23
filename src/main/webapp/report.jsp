<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<% 
  SimpleDateFormat time_formatter = new SimpleDateFormat("yyyy-MM-dd"); 

  int iid = 0;
  String date_completed = "None";
  String report = "";  
  String name = "";
  String radiologist = "";

  Connection conn = dbConnector.dbConnect();	
  PreparedStatement stmt = null;
  ResultSet rs = null;

  if (request.getParameter("oid") != null) {
    try {
      // inner join statment for table order, paitent, and modality
      String query = "SELECT `order`.`image_id`, `order`.`date_completed`, `order`.`report`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `user`.`username` FROM `order` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` INNER JOIN `team` ON `order`.`team_id` = `team`.`team_id` INNER JOIN `user` ON `team`.`radiologist_id` = `user`.`user_id` WHERE `order`.`order_id` = ?";
      stmt = conn.prepareStatement(query);
      stmt.setString(1, request.getParameter("oid"));
      rs = stmt.executeQuery();
      if (!rs.isBeforeFirst()) {
      } else {
        while(rs.next()) { 
          iid = rs.getInt("image_id");
          if (rs.getTimestamp("date_completed") != null)
          date_completed = time_formatter.format(rs.getTimestamp("date_completed"));
          if (rs.getString("report") != null)
            report = rs.getString("report");
          name = rs.getString("first_name");
          if (rs.getString("middle_name") != null) {
            name += " "+rs.getString("middle_name");
          }
          name += " "+rs.getString("last_name");
          radiologist = rs.getString("username");
        }
      }
      conn.close();
    } catch (Exception e) {
      e.printStackTrace();
    }

  }
%>
<!DOCTYPE html>
<html>
<head>
	<%-- include shared head links --%>
	<jsp:include page="\headLinks.jsp" />		
	<meta charset="UTF-8">
	<title>Order_<%=request.getParameter("oid") %>_Report</title>
</head>
<body>
  <%-- include shared nav bar --%>
	<div class="container mt-4">
    <div class="text-center">
      <div class="display-4">
        Order # <%=request.getParameter("oid") %>
      </div>
      <div class="h4">
        Patient: <%=name %> 
      </div>
      <div class="h5">
        Completed by <%=radiologist %>  on <%=date_completed %> 
      </div>
    </div>

    <%
      if (iid != 0) {
    %>
    <div class="card mt-4">
      <div class="card-header text-center">
        Order Image
      </div>
      <div class="card-body">
        <img style="display: block;
        margin-left: auto;
        margin-right: auto;
        width: 50%;" 
        src="getImage?iid=<%=iid %>"/>
      </div>
    </div>
    <% 
      } 
    %>
    
    <div class="card mt-4">
      <div class="card-header text-center">
        Radiologist Report
      </div>
      <div class="card-body">
        <p><%=report %></p>
      </div>
    </div>

  </div>
  <br>
	<br>
	
</body>
</html>