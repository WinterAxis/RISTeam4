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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" />
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js" integrity="sha512-pHVGpX7F/27yZ0ISY+VVjyULApbDlD0/X0rgGbTqCE7WFW5MezNTWG/dnhtbBuICzsd0WQPgpE4REBLv+UqChw==" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>		
	<meta charset="UTF-8">
	<title>Patient Portal: Add</title>
</head>
<body>
	<div class="container mt-4">
		<div class="card">
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
              <input type='text' class="form-control datepicker" id="birthday" name="birthday" placeholder="yyyy/mm/dd" />
						</div>
						<div class="col">
							<label for="phone_number">Phone Number</label>
							<input type="text" name="phone_number" class="form-control input-phone" autocomplete="off" maxlength="32" id="phone_number">
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
							<label class="form-check-label" for="xraydye">Xraydye Allergy</label>
							<select class="form-control" id="xraydye"  name="has_allergy_xraydye">
								<option value="False" selected>No</option>
								<option value="True">Yes</option>
							</select>
						</div>
						<div class="col">
							<label class="form-check-label" for="mridye">Mridye Allergy</label>
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
						<label for="latex">Notes</label>
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
			$('#birthday').mask('0000/00/00');
			$('#datepicker input').datepicker({
				format: "yyyy/mm/dd",
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