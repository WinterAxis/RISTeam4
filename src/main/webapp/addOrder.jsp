<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*"%>
<%@page import="database.dbConnector"%>

<%-- Insert On Post --%>
<% 
  if (request.getParameter("submit") != null) {
    try {
      Connection conn = dbConnector.dbConnect();	
	    PreparedStatement stmt = null;
      String query = "INSERT INTO `order` (patient_id, status_id, modality_id, vist_reason, imaging_needed, notes) VALUES (?,?,?,?,?,?);";
      stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
      stmt.setInt(1, Integer.parseInt(request.getParameter("patient_id")));
      stmt.setInt(2, Integer.parseInt(request.getParameter("status_id")));
      stmt.setInt(3, Integer.parseInt(request.getParameter("modality_id")));
      stmt.setString(4, request.getParameter("vist_reason"));
      stmt.setString(5, request.getParameter("imaging_needed"));
      stmt.setString(6, request.getParameter("notes"));
      stmt.executeUpdate();

      ResultSet rs=stmt.getGeneratedKeys();
			int id = 0;
			if(rs.next()){
				id=rs.getInt(1);
			} 
      String url = "index.jsp?oid="+id;
      response.sendRedirect(url);

      conn.close();
      stmt.close();
      out.println("Added Successfully.");
    } catch (Exception e) {
      e.printStackTrace();
    }
  } else {
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
  <%-- include shared nav bar --%>
	<jsp:include page="\navBar.jsp" />
	
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
        <form action="addOrder.jsp" name="order" method="post">
          <input type="hidden" name="patient_id" value="<%=request.getParameter("pid") %>">
          <input type="hidden" name="status_id" value="1">
          <div class="form-row">
            <div class="col">
              <label for="vist_reason">Visit Reason:</label>
							<input type="text" class="form-control" maxlength="150" name="vist_reason">
            </div>
            <div class="col">
              <label for="imaging_needed">Imaging Needed:</label>
							<input type="text" class="form-control" maxlength="150" name="imaging_needed">
            </div>
            <div class="col">
							<label for="modality_id">Modality Type:</label>
							<select class="form-control" id="modality_id"  name="modality_id">
                <option value="">---------</option>
								<% 
								try{
                  conn = dbConnector.dbConnect();	
	                stmt = null;
	                rs = null;
									String query = "SELECT * FROM modality";
									stmt = conn.prepareStatement(query);
									rs = stmt.executeQuery();
									while(rs.next()){
								%>
								<option value="<%=rs.getInt("modality_id") %>"><%=rs.getString("name") %></option>
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
          <div class="form-row mt-2">
						<label for="notes">Order Notes</label>
						<textarea class="form-control" id="notes" rows="3" maxlength="1000" name="notes"></textarea>
					</div>
          <div class="form-row mt-2">
						<button type="submit" class="btn btn-primary" name="submit" value="submit">Submit New Order</button>
					</div>
        </form>
      </div>
    </div>
	</div>
	<script>
		$(document).ready(function(){
			$("form[name='order']").validate({
				// Specify validation rules
				rules: {
					// The key name on the left side is the name attribute
					// of an input field. Validation rules are defined
					// on the right side
					vist_reason: "required",
					imaging_needed: "required",
          modality_id: {
						required: true,
						minlength: 1
					}
				},
				// Specify validation error messages
				messages: {
					vist_reason: "Please enter the reason for the vist",
					imaging_needed: "Please enter what imaging is needed",
					modality_id: "Please select a modality type",
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
<% } %>