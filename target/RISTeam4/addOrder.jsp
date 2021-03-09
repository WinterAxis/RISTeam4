<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>
<%
  String pName = "";
  Date DOB = null;
  String phone_number = "";
  String email = "";
  boolean xraydye = false;
  boolean mridye = false;
  boolean asthma = false;
  boolean latex = false;
  String notes = "";

	Connection conn = dbConnector.dbConnect();	
	PreparedStatement stmt = null;
	ResultSet rs = null;
  if (request.getParameter("pid") != null) {
    try {
      String query = "SELECT * FROM patient WHERE patient_id = ?";
      stmt = conn.prepareStatement(query);
      stmt.setString(1, request.getParameter("pid"));
      rs = stmt.executeQuery();
      if (!rs.isBeforeFirst()) {
      } else {
        while(rs.next()) { 
          pName = rs.getString("first_name");
          if (rs.getString("middle_name") != null){
            pName += " "+rs.getString("middle_name");
          }
          pName += " "+rs.getString("last_name");
          DOB = rs.getDate("birthday");
          String[] temp = rs.getString("phone_number").split(" "); 
          phone_number = "("+temp[0]+") "+temp[1]+"-"+temp[2];
          email = rs.getString("email");
          xraydye = rs.getBoolean("has_allergy_xraydye");
          mridye = rs.getBoolean("has_allergy_mridye");
          asthma = rs.getBoolean("has_allergy_asthma");
          latex = rs.getBoolean("has_allergy_latex");
          notes = rs.getString("notes");
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
	<title>Order Portal: Add</title>
</head>
<body>
	<div class="container mt-4">
		<div class="display-4 text-center">
      New Referral Order
    </div>
		<div class="card mt-4">
			<div class="card-header text-center">
				Patient Information
			</div>
			<div class="card-body">
        <div class="row">
          <div class="col">
            <div class="row">
              <div class="col-md-3 col-12 mt-2">
                <div class="font-weight-bold">
                  Patient Name:
                </div>
                <%=pName %>
              </div>
              <div class="col-md-3 col-12 mt-2">
              <div class="font-weight-bold">
                Date of Birth:
              </div>
              <%=DOB %>
              </div>
              <div class="col-md-3 col-12 mt-2">
                <div class="font-weight-bold">
                  Phone Number:
                </div>
                <%=phone_number %>
              </div>
              <div class="col-md-3 col-12 mt-2">
                <div class="font-weight-bold">
                  Email:
                </div>
                <%=email %>
              </div>      
            </div>
          </div>
          <div class="col-md-2 col-12 text-md-center mt-2">
            <div class="font-weight-bold">
              Allergy list:
            </div>
            <ul class="list-unstyled ">
              <%
                if (xraydye) {
                  out.println("<li>X-Ray Dye</li>");
                }
                if (mridye) {
                  out.println("<li>MRI Dye</li>");
                }
                if (asthma) {
                  out.println("<li>Asthma</li>");
                }
                if (latex) {
                  out.println("<li>Latex</li>");
                }
              %>
            </ul>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="font-weight-bold">
              Patient Notes:
            </div>
            <p>
              <%=notes %>
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
        <form action="addPatient" name="patient" method="post"></form>
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