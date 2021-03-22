<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<% 
  int role = 0;
  if (session.getAttribute("role_id") == null) {
    response.sendRedirect("login.jsp");
  }
  else {
    role = (int) session.getAttribute("role_id");
  }
  


  SimpleDateFormat time_formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm a"); 
  int pid = 0;
  int sid = 0;
  int mid = 0;
  int iid = 0;
  String appointment = "None";
  String visit_reason = "";
  String imaging_needed = "";
  String order_notes = "";
  String report = "";  
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
  String modality = "";
  String team = "none";

  Connection conn = dbConnector.dbConnect();	
  PreparedStatement stmt = null;
  ResultSet rs = null;
  if ("schedule".equals(request.getParameter("action"))) {
    SimpleDateFormat displayFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    SimpleDateFormat parseFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
    java.util.Date date = parseFormat.parse(request.getParameter("appointment")+" "+request.getParameter("time"));
    
    String query = "UPDATE `order` SET `appointment` = ? WHERE `order`.`order_id` = ?";
    stmt = conn.prepareStatement(query);
    stmt.setString(1, displayFormat.format(date));
    stmt.setString(2, request.getParameter("oid"));
    stmt.executeUpdate();
    conn = dbConnector.dbConnect();
    stmt = null;
  }

  if ("checkin".equals(request.getParameter("action"))) {
    String query = "UPDATE `order` SET `team_id` = ?, `status_id` = 2 WHERE `order`.`order_id` = ?";
    stmt = conn.prepareStatement(query);
    stmt.setString(1, request.getParameter("team_id"));
    stmt.setString(2, request.getParameter("oid"));
    stmt.executeUpdate();
    conn = dbConnector.dbConnect();
    stmt = null;
  }

  if (request.getParameter("submit_report") != null) {
    SimpleDateFormat date_formatter = new SimpleDateFormat("yyyy-MM-dd"); 
    String query = "UPDATE `order` SET `report` = ?, `date_completed` = ?, `status_id` = 4 WHERE `order`.`order_id` = ?";
    stmt = conn.prepareStatement(query);
    stmt.setString(1, request.getParameter("report"));
    stmt.setString(2, date_formatter.format(new Date()));
    stmt.setString(3, request.getParameter("oid"));
    stmt.executeUpdate();
    conn = dbConnector.dbConnect();
    stmt = null;
  }

  if (request.getParameter("save_report") != null) {
    String query = "UPDATE `order` SET `report` = ? WHERE `order`.`order_id` = ?";
    stmt = conn.prepareStatement(query);
    stmt.setString(1, request.getParameter("report"));
    stmt.setString(2, request.getParameter("oid"));
    stmt.executeUpdate();
    conn = dbConnector.dbConnect();
    stmt = null;
  }

  if (request.getParameter("oid") != null) {
    try {
      // inner join statment for table order, paitent, and modality
      String query = "SELECT `order`.`order_id`, `order`.`patient_id`, `order`.`status_id`, `order`.`modality_id`, `order`.`image_id`, `order`.`appointment`, `order`.`visit_reason`, `order`.`imaging_needed`, `order`.`notes` as order_notes, `order`.`report`, `patient`.`first_name`, `patient`.`middle_name`, `patient`.`last_name`, `patient`.`birthday`, `patient`.`phone_number`, `patient`.`email`, `patient`.`has_allergy_xraydye`, `patient`.`has_allergy_mridye`, `patient`.`has_allergy_asthma`, `patient`.`has_allergy_latex`, `patient`.`notes` as patient_notes, `team`.`name` as team_name, `modality`.`name` as modality_name FROM `order` INNER JOIN `patient` ON `order`.`patient_id`=`patient`.`patient_id` INNER JOIN `modality` ON `order`.`modality_id`=`modality`.`modality_id` LEFT JOIN `team` ON `order`.`team_id`=`team`.`team_id` WHERE order_id = ?";
      stmt = conn.prepareStatement(query);
      stmt.setString(1, request.getParameter("oid"));
      rs = stmt.executeQuery();
      if (!rs.isBeforeFirst()) {
      } else {
        while(rs.next()) { 
          pid = rs.getInt("patient_id");
          sid = rs.getInt("status_id");
          mid = rs.getInt("modality_id");
          iid = rs.getInt("image_id");
          if (rs.getTimestamp("appointment") != null)
            appointment = time_formatter.format(rs.getTimestamp("appointment"));
          visit_reason = rs.getString("visit_reason");
          imaging_needed = rs.getString("imaging_needed");
          order_notes = rs.getString("order_notes");
          if (rs.getString("report") != null)
            report = rs.getString("report");

          fName = rs.getString("first_name");
          mName = rs.getString("middle_name");
          lName = rs.getString("last_name");
          DOB = rs.getDate("birthday");
          String[] temp = rs.getString("phone_number").split(" "); 
          phone_number = "("+temp[0]+") "+temp[1]+"-"+temp[2];
          email = rs.getString("email");
          xraydye = rs.getBoolean("has_allergy_xraydye");
          mridye = rs.getBoolean("has_allergy_mridye");
          asthma = rs.getBoolean("has_allergy_asthma");
          latex = rs.getBoolean("has_allergy_latex");
          patient_notes = rs.getString("patient_notes");

          modality = rs.getString("modality_name");

          if (rs.getString("team_name") != null)
            team = rs.getString("team_name");

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
	<title>Order Portal: Display</title>
</head>
<body>
  <%-- include shared nav bar --%>
	<jsp:include page="\navBar.jsp" />
	
	<div class="container mt-4">
    <div class="text-center">
      <div class="display-4">
        Order # <%=request.getParameter("oid") %>
      </div>
      <div class="h5">
        Appointment: <%=appointment %> 
      </div>
    </div>
		

    <%
      if ((role == 2 || role == 5) && sid < 3) {
    %>
    <div class="card mt-4">
			<div class="card-header text-center">
				Receptionist Panel
			</div>
			<div class="card-body">
        <form action="displayOrder.jsp" name="schedule" method="post">
          <input type="hidden" name="action" value="schedule">
          <input type="hidden" name="oid" value="<%=request.getParameter("oid") %>">
					<div class="form-row mt-2">
            <div class="col-9 input-group">
              <div class="input-group-prepend">
                <span class="input-group-text">Appointment Time</span>
              </div>
              <input type='text' class="form-control" id="appointment" name="appointment" placeholder="yyyy-mm-dd" />
              <input class="form-control timepicker" name="time">
            </div>
            <div class="col-3 text-center">
              <button type="submit" class="btn btn-primary" name="submit" value="submit">Schedule</button>
            </div>
					</div>
				</form>
        <% if (sid > 1) { %>
        <div class="text-center mt-2 h5">
          Team: <%=team %> 
        </div>
        <% } else { %>
        <form action="displayOrder.jsp" name="checkin" method="post">
          <input type="hidden" name="action" value="checkin">
          <input type="hidden" name="oid" value="<%=request.getParameter("oid") %>">
					<div class="form-row mt-2">
						<div class="col-9 input-group">
              <div class="input-group-prepend">
                <span class="input-group-text">Team</span>
              </div>
							<select class="form-control" id="team_id"  name="team_id">
								<option value="">---------</option>
								<% 
								try{
                  conn = dbConnector.dbConnect();	
									String query = "SELECT * FROM `team`";
									stmt = conn.prepareStatement(query);
									rs = stmt.executeQuery();
									while(rs.next()){
								%>
								<option value="<%=rs.getInt("team_id") %>"><%=rs.getString("name") %></option>
								<% 
									}
									conn.close();
								} catch (Exception e) {
									e.printStackTrace();
								} 
								%>
							</select>
						</div>
            <div class="col-3 text-center">
              <button type="submit" class="btn btn-primary" name="submit" value="submit">Check In</button>
            </div>
					</div>
        </form>
        <% } %> 
      </div>
    </div>
    <% 
      } 
    %>

		<div class="card mt-4">
			<div class="card-header text-center">
        <div class="row">
          <div class="col-12">
            Patient Information
          </div>
          <div class="col-12">
            <a href="displayPatient.jsp?pid=<%=pid %>" class="text-muted">View More</a>
          </div>
        </div>
			</div>
			<div class="card-body">
        <div class="row">
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              First Name:
            </div>
            <%=fName %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Middle Name:
            </div>
            <%=mName %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Last Name:
            </div>
            <%=lName %>
          </div>
        </div>
        <div class="row">
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              DOB:
            </div>
            <%=DOB %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Phone Number:
            </div>
            <%=phone_number %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Email Address:
            </div>
            <%=email %>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <hr>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              Asthma:
            </div>
            <% 
              if (asthma) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              X-Ray Dye Allergy:
            </div>
            <% 
              if (xraydye) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              MRI Dye Allergy:
            </div>
            <% 
              if (mridye) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
          <div class="col-md-3 col-12 mt-2">
            <div class="font-weight-bold">
              Latex Allergy:
            </div>
            <% 
              if (latex) { 
                out.print("Yes");
              } else {
                out.print("No");
              }
            %>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="font-weight-bold">
              Patient Notes:
            </div>
            <p>
              <%=patient_notes %>
            </p>
          </div>
        </div>
      </div>
		</div>

    <div class="card mt-4">
			<div class="card-header text-center">
				Order Information
			</div>
			<div class="card-body">
        <div class="row">
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Reason for Visit:
            </div>
            <%=visit_reason %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Imaging Needed:
            </div>
            <%=imaging_needed %>
          </div>
          <div class="col-md-4 col-12 mt-2">
            <div class="font-weight-bold">
              Modality:
            </div>
            <%=modality %>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="font-weight-bold">
              Order Notes:
            </div>
            <p>
              <%=order_notes %>
            </p>
          </div>
        </div>
      </div>
    </div>

    <%
      if ((role == 3 || role == 5) && sid == 2) {
    %>
    <div class="card mt-4">
      <div class="card-header text-center">
        Technicain Panel
      </div>
      <div class="card-body">
        <form action="addImage" name="addImage" method="post" enctype="multipart/form-data">
          <input type="hidden" name="oid" value="<%=request.getParameter("oid") %>">
          <input type="hidden" name="user" value="<%=(String)session.getAttribute("username") %>">
          <div class="form-row mt-2">
            <div class="col-9 input-group">
              <div class="input-group-prepend">
                <span class="input-group-text">Photo</span>
              </div>
              <input type='text' class="form-control" id="label" name="label" placeholder="label" />
              <input type="file" class="form-control" name="photo" size="50"/>
            </div>
            <div class="col-3 text-center">
              <button type="submit" class="btn btn-primary" name="submit" value="submit">Schedule</button>
            </div>
          </div>
        </form>
      </div>
    </div>
    <% 
      } 
    %>

    <%
      if (iid != 0) {
    %>
    <div class="card mt-4">
      <div class="card-header text-center">
        Order Image
      </div>
      <div class="card-body">
        <img class="mx-auto d-block" src="getImage?iid=<%=iid %>"/>
      </div>
    </div>
    <% 
      } 
    %>

    <%
      if ((role == 4 || role == 5) && sid == 3) {
    %>
    <div class="card mt-4">
      <div class="card-header text-center">
        Radiologist Panel
      </div>
      <div class="card-body">
        <form action="displayOrder.jsp" name="addReport" method="post">
          <input type="hidden" name="oid" value="<%=request.getParameter("oid") %>">
          <div class="form-row mt-2">
            <label for="notes">Notes</label>
            <textarea class="form-control" id="report" rows="3" maxlength="1000" name="report"><%=report %></textarea>
          </div>
          <div class="form-row mt-2">
            <button type="submit" class="btn btn-primary" name="submit_report" value="submit_report">Submit</button>
            <button type="submit" class="btn btn-secondary" name="save_report" value="save_report">Save</button>
          </div>
        </form>
      </div>
    </div>
    <% 
      } 
    %>
    
    <%
      if (sid > 3) {
    %>
    <div class="card mt-4">
      <div class="card-header text-center">
        Radiologist Report
      </div>
      <div class="card-body">
        <textarea class="form-control" id="report" rows="3" maxlength="1000" name="report" disabled><%=report %></textarea>
      </div>
    </div>
    <% 
      } 
    %>

  </div>
  <br>
	<br>
	<script>
		$(document).ready(function(){
			$('#appointment').mask('0000-00-00');
      $('#appointment').datepicker({
				format: "yyyy-mm-dd",
				orientation: "bottom right",
				calendarWeeks: true
			});
      

      $('.timepicker').timepicker({
          timeFormat: 'h:mm p',
          interval: 15,
          minTime: '10',
          maxTime: '6:00pm',
          defaultTime: '11',
          startTime: '10:00',
          dynamic: false,
          dropdown: true,
          scrollbar: true
      });

      $("form[name='checkin']").validate({
				// Specify validation rules
				rules: {
					team_id: {
						required: true,
						minlength: 1
					}
				},
				// Specify validation error messages
				messages: {
					team_id: "Please select a team"
				},
				// Make sure the form is submitted to the destination defined
				// in the "action" attribute of the form when valid
				submitHandler: function(form) {
					form.submit();
				}
			});

      $("form[name='schedule']").validate({
				// Specify validation rules
				rules: {
					appointment: {
						required: true,
						minlength: 1
					}
				},
				// Specify validation error messages
				messages: {
					required: "Please provide a appointment",
					minlength: "Appointment incomplete"
				},
				// Make sure the form is submitted to the destination defined
				// in the "action" attribute of the form when valid
				submitHandler: function(form) {
					form.submit();
				}
			});

      $("form[name='addImage']").validate({
				// Specify validation rules
				rules: {
					label: {
						required: true,
						minlength: 1
					},
          photo: {
						required: true
					}
				},
				// Specify validation error messages
				messages: {
					team_id: "Please label your",
          photo: "Please add an image"
				},
				// Make sure the form is submitted to the destination defined
				// in the "action" attribute of the form when valid
				submitHandler: function(form) {
					form.submit();
				}
			});

      $("form[name='addReport']").validate({
				// Specify validation rules
				rules: {
					report: {
						required: true
					}
				},
				// Specify validation error messages
				messages: {
					report: "Please provied add a report"
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