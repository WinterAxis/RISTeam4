<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>
<%
	Connection conn = dbConnector.dbConnect();	
	PreparedStatement stmt = null;
	ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
	<%-- include shared head links --%>
	<jsp:include page="\headLinks.jsp" />		
	<meta charset="UTF-8">
	<title>Patient Portal: Look Up</title>
</head>
<body>
	<div class="container mt-4">
    <div class="display-4 text-center">
      Patient Lookup Table
    </div>
		<div class="card mt-4">
      <div class="card-header">
        Search Patients
      </div>
			<div class="card-body">
				<form action="lookUpPatient.jsp" name="lookUP" method="post">
					<div class="form-row mt-2">
            <div class="col-9 input-group" id="datepicker">
              <div class="input-group-prepend">
                <span class="input-group-text">Date of Birth</span>
              </div>
              <input type='text' class="form-control datepicker" id="DOB" name="DOB" placeholder="yyyy-mm-dd" />
            </div>
            <div class="col-3">
              <button type="submit" class="btn btn-primary" name="submit" value="submit">Search</button>
              <a class="btn btn-outline-secondary" href="addPatient.jsp" role="button">New Patient</a>
            </div>
					</div>
				</form>
			</div>
      <div class="card-footer">
        <% 
        if (request.getParameter("submit") != null) {
          try {
            String query = "SELECT patient_id, first_name, last_name, birthday, phone_number, email FROM patient WHERE birthday = '"+request.getParameter("DOB")+"'";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();
            if (!rs.isBeforeFirst()) {
        %>
        <div class='test-center'>No Patients with a <%= request.getParameter("DOB")%> Date of Birth</div>
        <div class='test-center'><%= query%></div>
        <%
            } else {

            
        %>
        <table class="table">
          <thead>
            <tr>
                <th scope="col">First</th>
                <th scope="col">Last</th>
                <th scope="col" class="d-none d-md-table-cell">Birth Date</th>
                <th scope="col" class="d-none d-md-table-cell">Phone Number</th>
                <th scope="col" class="d-none d-md-table-cell">Email</th>
                <th scope="col" class="d-none d-md-table-cell text-muted">
                    <i class="fas fa-info" aria-hidden="true"></i>
                </th>
            </tr>
          </thead>
          <tbody>
        <%
              while(rs.next()) { 
        %>
            <tr>
              <td>
                <a class="orderlink" href="#"><%=rs.getString("first_name") %></a>
                <div class="text-muted small d-md-none">
                        Birth Date:<br><%=rs.getDate("birthday") %>
                </div>
              </td>
              <td>
                <a class="orderlink" href="#"><%=rs.getString("last_name") %></a>
                <div class="d-md-none">
                  <a class="text-muted small" href="#">See more</a>
                </div>
              </td>
              <td class="d-none d-md-table-cell"><%=rs.getDate("birthday") %></td>
              <td class="d-none d-md-table-cell"><%=rs.getString("phone_number") %></td>
              <td class="d-none d-md-table-cell"><%=rs.getString("email") %></td>
              <td class="text-center d-none d-md-table-cell">
                  <a class="patientlink" href="#">
                      <i class="fas fa-info-circle" aria-hidden="true"></i>
                  </a>
              </td>
            </tr>
        <%      
              }
            }
            conn.close();
          } catch (Exception e) {
            e.printStackTrace();
          }
        %>
          <tbody>
        </table>
        <%
        }
        %>
      </div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			$('#DOB').mask('0000-00-00');
      $('#datepicker input').datepicker({
				format: "yyyy-mm-dd",
				orientation: "bottom right",
				calendarWeeks: true
			});
      $("form[name='lookUP']").validate({
				// Specify validation rules
				rules: {
					// The key name on the left side is the name attribute
					// of an input field. Validation rules are defined
					// on the right side
					DOB: {
						required: true,
						minlength: 10
					}
				},
				// Specify validation error messages
				messages: {
					DOB: {
						required: "Please provide a Date of Birth",
						minlength: "Birthday incomplete"
					}
				},
				// Make sure the form is submitted to the destination defined
				// in the "action" attribute of the form when valid
				submitHandler: function(form) {
					form.submit();
				}
			});
		});
		
	</script>
</body>
</html>