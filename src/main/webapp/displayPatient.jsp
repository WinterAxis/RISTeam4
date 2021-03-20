<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>

<% 
  if (session.getAttribute("role_id") == null) {
    response.sendRedirect("login.jsp");
  }

  String fName = "";
  String mName = "";
  String lName = "";
  Date DOB = null;
  String phone_number = "";
  String email = "";
  boolean xraydye = false;
  boolean mridye = false;
  boolean asthma = false;
  boolean latex = false;
  String patient_notes = "";
  String patient_id = "";
  String error = "";

  Connection conn = dbConnector.dbConnect();	
  PreparedStatement stmt = null;
  ResultSet rs = null;
  if (request.getParameter("pid") != null) {
    patient_id = request.getParameter("pid");
  }
  if (request.getParameter("patient_id") != null) { 
    if (request.getParameter("patient_id") != "") {
      patient_id = request.getParameter("patient_id");
      try {
        String query = "UPDATE `patient` SET `first_name`=?,`middle_name`=?,`last_name`=?,`email`=?,`birthday`=?,`phone_number`=?,`has_allergy_asthma`=?,`has_allergy_xraydye`=?,`has_allergy_mridye`=?,`has_allergy_latex`=?,`notes`=? WHERE patient_id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, request.getParameter("first_name"));
        stmt.setString(2, request.getParameter("middle_name"));
        stmt.setString(3, request.getParameter("last_name"));
        stmt.setString(4, request.getParameter("email"));
        stmt.setString(5, request.getParameter("birthday"));
        stmt.setString(6, request.getParameter("phone_number"));
        stmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("has_allergy_asthma")));
        stmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("has_allergy_xraydye")));
        stmt.setBoolean(9, Boolean.parseBoolean(request.getParameter("has_allergy_mridye")));
        stmt.setBoolean(10, Boolean.parseBoolean(request.getParameter("has_allergy_latex")));
        stmt.setString(11, request.getParameter("notes"));
        stmt.setString(12, request.getParameter("patient_id"));

        stmt.executeUpdate();
        conn.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
      conn = dbConnector.dbConnect();
      stmt = null;
      rs = null;
    }
    else {
      error = "Please do not use this from to try and add new patients.";
    }
  }

  try {
    String query = "SELECT * FROM `patient` WHERE patient_id = ?";
    stmt = conn.prepareStatement(query);
    stmt.setString(1, patient_id);
    rs = stmt.executeQuery();
    patient_id = "";
    if (!rs.isBeforeFirst()) {
    } else {
      while(rs.next()) { 
        patient_id = rs.getString("patient_id");
        fName = rs.getString("first_name");
        mName = rs.getString("middle_name");
        lName = rs.getString("last_name");
        DOB = rs.getDate("birthday");
        phone_number = rs.getString("phone_number"); 
        email = rs.getString("email");
        xraydye = rs.getBoolean("has_allergy_xraydye");
        mridye = rs.getBoolean("has_allergy_mridye");
        asthma = rs.getBoolean("has_allergy_asthma");
        latex = rs.getBoolean("has_allergy_latex");
        patient_notes = rs.getString("notes");
      }
    }
    conn.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
%>
<!DOCTYPE html>
<html>
<head>
	<%-- include shared head links --%>
	<jsp:include page="\headLinks.jsp" />		
	<meta charset="UTF-8">
	<title>Patient Portal: Display</title>
</head>
<body>
  <%-- include shared nav bar --%>
	<jsp:include page="\navBar.jsp" />
	
	<div class="container mt-4">

    <div class="row">
			<div class="col-lg-8 mb-4"> 
				<div class="card mt-4">
          <div class="card-header">
            <div class="row">
              <div class="col-10">
                Patient Information
              </div>
              <div class="custom-control custom-switch col-2">
                <input type="checkbox" class="custom-control-input" id="editSwitch">
                <label class="custom-control-label" onClick="toggleForm();" for="editSwitch">Edit</label>
              </div>
            </div>
          </div>
          <div class="card-body">
            <form action="displayPatient.jsp" id="patient" name="patient" method="post">
              <%=error %>
                <input type="hidden" id="patient_id" name="patient_id" value="<%=patient_id %>">
              <div class="form-row">
                <div class="col">
                  <label for="first_name">First Name</label>
                  <input type="text" class="form-control" maxlength="25" name="first_name" value="<%=fName %>" placeholder="First name">
                </div>
                <div class="col">
                  <label for="middle_name">Middle Name</label>
                  <input type="text" class="form-control" maxlength="25" name="middle_name" value="<%=mName %>" placeholder="Middle name">
                </div>
                <div class="col">
                  <label for="last_name">Last Name</label>
                  <input type="text" class="form-control" maxlength="25" name="last_name" value="<%=lName %>" placeholder="Last name">
                </div>
              </div>
              <div class="form-row mt-2">
                <div class="col">
                  <label for="email">Email</label>
                  <input type="email" class="form-control" id="email" maxlength="150" required="" name="email" value="<%=email %>" placeholder="email@example.com">
                </div>
                <div class="col" id="datepicker">
                  <label for="birthday">Birthday</label>
                  <input type='text' class="form-control datepicker" id="birthday" name="birthday" value="<%=DOB %>" placeholder="yyyy-mm-dd"/>
                </div>
                <div class="col">
                  <label for="phone_number">Phone Number</label>
                  <input type="text" class="form-control input-phone" id="phone_number" name="phone_number" maxlength="32" value="<%=phone_number %>" placeholder="### ### ####" >
                </div>
              </div>
              <div class="form-row mt-2">
                <div class="col">
                  <label class="form-check-label" for="asthma">Asthma Allergy</label>
                  <select class="form-control" id="asthma"  name="has_allergy_asthma">
                    <option value="False" <% if(!asthma){out.print("selected");} %>>No</option>
                    <option value="True" <% if(asthma){out.print("selected");} %>>Yes</option>
                  </select>
                </div>
                <div class="col">
                  <label class="form-check-label" for="xraydye">X-ray Dye Allergy</label>
                  <select class="form-control" id="xraydye"  name="has_allergy_xraydye">
                    <option value="False" <% if(!xraydye){out.print("selected");} %>>No</option>
                    <option value="True" <% if(xraydye){out.print("selected");} %>>Yes</option>
                  </select>
                </div>
                <div class="col">
                  <label class="form-check-label" for="mridye">MRI Dye Allergy</label>
                  <select class="form-control" id="mridye"  name="has_allergy_mridye">
                    <option value="False" <% if(!mridye){out.print("selected");} %>>No</option>
                    <option value="True" <% if(mridye){out.print("selected");} %>>Yes</option>
                  </select>
                </div>
                <div class="col">
                  <label class="form-check-label" for="latex">Latex Allergy</label>
                  <select class="form-control" id="latex"  name="has_allergy_latex">
                    <option value="False" <% if(!latex){out.print("selected");} %>>No</option>
                    <option value="True" <% if(latex){out.print("selected");} %>>Yes</option>
                  </select>
                </div>
              </div>
              <div class="form-row mt-2">
                <label for="notes">Notes</label>
                <textarea class="form-control" id="notes" rows="3" maxlength="1000" name="notes"><%=patient_notes %></textarea>
              </div>
              <div class="form-row mt-2">
                <button type="submit" class="btn btn-primary" value="submit">Submit</button>
              </div>
            </form>
          </div>
        </div> 
			</div>
			<div class="col-lg-4 mb-4">
        <div class="row text-center">
          <div class="col">
            <div class="card mt-4">
              <div class="card-header">
                Active Orders
              </div> 
              <div class="card-body"> 
                <table class="table">
                  <thead>
                    <tr>
                        <th scope="col">Order#</th>
                        <th scope="col">Patient</th>
                        <th scope="col">Stage</th>
                    </tr>
                  </thead>
                  <tbody>
                  <% 
                    try {
                      conn = dbConnector.dbConnect();
                      stmt = null;
                      rs = null;
                      String query = "SELECT `order`.`order_id`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `status`.`name` AS status_name FROM `order` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` INNER JOIN `status` ON `order`.`status_id` = `status`.`status_id` WHERE `order`.`status_id` in (1,2,3) AND `order`.`patient_id` = ? ORDER BY `order`.`status_id`";
                      stmt = conn.prepareStatement(query);
                      stmt.setString(1, request.getParameter("pid"));
                      rs = stmt.executeQuery();
                      if (!rs.isBeforeFirst()) {
                  %>
                    <tr>
                      <td colspan="6" class="text-center text-muted">
                        No orders
                      </td>
                    </tr>
                  <%
                      } else {
                        while(rs.next()) {
                          String name = rs.getString("first_name");
                          if (rs.getString("middle_name") != null) {
                            name += " "+rs.getString("middle_name");
                          }
                          name += " "+rs.getString("last_name");
                  %>
                    <tr>
                      <td>
                        <a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=rs.getInt("order_id") %></a>
                      </td>
                      <td>
                        <a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=name %></a>
                      </td>
                      <td>
                        <%=rs.getString("status_name") %>
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
              </div> 
            </div>
          </div>
          <div class="col">
            <div class="card mt-4">
              <div class="card-header">
                Completed Orders
              </div> 
              <div class="card-body"> 
                <table class="table">
                  <thead>
                    <tr>
                        <th scope="col">Order#</th>
                        <th scope="col">Patient</th>
                        <th scope="col">Completed</th>
                    </tr>
                  </thead>
                  <tbody>
                  <% 
                    try {
                      conn = dbConnector.dbConnect();
                      stmt = null;
                      rs = null;
                      String query = "SELECT `order`.`order_id`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `order`.`date_completed` FROM `order` INNER JOIN `patient` ON `order`.`patient_id` = `patient`.`patient_id` WHERE `order`.`status_id` = 4 AND `order`.`patient_id` = ? ORDER BY `order`.`status_id`";
                      stmt = conn.prepareStatement(query);
                      stmt.setString(1, request.getParameter("pid"));
                      rs = stmt.executeQuery();
                      if (!rs.isBeforeFirst()) {
                  %>
                    <tr>
                      <td colspan="6" class="text-center text-muted">
                        No orders
                      </td>
                    </tr>
                  <%
                      } else {
                        while(rs.next()) {
                          String name = rs.getString("first_name");
                          if (rs.getString("middle_name") != null) {
                            name += " "+rs.getString("middle_name");
                          }
                          name += " "+rs.getString("last_name");
                  %>
                    <tr>
                      <td>
                        <a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=rs.getInt("order_id") %></a>
                      </td>
                      <td>
                        <a href="displayOrder.jsp?oid=<%=rs.getInt("order_id") %>"><%=name %></a>
                      </td>
                      <td>
                        <%=rs.getDate("date_completed") %>
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
              </div> 
            </div>
          </div>
        </div> 
			</div>
		</div>



	</div>

  <br>
	<br>
	<script>

    function toggleForm() {
      if($("#editSwitch").prop("checked")) {
        $("#patient :input").prop("disabled", true);
      }
      else {
        $("#patient :input").prop("disabled", false);
      }
    }
		$(document).ready(function(){
      $("#editSwitch").prop("checked", false);
      $("#patient :input").prop("disabled", true);

			$('#phone_number').mask('000 000 0000');
			$('#birthday').mask('0000-00-00');
			$('#datepicker input').datepicker({
				format: "yyyy-mm-dd",
				orientation: "bottom right",
				calendarWeeks: true
			});

			$("form[name='patient']").validate({
				// Specify validation rules
				rules: {
					// The key name on the left side is the name attribute
					// of an input field. Validation rules are defined
					// on the right side
					first_name: {
						required: true,
						minlength: 1
					},
					last_name: {
						required: true,
						minlength: 1
					},
					email: {
						required: true,
						email: true
					},
					birthday: {
						required: true,
						minlength: 10
					},
					phone_number: {
						required: true,
						minlength: 12
					}
				},
				// Specify validation error messages
				messages: {
					firstname: "Please enter your first name",
					lastname: "Please enter your last name",
					email: "Please enter a valid email address",
					birthday: {
						required: "Please provide a birthday",
						minlength: "Birthday incomplete"
					},
					phone_number: {
						required: "Please provide a phone number",
						minlength: "Phone number incomplete"
					},
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