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
	<title>Patient Portal: Add</title>
</head>
<body>
	<div class="container mt-4">
		<div class="display-4 text-center">
      New Patient Form
    </div>
		<div class="card mt-4">
			<div class="card-header">
				Add Patient Information
			</div>
			<div class="card-body">
				<form action="addPatient" name="patient" method="post">
					<div class="form-row">
						<div class="col">
							<label class="form-check-label" for="doctor_id">Refering Physician</label>
							<select class="form-control" id="doctor_id"  name="doctor_id">
								<% 
								try{
									String query = "SELECT user_id, first_name, last_name FROM user WHERE role_id = 1";
									stmt = conn.prepareStatement(query);
									rs = stmt.executeQuery();
									while(rs.next()){
								%>
								<option value="<%=rs.getInt("user_id") %>"><%=rs.getString("first_name") %> <%=rs.getString("last_name") %></option>
								<% 
									}
									conn.close();
								} catch (Exception e) {
									e.printStackTrace();
								} 
								%>
							</select>
						</div>
					</div>
					<div class="form-row">
						<div class="col">
							<label for="first_name">First Name</label>
							<input type="text" class="form-control" maxlength="25" name="first_name" placeholder="First name">
						</div>
						<div class="col">
							<label for="middle_name">Middle Name</label>
							<input type="text" class="form-control" maxlength="25" name="middle_name" placeholder="Middle name">
						</div>
						<div class="col">
							<label for="last_name">Last Name</label>
							<input type="text" class="form-control" maxlength="25" name="last_name" placeholder="Last name">
						</div>
					</div>
					<div class="form-row mt-2">
						<div class="col">
							<label for="email">Email</label>
							<input type="email" class="form-control" id="email" maxlength="150" required="" name="email" placeholder="email@example.com">
						</div>
						<div class="col" id="datepicker">
							<label for="birthday">Birthday</label>
              <input type='text' class="form-control datepicker" id="birthday" name="birthday" placeholder="yyyy-mm-dd" />
						</div>
						<div class="col">
							<label for="phone_number">Phone Number</label>
							<input type="text" class="form-control input-phone" id="phone_number" name="phone_number" maxlength="32" placeholder="### ### ####" >
						</div>
					</div>
					<div class="form-row mt-2">
						<div class="col">
							<label class="form-check-label" for="asthma">Asthma Allergy</label>
							<select class="form-control" id="asthma"  name="has_allergy_asthma">
								<option value="False" selected>No</option>
								<option value="True">Yes</option>
							</select>
						</div>
						<div class="col">
							<label class="form-check-label" for="xraydye">X-ray Dye Allergy</label>
							<select class="form-control" id="xraydye"  name="has_allergy_xraydye">
								<option value="False" selected>No</option>
								<option value="True">Yes</option>
							</select>
						</div>
						<div class="col">
							<label class="form-check-label" for="mridye">MRI Dye Allergy</label>
							<select class="form-control" id="mridye"  name="has_allergy_mridye">
								<option value="False" selected>No</option>
								<option value="True">Yes</option>
							</select>
						</div>
						<div class="col">
							<label class="form-check-label" for="latex">Latex Allergy</label>
							<select class="form-control" id="latex"  name="has_allergy_latex">
								<option value="False" selected>No</option>
								<option value="True">Yes</option>
							</select>
						</div>
					</div>
					<div class="form-row mt-2">
						<label for="notes">Notes</label>
						<textarea class="form-control" id="notes" rows="3" maxlength="1000" name="notes"></textarea>
					</div>
					<div class="form-row mt-2">
						<button type="submit" class="btn btn-primary" value="submit">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function(){
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
					first_name: "required",
					last_name: "required",
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